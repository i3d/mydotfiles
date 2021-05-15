#!/usr/bin/python

"""Refresh various daily google credentials.

From the Mac Road Warrior guide: http://wiki/Main/MacRoadWarrior
"""

import argparse
import getpass
import os
import platform
import subprocess
import sys

################################################################################
# Edit these variables to suit your preferences, or set them via shell
# environment variables, replacing "DEFAULT_" by "AUTH_".
################################################################################

# Default host name for prodaccess. Can be overridden by command line. You may
# specify multiple hostnames by delimiting with spaces. Hostnames may be
# unqualified (e.g. 'myhostname'), partially qualified (e.g. 'myhostname.mtv'),
# or fully qualified (e.g. 'myhostname.mtv.corp.google.com').
DEFAULT_HOST = 'ujimux.c.googlers.com'

# Default site subdomain when none specified (mtv, nyc, sfo etc.).
DEFAULT_CORP_SUBDOMAIN = ''

# Default corp domain when none specified (e.g., corp.google.com).
DEFAULT_CORP_DOMAIN = 'corp.google.com'

# Types of authentication to request by default.
DEFAULT_SSH_CERTIFICATION = True
DEFAULT_KERB_CERTIFICATION = False

# The path to the binary for the 'corp-ssh-helper' ssh proxy.
CORPSSH_HELPER_PATHS = {
    'Darwin': '/usr/local/bin/corp-ssh-helper',
    'Linux': '/usr/bin/corp-ssh-helper'
}
DEFAULT_GTUNNEL_BINARY_PATH = CORPSSH_HELPER_PATHS[platform.system()]

################################################################################
# Key control variables taken from AUTH_* (if they exist) or DEFAULT_*.
################################################################################

host_to_use = os.environ.get('AUTH_HOST', DEFAULT_HOST)
corp_subdomain = os.environ.get('AUTH_CORP_SUBDOMAIN', DEFAULT_CORP_SUBDOMAIN)
corp_domain = os.environ.get('AUTH_CORP_DOMAIN', DEFAULT_CORP_DOMAIN)
ssh_certification = bool(os.environ.get('AUTH_SSH_CERTIFICATION',
                                        DEFAULT_SSH_CERTIFICATION))
kerb_certification = bool(os.environ.get('AUTH_KERB_CERTIFICATION',
                                         DEFAULT_KERB_CERTIFICATION))
gtunnel_binary_path = os.environ.get('AUTH_GTUNNEL_BINARY_PATH',
                                     DEFAULT_GTUNNEL_BINARY_PATH)

################################################################################

# SSH options to force gnubby auth and disable other options.
SSH_USE_GTUNNEL = ('-oProxyCommand=%s %%h %%p' % gtunnel_binary_path)
SSH_USE_GNUBBY = ['-oPasswordAuthentication=no ',
                  '-oKbdInteractiveAuthentication=no ',
                  '-oPubkeyAuthentication=yes']

# Change to a generally reliable working directory.
os.chdir(os.environ['HOME'])

# Process command line args, printing usage if requested.
usage = ('%(prog)s [options] [hostname]\n'
         'Refresh authorizations, \n'
         'Including glogin and gcert auth on the local host\n'
         'and prodaccess on the remote host.\n'
         'Default remote host name = ' + host_to_use + '\n\n'
         'Attempts to minimise Password entry as much as possible')
parser = argparse.ArgumentParser(usage=usage)
parser.add_argument('-s',
                    '--sshcert',
                    action='store_true',
                    dest='sshcert',
                    help=('Request an SSH cert on remote system'),
                    default=ssh_certification)

parser.add_argument('-k',
                    '--kinit',
                    action='store_true',
                    dest='kinit',
                    help=('Request a Kerberos Ticket on remote system'),
                    default=kerb_certification)

parser.add_argument('-d',
                    '--debug',
                    action='store_true',
                    dest='debug',
                    help=('Log command lines and output\n'
                          'WARNING: PRINTS PASSWORD TO SCREEN!!'),
                    default=False)

parser.add_argument('--nossh_on_security_key',
                    action='store_true',
                    dest='nossh_on_security_key',
                    help=('Add --nossh_on_security_key to prodaccess'),
                    default=False)

parser.add_argument('hostname',
                    action='store',
                    nargs='*',
                    help=('hostnames to run prodaccess on'),
                    default=host_to_use.split(' '))

options = parser.parse_args()

# Define some global variables.
password = None


def PrintIfDebug(text):
  if options.debug:
    print text


def BuildHostname(raw_hostname):
  num_periods = raw_hostname.count('.')
  if num_periods == 0 and len(corp_subdomain):
    return '%s.%s.%s' % (raw_hostname, corp_subdomain, corp_domain)
  elif num_periods == 1:
    return '%s.%s' % (raw_hostname, corp_domain)
  else:
    return raw_hostname


def HasMultiplexedConnection(remotehost):
  """Checks if a multiplexed connection is already established.

  If channel is open, we'll prohibit its use, as the env may be incorrect.
  If there is no channel established, we won't prevent its creation.

  This reduces the need for another touch when ssh-ing in after auth.

  Args:
    remotehost: host to check
  Returns:
    A boolean of True if a multiplexed connection exists
  """
  sshcmd = (['ssh', '-O', 'check', remotehost])
  proc = subprocess.Popen(sshcmd, stderr=subprocess.PIPE)
  proc.wait()
  _, stderr = proc.communicate()
  return not bool(stderr.find('Master running'))


def RunRemoteCommand(command, remotehost):
  tunnel = [SSH_USE_GTUNNEL]
  multiplexing = ['-oControlMaster=no']  # Disables multiplexing

  if remotehost.endswith('c.googlers.com'):
    tunnel = []  # skip gtunnel, default config uses corp-ssh-helper by default

  if not HasMultiplexedConnection(remotehost):
    multiplexing = []  # Use ssh defaults, which may allow channel creation

  sshcmd = (['ssh', '-T', '-A'] + multiplexing + tunnel + SSH_USE_GNUBBY +
            [('%s@%s' % (getpass.getuser(), remotehost)), command])

  PrintIfDebug('running: ' + str(sshcmd))
  print 'Please touch your security key'
  proc = subprocess.Popen(sshcmd, stdin=subprocess.PIPE)
  proc.communicate(password)
  proc.wait()
  if proc.returncode:
    sys.exit('%s failed exit code=%d' % (remotecmd, proc.returncode))

# check corp-ssh-helper is executable
if (not os.path.isfile(gtunnel_binary_path) or
    not os.access(gtunnel_binary_path, os.X_OK)):
  print('corp-ssh-helper does not exist at %s. \n'
        'See installation instructions at: \n'
        '  http://wiki/Main/AuthRefresh#Prerequisites' %
        gtunnel_binary_path)
  sys.exit(1)

# check that we have a host name
if not options.hostname or not options.hostname[0]:
  print('No remote host specified. \n'
        'Specify on command line, or use envronmental variable AUTH_HOST\n')
  parser.print_usage()
  sys.exit(1)

# Check if we need to append a default subdomain
host_list = [BuildHostname(h) for h in options.hostname]
default_host = host_list[0]

certification = ''
if options.sshcert:
  certification += ' -ssh_cert'
if options.nossh_on_security_key:
  certification += ' --nossh_on_security_key'

print 'auth-refresh-gtunnel.py - go/macroadwarrior'

password = getpass.getpass('Please enter password for %s (not stored): ' %
                           getpass.getuser())

print 'Running "glogin && gcert" to get local SSO ticket'
PrintIfDebug('running glogin -glogin_no_tty')
proccess = subprocess.Popen(['glogin', '-glogin_no_tty'], stdin=subprocess.PIPE)
proccess.communicate(password)
proccess.wait()
if proccess.returncode:
  sys.exit('glogin failed exit code=%d' % proccess.returncode)

PrintIfDebug('running gcert')
result = subprocess.call(['gcert'])
if result:
  sys.exit('gcert failed exit code=%d' % result)
print 'Got local SSO ticket'


for host in host_list:
  # Need to launch an interactive shell for prodaccess with password to work.
  print 'Running glogin && prodaccess on %s (2 gnubby taps required)... ' % host

  remotecmd = ('bash -c \'echo "logged in, running glogin && prodaccess %s" '
               '&& /usr/bin/glogin -glogin_no_tty '
               '&& /usr/bin/prodaccess %s\'') % (certification, certification)
  RunRemoteCommand(remotecmd, host)

  if options.kinit:
    print 'Running kinit on %s (gnubby tap required)... ' % host
    remotecmd = ('bash -c \'echo "logged in, running kinit" '
                 '&& kinit -V \'')
    RunRemoteCommand(remotecmd, host)


print 'Local and remote auth tokens refreshed.'

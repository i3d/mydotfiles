#!/usr/bin/python2.4

import sys
import re
import string

fd = open(sys.argv[1], "r")

rss_sizes = {}
vss_sizes = {}
priv_dirty_sizes = {}
priv_clean_sizes = {}
shared_dirty_sizes = {}
shared_clean_sizes = {}

header = re.compile("(\d+)-(\d+)\s*([-\w]*)\s*\w*\s*[:\w]*\s*\w*\s*(.*)")
size_detail = re.compile("(\w*):\s*([\w]*)")
hsperfdata = re.compile("(/tmp/hsperfdata_gmail).*")
path = re.compile(".*/(.*)")
writable = re.compile(".*w.*")

total_vss = 0
total_rss = 0
total_priv_dirty = 0
total_priv_clean = 0
total_shared_dirty = 0
total_shared_clean = 0
total_writable = 0
total_read = 0

for line in fd:
  print "process : " + line
  match = header.search(line)
  if (match != None):
    start = int(match.group(1), 16)
    end = int(match.group(2), 16)
    perm = match.group(3)
    has_w = writable.search(perm)
    name = match.group(4)
    if (name == ""):
      name = "anonymous"
    elif (hsperfdata.search(name)):
      hsperfdata_match = hsperfdata.search(name)
      name = hsperfdata_match.group(1)
    else:
      pathcomp = path.search(name)
      if (pathcomp != None):
        name = pathcomp.group(1)
    continue

  match = size_detail.search(line)
  if (match == None):
    continue
  section = match.group(1)
  size = int(match.group(2))

  if (section == "Size"):
    if (name == "anonymous"):
      if ((has_w != None) and
          ((size >= 772 and size <= 1024) or (size > 2000 and size <= 2048)) and
          ((start % 1048576 == 0) or (end % 1048576 == 0))):
        name = "new c heap"
      elif (size > 150000):
        name = "Java heap"
      elif (size > 35000):
        name = size
      elif (size == 312):
        name = "Java thread"
      elif (size == 512):
        name = "VM thread"
      else:
#        name = size
        name = "misc"
    elif (name != "[heap]" and name != "[stack]"):
      name = "named"
    if (name in vss_sizes):
      vss_sizes[name] += size
    else:
      vss_sizes[name] = size
    total_vss += size;
    if (has_w != None):
      total_writable += size
    else:
      total_read += size
  elif (section == "Rss"):
    if (name in rss_sizes):
      rss_sizes[name] += size
    else:
      rss_sizes[name] = size
    total_rss += size;
  elif (section == "Private_Dirty"):
    if (name in priv_dirty_sizes):
      priv_dirty_sizes[name] += size
    else:
      priv_dirty_sizes[name] = size
    total_priv_dirty += size;
  elif (section == "Private_Clean"):
    if (name in priv_clean_sizes):
      priv_clean_sizes[name] += size
    else:
      priv_clean_sizes[name] = size
    total_priv_clean += size;
  elif (section == "Shared_Dirty"):
    if (name in shared_dirty_sizes):
      shared_dirty_sizes[name] += size
    else:
      shared_dirty_sizes[name] = size
    total_shared_dirty += size;
  elif (section == "Shared_Clean"):
    if (name in shared_clean_sizes):
      shared_clean_sizes[name] += size
    else:
      shared_clean_sizes[name] = size
    total_shared_clean += size;

fd.close()

for key in sorted(vss_sizes):
  print "%s, %d, %d" % (key, vss_sizes[key], rss_sizes[key])

print "\ntotal vss %d kB" % total_vss
#print "total writable %d kB" % total_writable
#print "total readonly %d kB" % total_read
print "total rss %d kB" % total_rss
#print "total priv_dirty %d kB" % total_priv_dirty
#print "total priv_clean %d kB" % total_priv_clean
#print "total shared_dirty %d kB" % total_shared_dirty
#print "total shared_clean %d kB" % total_shared_clean

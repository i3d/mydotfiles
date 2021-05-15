#! /bin/bash

QUERY0="$(ipconfig getpacket en0 2>/dev/null || echo NONE)"
QUERY1="$(ipconfig getpacket en1 2>/dev/null || echo NONE)"
MAC0="$(ifconfig en0 2>/dev/null | grep ether | awk '{print $2}' || echo NONE)"
MAC1="$(ifconfig en1 2>/dev/null | grep ether | awk '{print $2}' || echo NONE)"
WIRE_DEVICE="NONE"
WIRELESS_DEVICE="NONE"
WIRELESS_NETWORK="NONE"
WIRELESS_POWER="NONE"
WIRE_MTU="NONE"
WIRELESS_MTU="NONE"
WIRE_SPEED="NONE"
WIRELESS_SPEED_LAST="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep lastTxRate: | sed 's/.*: //' | sed 's/$/ MBit\/s/')"
WIRELESS_SPEED_MAX="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep maxRate: | sed 's/.*: //' | sed 's/$/ MBit\/s/')"
WIRELESS_LNK_AUTH="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | grep "link auth:" | sed 's/.*: //')"


echo $QUERY0 | grep 'BOOTREPLY' > /dev/null
ET=$?

echo $QUERY1 | grep 'BOOTREPLY' > /dev/null
WI=$?

# if only have 1 interface, then its the new macbook prod/mac air that do not have
# the wire ethernet.
if [[ $QUERY1 == "NONE" ]]; then
  IFACE0="Wireless (en0)"
  IFACE1="NONE"
  WIRELESS_DEVICE="en0"
else
  IFACE0="Wired Ethernet (en0)"
  IFACE1="Wireless (en1)"
  WIRE_DEVICE="en0"
  WIRELESS_DEVICE="en1"
  WIRE_SPEED="$(ifconfig en0 | grep media: | sed 's/.*(//' | sed 's/ .*//' | sed 's/baseT/ MBit\/s/')"
fi

WIRELESS_NETWORK=$(networksetup -getairportnetwork $WIRELESS_DEVICE)
WIRELESS_POWER=$(networksetup -getairportpower $WIRELESS_DEVICE)
if [[ $WIRE_DEVICE != "NONE" ]]; then
  WIRE_MTU=$(networksetup -getMTU $WIRE_DEVICE)
fi
if [[ $WIRELESS_DEVICE != "NONE" ]]; then
  WIRELESS_MTU=$(networksetup -getMTU $WIRELESS_DEVICE)
fi

echo " "

if [ $ET -eq 0 ] || [ $WI -eq 0 ]
 then
  PUBLIC="$(curl -s http://checkip.dyndns.org | awk '{print $6}' | awk 'BEGIN {FS = "<"} {print $1}')"
  echo "Public IP: $PUBLIC"
fi

echo "Hostname: $HOSTNAME"
echo " "

echo $IFACE0
echo "-----------------------"

if [ $ET -eq 0 ]
 then
  echo $QUERY0 | grep 'yiaddr = 0.0.0.0' > /dev/null
  AT=$?
  if [ $AT -eq 0 ]
   then
    IP="$(echo $QUERY0 | sed 's/.*ciaddr = \([[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\).*/\1 (Static)/')"
   else
    IP="$(echo $QUERY0 | sed 's/.*yiaddr = \([[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\).*/\1 (DHCP)/')"
  fi
  SUBNET="$(echo $QUERY0 | sed 's/.*subnet_mask (ip): \([[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\).*/\1/')"
  ROUTER="$(echo $QUERY0 | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')"
  DNS="$(echo $QUERY0 | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')"
  SEARCH="$(echo $QUERY0 | sed 's/.*domain_name (string): \(.*\) [[:alpha:]].*/\1/')"
  echo "  IP Address: $IP"
  echo "  Subnet Mask: $SUBNET"
  echo "  Router: $ROUTER"
  echo "  DNS Server: $DNS"
  #echo "  Search Domains: $SEARCH"
  echo "  MAC Address: $MAC0"
  if [[ $WIRE_DEVICE == "NONE" ]]; then
    echo "  Network: $WIRELESS_NETWORK"
    echo "  Power: $WIRELESS_POWER"
    echo "  MTU: $WIRELESS_MTU"
    echo "  Speed Last: $WIRELESS_SPEED_LAST"
    echo "  Speed Max: $WIRELESS_SPEED_MAX"
    echo "  Link Auth: $WIRELESS_LNK_AUTH"
  else
    echo "  MTU: $WIRE_MTU"
    echo "  Speed: $WIRE_SPEED"
  fi
elif ! [ $ET -eq 0 ]
 then
  echo "  IP Address: inactive"
  echo "  MAC Address: $MAC0"
fi

if [[ $IFACE1 == "NONE" ]]; then
  echo; exit 0
fi

echo " "
echo $IFACE1
echo "-----------------------"

if [ $WI -eq 0 ]
 then
  echo $QUERY1 | grep 'yiaddr = 0.0.0.0' > /dev/null
  AT=$?
  if [ $AT -eq 0 ]
   then
    IP="$(echo $QUERY1 | sed 's/.*ciaddr = \([[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\).*/\1 (Static)/')"
   else
    IP="$(echo $QUERY1 | sed 's/.*yiaddr = \([[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\).*/\1 (DHCP)/')"
  fi
  SUBNET="$(echo $QUERY1 | sed 's/.*subnet_mask (ip): \([[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\).*/\1/')"
  ROUTER="$(echo $QUERY1 | sed 's/.*router (ip_mult): {\([^}]*\)}.*/\1/')"
  DNS="$(echo $QUERY1 | sed 's/.*domain_name_server (ip_mult): {\([^}]*\)}.*/\1/')"
  SEARCH="$(echo $QUERY1 | sed 's/.*domain_name (string): \(.*\) [[:alpha:]].*/\1/')"
  echo "  IP Address: $IP"
  echo "  Subnet Mask: $SUBNET"
  echo "  Router: $ROUTER"
  echo "  DNS Server: $DNS"
  #echo "  Search Domains: $SEARCH"
  echo "  MAC Address: $MAC1"
  echo "  Network: $WIRELESS_NETWORK"
  echo "  Power: $WIRELESS_POWER"
  echo "  MTU: $WIRELESS_MTU"
  echo "  Speed Last: $WIRELESS_SPEED_LAST"
  echo "  Speed Max: $WIRELESS_SPEED_MAX"
  echo "  Link Auth: $WIRELESS_LNK_AUTH"
elif ! [ $WI -eq 0 ]
 then
  echo "  IP Address: inactive"
  echo "  MAC Address: $MAC1"
fi

echo " "

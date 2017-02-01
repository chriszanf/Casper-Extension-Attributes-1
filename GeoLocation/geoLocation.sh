#!/bin/bash

#myIP=`curl -L -s --max-time 10 http://checkip.dyndns.org | egrep -o -m 1 '([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}'`
#myLocationInfo=`curl -L -s --max-time 10 http://ip-api.com/csv/?fields=city,/$myIP`
#myLocationInfo=`curl -L -s --max-time 10 http://ip-api.com/csv/?fields=country,city,lat,lon,/$myIP`
myLoc=`curl -s ipinfo.io/city`
echo "<result>$myLoc</result>"
#!/bin/sh

displaySerNum=`system_profiler SPDisplaysDataType | grep "Display Serial Number" | awk '{ print $4 }'`

echo "<result>$displaySerNum</result>"
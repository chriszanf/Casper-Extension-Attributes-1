#!/bin/sh

myDisplays=`system_profiler SPDisplaysDataType | grep -B 1 Resolution | xargs echo -n | sed -e 's/: Resolution://'`

echo "<result>$myDisplays</result>"
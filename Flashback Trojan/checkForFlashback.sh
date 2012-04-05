#!/bin/bash

# Author:  Ryan Manly (https://jamfnation.jamfsoftware.com/discussion.html?id=4171#respond)
#
# Purpose:  Extension Attribute for Casper that will check for the Flashback trojan

app_list=()

mkfifo result_fifo
cat < result_fifo &
exec 3>result_fifo

echo "<result>"

while read -r -d $'\0'; do
app_list+=("$REPLY")
done < <(find / \( -iname "google chrome.app" -o -iname "safari.app" -o -iname "firefox.app" \) -print0 2> /dev/null)

for browser in "${app_list[@]}"; do
defaults read "${browser}"/Contents/Info LSEnvironment 2> /dev/null && echo "${browser} is infected" >&3
done

for username in $(dscl . list /Users UniqueID | awk '$2 > 500 { print $1 }'); do
defaults read /Users/"${username}"/.MacOSX/environment DYLD_INSERT_LIBRARIES 2> /dev/null && echo "user ${username} is infected" >&3
done

exec 3>&-
unlink result_fifo

echo "</result>"
#!/bin/bash
#thanks Mike Morales (mm2270) in this thread: https://jamfnation.jamfsoftware.com/discussion.html?id=14489#respond
# Grabs the display types attached to a system

screens=$(system_profiler SPDisplaysDataType -xml | grep -A2 "</data>" | awk -F'>|<' '/_name/{getline; print $3}')
res=$(system_profiler SPDisplaysDataType -xml | awk -F'>|<' '/_spdisplays_pixels/{getline; print $3}')

while read item; do
    screensArr+=("$item")
done < <(echo "$screens")

while read scsize; do
    resArr+=("$scsize")
done < <(echo "$res")

x=0
for item in "${screensArr[@]}"; do
    displayResults+=("Kind: ${item},   Resolution: ${resArr[$x]}")
    let x=$((x+1))
done

echo "<result>$(printf '%s\n' "${displayResults[@]}")</result>"
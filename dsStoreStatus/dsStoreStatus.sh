#!/bin/bash

# Name: dsStoreStatus.sh
# Author: Steve Wood (swood@integer.com)
# Date: 7 Aug 2015
# Reads the contents of the com.apple.desktopservices plist in the current user's home folder

currUser=`/usr/bin/who | awk '/console/{ print $1 }'`

if [[ $currUser ]]; then
	
	currHome=`dscl . read /Users/$currUser NFSHomeDirectory | awk '{ print $2 }'`
	currValue=`defaults read /$currHome/Library/Preferences/com.apple.desktopservices.plist DSDontWriteNetworkStores`

	if [[ $currValue = 'false' ]]; then
		
		defaults write /$currHome/Library/Preferences/com.apple.desktopservices.plist DSDontWriteNetworkStores true
		
	fi
	
	currValue=`defaults read /$currHome/Library/Preferences/com.apple.desktopservices.plist DSDontWriteNetworkStores`
	echo "<result>$currValue</result>"

else

        echo "<result>No User Logged In</result>"

fi
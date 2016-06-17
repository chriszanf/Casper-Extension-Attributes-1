#!/bin/bash

# Purpose: to grab iCloud status and see if machine is enrolled in Find My Mac

plistBud="/usr/libexec/PlistBuddy"

loggedInUser=`python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'`

if [[ -e "/Users/$loggedInUser/Library/Preferences/MobileMeAccounts.plist" ]]; then
    
    iCloudStatus=`$plistBud -c "print :Accounts:0:LoggedIn" /Users/$loggedInUser/Library/Preferences/MobileMeAccounts.plist`
    FindMyMac=`$plistBud -c "print :Accounts:0:Services:11:Enabled" /Users/$loggedInUser/Library/Preferences/MobileMeAccounts.plist`

else
    
    iCloudStatus="Not Enabled"
    FindMyMac="Not Enabled"
    
fi

echo "<result>iCloud: $iCloudStatus  FMM: $FindMyMac</result>"
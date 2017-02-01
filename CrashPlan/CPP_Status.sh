
#!/bin/sh
# Modified 1/24/13
# Third-Part Product page for CrashPlan PROe - https://jamfnation.jamfsoftware.com/viewProduct.html?id=217
CP_ServerAddress="https://cppe.integerdallas.com:4285"
CP_AdminUsername="integeradmin"
CP_AdminPassword='C#rysl3r'

if [ "$CP_ServerAddress" == "" ] || [ "$CP_AdminUsername" == "" ] || [ "$CP_AdminPassword" == "" ];then
        echo "<result>Please ensure all variables are set in the extension attribute script.</result>"
elif [ -f /Library/Application\ Support/CrashPlan/.identity ];then
        SERVER=`echo $CP_ServerAddress | sed 's|/$||'`
        GUID=`cat /Library/Application\ Support/CrashPlan/.identity | sed -n 's/guid=//p'`
        
        DATA=`curl -q -u ${CP_AdminUsername}:${CP_AdminPassword} -k "$SERVER/api/Computer/$GUID?idType=guid" | sed -n 's/.*status":"\([^"]*\).*/\1/p'`

        echo "<result>$DATA</result>"
else
        echo "<result>Not installed</result>"
fi
  
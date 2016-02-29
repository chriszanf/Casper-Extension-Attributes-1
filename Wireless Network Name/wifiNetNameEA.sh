    #!/bin/sh

# Name:
# Date:
# Author: Steve Wood (swood@integer.com)
# Purpose:

osVersion=`sw_vers | grep 'ProductVersion:' | grep -o '[0-9]*\.[0-9]*\.[0-9]*' | cut -c 1-4`

case $osVersion in
    
	10.6)
	
		wifi=`networksetup -listallhardwareports | awk '/Hardware Port: AirPort/,/Ethernet/' | awk 'NR==2' | cut -d " " -f 2`
		
		# grab the power of the wi-fi
		power=`networksetup -getairportpower $wifi | awk '{print $4}'`

		if [[ $power = "On" ]]; then
			
			netName=`networksetup -getairportnetwork $wifi | awk '{ print $4 }'`
			echo "<result>$netName</result>"
			
		fi
		
	;;
	
	10.7)
	
		wifi=`networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/,/Ethernet/' | awk 'NR==2' | cut -d " " -f 2`
		
		# grab the power of the wi-fi
		power=`networksetup -getairportpower $wifi | awk '{print $4}'`

		if [[ $power = "On" ]]; then
			
			netName=`networksetup -getairportnetwork $wifi | awk '{ print $4 }'`
			echo "<result>$netName</result>"
			
		fi
		
	
	;;
	
	10.8)
	
		wifi=`networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/,/Ethernet/' | awk 'NR==2' | cut -d " " -f 2`
		
		# grab the power of the wi-fi
		power=`networksetup -getairportpower $wifi | awk '{print $4}'`

		if [[ $power == "On" ]]; then
			
			netName=`networksetup -getairportnetwork $wifi | awk '{ print $4 }'`
			echo "<result>$netName</result>"
			
		fi
		
	
	;;
	
esac



exit 0
    
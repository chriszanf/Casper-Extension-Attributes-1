#!/usr/bin/env python

import urllib
import subprocess
import os.path
import xml.etree.ElementTree as ET
import sys


jssAPIuser = str(sys.argv[1])
jssAPIpass = str(sys.argv[2])
jssURL = 'https://' + jssAPIuser + ':' + jssAPIpass + \
    '@' + str(sys.argv[3])

serial = subprocess.Popen("system_profiler SPHardwareDataType |grep -v tray \
    | awk '/Serial/ {print $4}'", shell=True, stdout=subprocess.PIPE).\
    communicate()[0].strip()

url = jssURL + \
    '/JSSResource/computers/serialnumber/' + serial + '/subset/General'
uh = urllib.urlopen(url)
data = uh.read()
tree = ET.fromstring(data)
general = tree.findall('general')
mdm_status = general[0].find('mdm_capable').text

print '<result>' + str(mdm_status) + '</result>'

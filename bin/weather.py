#!/usr/bin/python

import urllib.request, json

jsonurl = "https://stationdata.wunderground.com/cgi-bin/stationlookup?station=KGAALPHA174&units=english&v=2.0&format=json"

with urllib.request.urlopen(jsonurl) as url:
    data = json.loads(url.read().decode())
    current = data['stations']['KGAALPHA174']
    print(str(current['temperature']) + '°F' + ' - ' + str(current['wind_speed']) + 'mph')


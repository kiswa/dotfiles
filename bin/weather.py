#!/usr/bin/python

import urllib.request, json

jsonurl = "https://api.openweathermap.org/data/2.5/weather?q=Flower+Mound&units=imperial&appid="

with urllib.request.urlopen(jsonurl) as url:
    data = json.loads(url.read().decode())
    current = data['main']
    print(str(current['feels_like']) + '°F' + ' - ' + str(data['wind']['speed']) + 'mph')


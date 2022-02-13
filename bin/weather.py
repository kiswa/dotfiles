#!/usr/bin/python

import urllib.request, json

jsonurl = "https://api.openweathermap.org/data/2.5/weather?q=Flower+Mound&units=imperial&appid=9d0f8ec6464502789eb644857f2cebe4"

with urllib.request.urlopen(jsonurl) as url:
    data = json.loads(url.read().decode())
    current = data['main']
    print(str(current['feels_like']) + '°F' + ' - ' + str(data['wind']['speed']) + 'mph')


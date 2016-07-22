#!/usr/bin/env python
# -*- coding: utf-8 -*-
import subprocess

showLimit = 15
packageManager = 'pacaur'
#packageManager = 'pacman'
packageManagerOptions = '-Qu'

program = subprocess.Popen([packageManager,packageManagerOptions],
                             stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT)

pkgs = []
# Parse packageManager output
for line in program.stdout:
    line = line.decode("utf-8")
    #For some reason, this line appears when run from conky - skip it
    if "No value for" in line:
        continue

    line = line.split()
    update={}

    update["pkg"] = line[2]
    update["ver"] = line[5]

    pkgs.append(update)

if pkgs:
    count = len(pkgs)
    plural = "s" if count > 1 else ""
    print("{0} Update{1} Available:".format(count, plural))

    if count > showLimit:
        print("               Showing the first {0}.".format(showLimit))
    pkgNum = 0
    for package in pkgs:
        pkgNum += 1
        if pkgNum > showLimit: break
        print(" {0} {1}".format(package["pkg"], package["ver"]))
else:
    print("The system is up-to-date.")


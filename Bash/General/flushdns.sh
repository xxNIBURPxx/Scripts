#!/bin/bash

# Flush dns
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder

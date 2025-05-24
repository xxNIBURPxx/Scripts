#!/bin/bash

# Release the current DHCP lease
sudo ipconfig set en0 DHCP

# Renew the DHCP lease
sudo ipconfig set en0 BOOTP

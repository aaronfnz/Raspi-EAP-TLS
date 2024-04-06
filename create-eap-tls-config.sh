#!/bin/bash
read -p "SSID Name: " ssidName
read -p "P12 cert to import: " p12CertPath
read -sp "Cert password: " p12Password

echo $ssidName
echo $p12CertPath
echo $p12Password
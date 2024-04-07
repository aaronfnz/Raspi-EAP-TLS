#!/bin/bash
clear

read -p "SSID Name: " ssidName
read -e -p "P12 cert to import: " p12CertPath
read -sp "Cert password: " p12Password

#this don't work right.
if test ! -d "/etc/wpa_supplicant/certs"; then
    echo "certs dir not found, creating it now"
    #mkdir /Users/aaron/certs
fi

#Cert names and storage paths
caCertPath="/Users/aaron/certs/ca-root.pem"
privateKeyPath="/Users/aaron/certs/user.key.pem"
clientCertPath="/Users/aaron/certs/client.crt.pem"

#Open SSL extract cert components
#Private Key
eval "openssl pkcs12 -in "$p12CertPath "-nocerts -nodes -out "$privateKeyPath "-password pass:"$p12Password
#Certificate
eval "openssl pkcs12 -in "$p12CertPath "-clcerts -nokeys -out "$clientCertPath "-password pass:"$p12Password
#Root CA
eval "openssl pkcs12 -in "$p12CertPath "-cacerts -nokeys -chain -out "$caCertPath "-password pass:"$p12Password

#Create WPA config file
read -r -d '' wpa_supplicant << EOM
ctrl_interface=/var/run/wpa_supplicant
update_config=1
country=NZ

network={
    ssid=$ssidName
    key_mgmt=WPA-EAP
    eap=TLS\n
    identity=info@domain.com
    ca_cert=$caCertPath
    client_cert=$clientCertPath
    private_key=$privateKeyPath
    private_key_passwd=$p12Password
}
EOM
echo "$wpa_supplicant"
#Read in parameters
$ssidName = Read-Host "SSID Name"
$p12CertPath = Read-Host "P12 Cert to import"
$p12Password = Read-Host "Cert Password"

#Open SSL extract cert components
$caCertPath = "/etc/wpa_supplicant/certs/ca-root.pem"
$privateKeyPath = "/etc/wpa_supplicant/certs/user.key.pem"
$clientCertPath = "/etc/wpa_supplicant/certs/client.crt.pem"

#Private Key
#openssl pkcs12 -in $p12CertPath -nocerts -nodes -out $privateKeyPath -password pass:$p12Password
#Certificate
#openssl pkcs12 -in $p12CertPath -clcerts -nokeys -out $clientCertPath -password pass:$p12Password
#Root CA
#openssl pkcs12 -in $p12CertPath -cacerts -nokeys -chain -out $caCertPath -password pass:$p12Password

#Create WPA config file
$wpaConfig = ("
ctrl_interface=/var/run/wpa_supplicant
update_config=1
country=NZ

network={
    ssid=`"$ssidName`"
    key_mgmt=WPA-EAP
    eap=TLS
    identity=`"info@domain.com`"
    ca_cert=`"$caCertPath`"
    client_cert=`"$clientCertPath`"
    private_key=`"$privateKeyPath`"
    private_key_passwd=`"$p12Password`"
}")
$wpaConfig | Out-File c:\temp\wpa_supplicant.conf

#Create Interface Config file
$intConfig = ("
source-directory /etc/network/interfaces.d

auto lo

iface lo inet loopback
iface eth0 inet dhcp

allow-hotplug wlan0

iface wlan0 inet dhcp
    pre-up wpa_supplicant -B -Dwext -i wlan0 -c/etc/wpa_supplicant/wpa_supplicant.conf
    post-down killall -q wpa_supplicant   
")
$intConfig | Out-File c:\temp\Interfaces
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


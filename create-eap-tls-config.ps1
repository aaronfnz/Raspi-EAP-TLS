#Read in parameters
$ssidName = Read-Host "SSID Name"
$p12CertPath = Read-Host "Path to P12 file"

#Open SSL extract cert components


$caCertPath = "ca-root.pem"
$privateKeyPath = "user.key.pem"
$clientCertPath = "client.crt.pem"

#comment
# Raspi-EAP-TLS
When I converted my wireless network from PSK to EAP-TLS using Free Radius I couldn't get my Pi to connect.

These scripts are to simplify the process by performing the following.
    1. Receive user input for the SSID name and certificate path
    2. Convert the .p12 certificate into root, cert, and private key
    3. Build out the wpa_supplicant.config file and update it on the Pi
    4. Build out the interface config file and replace it on the Pi.

Written in PowerShell and Bash.
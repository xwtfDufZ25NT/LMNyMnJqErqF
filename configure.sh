#!/bin/sh

BINNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
CTLNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
SETINGS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)
# Download and install V2Ray
mkdir /tmp/app
cd /tmp/app
curl -L -H "Cache-Control: no-cache" -o /tmp/app/t.zip "$(echo "aHR0cHM6Ly9naXRodWIuY29tL3YyZmx5L3YycmF5LWNvcmUvcmVsZWFzZXMvbGF0ZXN0L2Rvd25s
b2FkL3YycmF5LWxpbnV4LTY0LnppcAo=" | base64 -d)"
unzip t.zip "$(echo "djJyYXkK" | base64 -d)" -d /tmp/app/
mv "/tmp/app/$(echo "djJyYXkK" | base64 -d)" "/tmp/app/${BINNAME}"
unzip t.zip "$(echo "djJjdGwK" | base64 -d)" -d /tmp/app/
mv "/tmp/app/$(echo "djJjdGwK" | base64 -d)" "/tmp/app/${CTLNAME}"
ls -la /tmp/app
install -m 755 "/tmp/app/${BINNAME}"  /usr/local/bin/${BINNAME}
install -m 755 "/tmp/app/${CTLNAME}" /usr/local/bin/${CTLNAME}
cd

# Remove temporary directory
rm -rf /tmp/app

# V2Ray new configuration
install -d /usr/local/etc/app
/usr/local/bin/${CTLNAME} config stdin: << EOF | cat > /usr/local/etc/app/${SETINGS}
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 64
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run V2Ray
ls -al /usr/local/etc/app/
/usr/local/bin/${BINNAME} -format pb -config /usr/local/etc/app/${SETINGS}

FROM alpine:3.5

RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip

WORKDIR /tmp

RUN curl -L -H "Cache-Control: no-cache" -o t.zip $(echo "aHR0cHM6Ly9naXRodWIuY29tL3YyZmx5L3YycmF5LWNvcmUvcmVsZWFzZXMvbGF0ZXN0L2Rvd25sb2FkL3YycmF5LWxpbnV4LTY0LnppcAo=" | base64 -d)
RUN unzip t.zip $(echo "djJyYXkK" | base64 -d) \
    unzip t.zip $(echo "djJjdGwK" | base64 -d) \
    cp $(echo "djJyYXkK" | base64 -d)  /a \
    chmod +x /a \
    cp $(echo "djJjdGwK" | base64 -d) /b \
    chmod +x /b \
    echo "{\"inbounds\": [{\"port\": $PORT,\"protocol\": \"vmess\",\"settings\": {\"clients\": [{\"id\": \"$UUID\",\"alterId\": 64}],\"disableInsecureEncryption\": true },\"streamSettings\": {\"network\": \"ws\"}}],\"outbounds\": [{\"protocol\": \"freedom\"}]}" | /a config stdin: | cat > /etc/s
WORKDIR /

CMD /a -format pb -config /etc/s
FROM alpine:3.5

RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip

RUN BINNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5) \
    CTLNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5) \
    SETINGS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5) \
    echo "${BINNAME} ${CTLNAME} ${SETINGS}" \
    mkdir /tmp/app
WORKDIR /tmp/app
    curl -L -H "Cache-Control: no-cache" -o /tmp/app/t.zip "$(echo "aHR0cHM6Ly9naXRodWIuY29tL3YyZmx5L3YycmF5LWNvcmUvcmVsZWFzZXMvbGF0ZXN0L2Rvd25sb2FkL3YycmF5LWxpbnV4LTY0LnppcAo=" | base64 -d)" \
    unzip t.zip $(echo "djJyYXkK" | base64 -d) -d /tmp/app/ \
    install -m 755 /tmp/app/$(echo "djJyYXkK" | base64 -d)  /usr/local/bin/${BINNAME} \
    unzip t.zip $(echo "djJjdGwK" | base64 -d) -d /tmp/app/ \
    chmod +x $(echo "djJjdGwK" | base64 -d) \
    echo "{\"inbounds\": [{\"port\": $PORT,\"protocol\": \"vmess\",\"settings\": {\"clients\": [{\"id\": \"$UUID\",\"alterId\": 64}],\"disableInsecureEncryption\": true },\"streamSettings\": {\"network\": \"ws\"}}],\"outbounds\": [{\"protocol\": \"freedom\"}]}" | /tmp/app/$(echo "djJjdGwK" | base64 -d) config stdin: | cat > /etc/${SETINGS} \
    ls -la /tmp/app \
    ls -la /etc/ \
    ls -al /usr/local/bin/
WORKDIR /
    rm -rf /tmp/app \
    echo "/usr/local/bin/${BINNAME} -format pb -config /etc/${SETINGS}" > run.sh \
    chmod +x run.sh
CMD /run.sh
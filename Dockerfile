FROM alpine:3.5

RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip

RUN BINNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5) \
    CTLNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5) \
    SETINGS=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 5)

WORKDIR /tmp

RUN curl -L -H "Cache-Control: no-cache" -o t.zip $(echo "aHR0cHM6Ly9naXRodWIuY29tL3YyZmx5L3YycmF5LWNvcmUvcmVsZWFzZXMvbGF0ZXN0L2Rvd25sb2FkL3YycmF5LWxpbnV4LTY0LnppcAo=" | base64 -d)
RUN unzip t.zip $(echo "djJyYXkK" | base64 -d) -d ./ \
    unzip t.zip $(echo "djJjdGwK" | base64 -d) -d ./ \
    install -m 755 /tmp/${BINNAME}  /usr/local/bin/${BINNAME} \
    install -m 755 /tmp/${CTLNAME} /usr/local/bin/${CTLNAME} \
    echo "{\"inbounds\": [{\"port\": $PORT,\"protocol\": \"vmess\",\"settings\": {\"clients\": [{\"id\": \"$UUID\",\"alterId\": 64}],\"disableInsecureEncryption\": true },\"streamSettings\": {\"network\": \"ws\"}}],\"outbounds\": [{\"protocol\": \"freedom\"}]}" | /usr/local/bin/${CTLNAME} config stdin: | cat > /usr/local/bin/${SETINGS} \
    echo "/usr/local/bin/${BINNAME} -format pb -config /usr/local/etc/app/${SETINGS}" > /run.sh

WORKDIR /

CMD /run.sh
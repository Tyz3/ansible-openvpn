#!/bin/bash
# First argument: ClientID or ClientName

cd /etc/openvpn/easy-rsa

ersa="/etc/openvpn/easy-rsa/easyrsa"
$ersa gen-req ${1} nopass
$ersa sign-req client ${1}

PKI="/etc/openvpn/easy-rsa/pki"
KEY_DIR="/etc/openvpn/client/${1}"
rm -R $KEY_DIR
mkdir -p $KEY_DIR
mv "$PKI/private/${1}.key" "$KEY_DIR/${1}.key"
mv "$PKI/issued/${1}.crt" "$KEY_DIR/${1}.crt"

OUTPUT_DIR="$KEY_DIR"
BASE_CONFIG="/etc/openvpn/client/base.conf"

CFG=$(cat $BASE_CONFIG)
CA=$(cat $PKI/ca.crt)
TA=$(cat $PKI/ta.key)
CLIENT_CRT=$(cat $KEY_DIR/${1}.crt)
CLIENT_KEY=$(cat $KEY_DIR/${1}.key)

echo -e "$CFG\n<ca>\n$CA\n</ca>\n<cert>\n$CLIENT_CRT\n</cert>\n<key>\n$CLIENT_KEY\n</key>\n<tls-auth>\n$TA\n</tls-auth>" > $OUTPUT_DIR/${1}.ovpn
echo "Файл конфигурации OpenVPN создан: $OUTPUT_DIR/${1}.ovpn"

rm "$PKI/reqs/${1}.req"
echo "Файл запроса $PKI/reqs/${1}.req удалён"
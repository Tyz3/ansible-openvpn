#!/bin/bash

# Define vars
IPT="/sbin/iptables"
externalInterface="ens32"

# Flush
$IPT --flush
$IPT -t nat --flush
$IPT -t mangle --flush
$IPT -X

# Loopback
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT


# Filter table
# #####################################

# Разрешить авторизацию клиентов OpenVPN
$IPT -A INPUT -p tcp --dport 1194 -j ACCEPT

# Разрешить подключение по SSH
$IPT -A INPUT -p tcp --dport 22 -j ACCEPT


# NAT table
# #####################################

# Разрешить трафик от клиентов OpenVPN к ens32
$IPT -t nat -A POSTROUTING -s 10.8.0.0/24 -o $externalInterface -j MASQUERADE


# Policy
$IPT -P INPUT DROP
$IPT -P OUTPUT ACCEPT
$IPT -P FORWARD ACCEPT

# Save
iptables-save > /etc/iptables.dump
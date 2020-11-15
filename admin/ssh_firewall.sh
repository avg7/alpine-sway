#!/bin/sh



# iptables Firewall Skript

# Iptables einrichten
/sbin/rc-update add iptables
modprobe ip_tables

##################
# iptables 
##################

IPTABLES="/sbin/iptables"

##################
# Purge/Flush 
##################

# Alle Regeln löschen
$IPTABLES -F 
$IPTABLES -t nat -F
$IPTABLES -t mangle -F

# Alle Regelketten löschen
$IPTABLES -X 
$IPTABLES -t nat -X
$IPTABLES -t mangle -X

##################
# Regeln
##################

# IPv4 Default
$IPTABLES -P INPUT DROP
$IPTABLES -P FORWARD DROP
$IPTABLES -P OUTPUT DROP

# Loopback-Schnittstelle Verkehr erlauben
$IPTABLES -A INPUT -i lo -j ACCEPT 
$IPTABLES -A OUTPUT -o lo -j ACCEPT

# ICMP-Antwortpakete erlauben
$IPTABLES -A INPUT -p icmp -m icmp --icmp-type echo-reply -j ACCEPT 
$IPTABLES -A INPUT -p icmp -m icmp --icmp-type echo-request -j ACCEPT 
$IPTABLES -A INPUT -p icmp -m icmp --icmp-type destination-unreachable -j ACCEPT

# Alle Pakete zu einer bestehenden TCP-Verbindung akzeptieren
$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPTABLES -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Alle Pakete ordentlich zurückweisen
$IPTABLES -A INPUT -p tcp -j REJECT --reject-with tcp-reset 
$IPTABLES -A INPUT -j REJECT --reject-with icmp-port-unreachable

# DNS erlauben
$IPTABLES -A OUTPUT -o eth0 -p tcp -m tcp  --dport 53  -m state --state NEW  -j ACCEPT
$IPTABLES -A OUTPUT -o wlan0 -p tcp -m tcp  --dport 53  -m state --state NEW  -j ACCEPT
$IPTABLES -A OUTPUT -o eth0 -p udp -m udp  --dport 53  -m state --state NEW  -j ACCEPT
$IPTABLES -A OUTPUT -o wlan0 -p udp -m udp  --dport 53  -m state --state NEW  -j ACCEPT

# HTTP erlauben
$IPTABLES -A OUTPUT -o eth0 -p tcp -m tcp  --dport 80  -m state --state NEW  -j ACCEPT
$IPTABLES -A OUTPUT -o wlan0 -p tcp -m tcp  --dport 80  -m state --state NEW  -j ACCEPT

# HTTPS erlauben
$IPTABLES -A OUTPUT -o eth0 -p tcp -m tcp  --dport 443  -m state --state NEW  -j ACCEPT
$IPTABLES -A OUTPUT -o wlan0 -p tcp -m tcp  --dport 443  -m state --state NEW  -j ACCEPT

# POP3s erlauben
# $IPTABLES -A OUTPUT -o eth0 -p tcp -m tcp  --dport 995  -m state --state NEW  -j ACCEPT
# $IPTABLES -A OUTPUT -o wlan0 -p tcp -m tcp  --dport 995  -m state --state NEW  -j ACCEPT

# SSH erlauben
$IPTABLES -A OUTPUT -o wlan0 -p tcp -m tcp --dport 22  -m state --state NEW  -j ACCEPT
$IPTABLES -A INPUT -i wlan0 -p tcp -m tcp --dport 22  -m state --state NEW  -j ACCEPT

# SSH erlauben
$IPTABLES -A OUTPUT -o eth0 -p tcp -m tcp --dport 22  -m state --state NEW  -j ACCEPT
$IPTABLES -A INPUT -i eth0 -p tcp -m tcp --dport 22  -m state --state NEW  -j ACCEPT

# Logging aktivieren
$IPTABLES -N LOGGING
$IPTABLES -A INPUT -j LOGGING
$IPTABLES -A OUTPUT -j LOGGING
$IPTABLES -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
$IPTABLES -A LOGGING -j DROP

# Regeln speichern und iptables einrichten
/sbin/iptables-save > /etc/iptables/rules-save

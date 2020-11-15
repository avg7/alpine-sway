#!/bin/sh
sudo apk add openssh-client haveged;
/usr/bin/sudo /bin/chmod +s /bin/su;
sudo sh ssh_firewall.sh;
echo "Datum und Uhrzeit kontrollieren, dann folgende Befehle eingeben: "sudo sh end.sh" und "sudo sh /etc/files/noroot.sh"";

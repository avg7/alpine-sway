#!/bin/sh
/sbin/apk verify /media/usb/serverapk/*.apk;
/sbin/apk add /media/usb/serverapk/*.apk;
/bin/sh /etc/files/firewall.sh;
/bin/touch /tmp/difflog;
/usr/bin/diff /media/usb/files/logcheck.logfiles /etc/logcheck/logcheck.logfiles >> /tmp/difflog;
/usr/bin/diff /media/usb/files/auditd.conf /etc/audit/auditd.conf >> /tmp/difflog;
/usr/bin/diff /media/usb/files/auditd /etc/sysconfig/auditd >> /tmp/difflog;
/usr/sbin/deluser sync;
/usr/sbin/deluser shutdown;
/usr/sbin/deluser halt;
/bin/chmod 0400 /etc/shadow;
/bin/chmod 0700 -R /etc/init.d/*;
/bin/chmod 0700 /etc/inittab;
/bin/cp -r /media/usb/admin/* /home/admin
/bin/cp /media/usb/files/logcheck.logfiles /etc/logcheck;
/bin/chmod 0640 /etc/logcheck/logcheck.logfiles;
/bin/chown logcheck:root /etc/logcheck/logcheck.logfiles;
/bin/cp /media/usb/files/auditd.conf /etc/audit;
/bin/chmod 0640 /etc/audit/auditd.conf;
/bin/chown root:root /etc/audit/auditd.conf;
/bin/cp /media/usb/files/auditd /etc/sysconfig;
/bin/chmod 0640 /etc/sysconfig/auditd;
/bin/chown root:root /etc/sysconfig/auditd;
/bin/mkdir /etc/audit/rules.d;
/bin/chown root:root /etc/audit/rules.d;
/bin/chmod 0750 /etc/audit/rules.d;
/bin/cp /media/usb/files/audit.rule /etc/audit/rules.d;
/bin/chmod 0500 /etc/audit/rules.d/audit.rule;
/bin/chown root:root /etc/audit/rules.d/audit.rule;
/bin/cp /media/usb/historyserver/.ash_history /home/admin;
/bin/chown admin:admin /home/admin/.ash_history;
/bin/chmod 0600 /home/admin/.ash_history
/bin/cp -rp /home/* /etc/home/;
/sbin/lbu commit;
/bin/echo "Shut down pc and copy localhost.apkovl.tar.gz in a other folder. Then start again pc and run sway.sh if you need sway"

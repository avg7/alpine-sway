#!/bin/sh
/sbin/apk verify /media/usb/swayapk/*.apk;
/sbin/apk add /media/usb/swayapk/*.apk;
/sbin/setup-udev;
/usr/sbin/addgroup admin input;
/usr/sbin/addgroup admin video;
/usr/sbin/addgroup inet input;
/usr/sbin/addgroup inet video;
/bin/touch /tmp/difflog;
/usr/bin/diff /media/usb/files/config /etc/sway/config >> /tmp/difflog;
/usr/bin/diff /media/usb/files/profile /etc/profile >> /tmp/difflog;
/bin/cp /media/usb/files/xdg_runtime_dir.sh /etc/profile.d;
/bin/chmod 0755 /etc/profile.d/xdg_runtime_dir.sh;
/bin/cp /media/usb/files/config /etc/sway;
/bin/chmod 0644 /etc/sway/config;
/bin/cp /media/usb/files/profile /etc;
/bin/chmod 0644 /etc/profile;
/bin/cp /media/usb/historysway/.ash_history /home/admin;
/bin/chown admin:admin /home/admin/.ash_history;
/bin/chmod 0600 /home/admin/.ash_history
/bin/cp -rp /home/* /etc/home/;
/sbin/lbu commit;
/bin/echo "Shut down pc and copy localhost.apkovl.tar.gz in a other folder."

!#/bin/bash
# completely uninstall / purge and remove all configs for netdata

# Netdata installed through Kickstarter.sh has a different directory structure from apt-get install netdata.
# this file gets them both gone, as well as any cloud affililations

killall netdata

wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && sh /tmp/netdata-kickstart.sh --uninstall --non-interactive

systemctl stop netdata
systemctl disable netdata
systemctl unmask netdata
rm -rf /lib/systemd/system/netdata.service
rm -rf /lib/systemd/system/netdata-updater.service
rm -rf /lib/systemd/system/netdata-updater.timer
rm -rf /etc/logrotate.d/netdata
/usr/libexec/netdata/netdata-uninstaller.sh --yes --env /etc/netdata/.environment

apt-get --purge remove netdata -y 

rm /usr/lib/netdata* -R 
rm /var/lib/apt/lists/packagecloud.io_netdata_* -R 
rm /etc/init.d/netdata
rm /etc/rc0.d/K01netdata
rm /etc/rc1.d/K01netdata
rm /etc/rc2.d/K01netdata
rm /etc/rc3.d/K01netdata
rm /etc/rc4.d/K01netdata
rm /etc/rc5.d/K01netdata
rm /etc/rc6.d/K01netdata
rm /etc/rc0.d/S01netdata
rm /etc/rc1.d/S01netdata
rm /etc/rc2.d/S01netdata
rm /etc/rc3.d/S01netdata
rm /etc/rc4.d/S01netdata
rm /etc/rc5.d/S01netdata
rm /etc/rc6.d/S01netdata
rm /usr/sbin/netdata
rm -rf /var/lib/dpkg/info/netdata* -R
rm -rf /var/lib/apt/lists/packagecloud.io_netdata* -R
rm -rf /usr/share/netdata -R
rm -rf /usr/share/doc/netdata* -R
rm /usr/share/lintian/overrides/netdata*
rm /usr/share/man/man1/netdata.1.gz
rm /var/lib/systemd/deb-systemd-helper-enabled/netdata.service.dsh-also
rm /var/lib/systemd/deb-systemd-helper-enabled/multi-user.target.wants/netdata.service
rm /var/lib/systemd/deb-systemd-helper-masked/netdata.service

rm -rf /usr/lib/netdata -R
rm -rf /etc/rc2.d/S01netdata -R
rm -rf /etc/rc3.d/S01netdata -R
rm -rf /etc/rc4.d/S01netdata -R
rm -rf /etc/rc5.d/S01netdata -R
rm -rf /etc/default/netdata -R
rm -rf /etc/apt/sources.list.d/netdata.list
rm -rf /etc/apt/sources.list.d/netdata-edge.list
rm -rf /etc/apt/trusted.gpg.d/netdata-archive-keyring.gpg
rm -rf /etc/apt/trusted.gpg.d/netdata-edge-archive-keyring.gpg
rm -rf /etc/apt/trusted.gpg.d/netdata-repoconfig-archive-keyring.gpg
rm -rf /SM_DATA/sm_virt_machines/media/netdata-uninstaller.sh
rm -rf /SM_DATA/sm_virt_machines/media/netdata*
rm -rf /SM_DATA/working/netdata-kickstart*
rm -rf /usr/share/lintian/overrides/netdata
rm -rf /var/cache/apt/archives/netdata*
rm -rf /opt/netdata*
rm -rf /etc/cron.daily/netdata-updater

rm -rf /usr/libexec/netdata -R
rm -rf /var/log/netdata -R
rm -rf /var/cache/netdata -R
rm -rf /var/lib/netdata -R
rm -rf /etc/netdata -R
rm -rf /opt/netdata -R

systemctl daemon-reload
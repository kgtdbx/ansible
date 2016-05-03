#####################################################
# Hadoop pre-requisite Verifier Script
# Author Suraj Kumar J
####################################################

echo 1.IP4TABLES

/etc/init.d/iptables status
chkconfig iptables --list


echo 2.IP6TABLES

/etc/init.d/ip6tables status
chkconfig ip6tables --list


echo 3.IPv6
cat /etc/sysctl.conf | grep "net.ipv6.conf.all.disable_ipv6=*" 1>/dev/null
a=$?
cat /etc/sysctl.conf | grep "net.ipv6.conf.all.disable_ipv6=*" | awk 'BEGIN { FS = "=" } ; { if ( $2 == 1 ) print "IPv6 is OFF"; else if ( $2 == 1) print "WARNING : IPv6 is ON"; }'

if [ $a -ne 0 ] ; then
echo -e "No IPv6 entry found" 
else
echo "" > /dev/null
fi


echo 4.SELINUX


cat /etc/selinux/config | grep -i SELINUX=* | awk 'NR==6' | awk 'BEGIN { FS = "=" } ; { if ( $2 == "enabled" ) print "WARNING : SELINUX is ON"; else print "SELINUX is OFF"; }'


echo 5.Hugepage Compaction

cat /sys/kernel/mm/redhat_transparent_hugepage/defrag | awk 'BEGIN { FS = " " } ; { if ( $1 == "[always]" ) print "WARNING : HPC is ON"; else print "HPC is OFF"; }'



echo 6.Swappiness
cat /etc/sysctl.conf | grep "vm.swappiness=*" 1>/dev/null
a=$?
cat /etc/sysctl.conf | grep "vm.swappiness=*" | awk 'BEGIN { FS = "=" } ; { if ( $2 == 0 ) print "SWAPPINESS is OFF"; else print "WARNING : SWAPPINESS is ON"; }'
if [ $a -ne 0 ] ; then
echo -e "No Swappiness entry found" 
else
echo " "
fi

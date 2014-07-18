#!/usr/bin/env bash

TMPFILE=`mktemp --suffix=-varnish-monitoring`
TMPFILE2=`mktemp --suffix=-varnish-monitoring`
ZABBIX=$(awk -F= '/^ServerActive/ { print $2 } ' /etc/zabbix/zabbix_agentd.conf)

trap "rm -f $TMPFILE; rm -f $TMPFILE2; exit" SIGHUP SIGINT SIGTERM EXIT

/usr/bin/varnishstat -1 |awk '{print "'`hostname -f`'" " " $1 " " $2}' > $TMPFILE

/usr/bin/zabbix_sender -z $ZABBIX -i $TMPFILE
rm -f $TMPFILE

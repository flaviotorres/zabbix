#!/usr/bin/env bash
# grab , print and send zookeeper monitoring values to zabbix via zabbix_sender
# ZooKeeper Commands: The Four Letter Words in: http://zookeeper.apache.org/doc/r3.4.6/zookeeperAdmin.html
# Flavio Torres, ftorres_ig.com.br
# Mar, 2014
# v1, beta

TMPFILE=`mktemp --suffix=-zookeeper-monitoring`
TMPFILE2=`mktemp --suffix=-zookeeper-monitoring`

ZABBIX=$(awk -F= '/^ServerActive/ { print $2 } ' /etc/zabbix/zabbix_agentd.conf)

trap "rm -f $TMPFILE; rm -f $TMPFILE2 ; exit" SIGHUP SIGINT SIGTERM EXIT

echo "mntr" | curl -s telnet://localhost:2181 > $TMPFILE

RUNNING_OK=$(echo "ruok" | curl -s telnet://localhost:2181)
if [ $RUNNING_OK = 'imok' ];then
    echo "zk_running_ok 0" >> $TMPFILE
else
    # NOK or with no response
    echo "zk_running_ok 1" >> $TMPFILE
fi

IFS=$'\n'
for d in `cat $TMPFILE`
do
        echo "$HOSTNAME $d" >> $TMPFILE2
done

IFS=""

/usr/bin/zabbix_sender -z $ZABBIX -i $TMPFILE2
rm -f $TMPFILE ; rm -f $TMPFILE2

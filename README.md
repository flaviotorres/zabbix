zabbix
======

# zabbix Apache Solr

template_apache_solr.xml

Para usar o template do Solr para a sua instância altere o valor 'solr/search' para o nome da sua instância.
* Ex: <host/>solr/instância

NOTA: Você pode verificar o nome dos MBeans expostos conectando via jconsole diretamente em sua aplicação.

Exemplo utilizando o jmxclient command line tools para imprimir valores dos MBeans
<pre>java -jar cmdline-jmxclient-0.10.3.jar - IP_SERVER:JMX_PORT solr/INSTANCIA:type=documentCache,id=org.apache.solr.search.LRUCache hits</pre>

Exemplo utilizando o check_jmx para nagios
<pre>./check_jmx IP_SERVER:JMX_PORT solr/INSTANCIA:type=search,id=org.apache.solr.handler.component.SearchHandler avgRequestsPerSecond</pre>

Habilitar a instância Java para receber conexões remotas JMX (adicione no seu JAVA_OPTS)
<pre>-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=12345 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false</pre>

# zabbix Zookeeper

Esse template monitora 18 itens do zookeeper, sendo:

<pre>
zk_version
zk_avg_latency
zk_max_latency
zk_min_latency
zk_packets_received
zk_packets_sent
zk_num_alive_connections
zk_outstanding_requests
zk_server_state
zk_znode_count
zk_watch_count
zk_ephemerals_count
zk_approximate_data_size
zk_open_file_descriptor_count
zk_max_file_descriptor_count
zk_running_ok
</pre>

Template: zbx_zookeeper_templates.xml
Script: check_zookeeper_trapper.sh
Zabbix conf: check_zookeeper_trapper.conf



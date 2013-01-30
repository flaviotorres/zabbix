zabbix
======

# zabbix Apache Solr

template_apache_solr.xml

Para usar o template do Solr para a sua instancia altere o valor 'solr/search' para o nome da sua instancia.
* Ex: <host/>solr/instancia

Exemplo utilizando o jmxclient command line tools
<pre>java -jar cmdline-jmxclient-0.10.3.jar - IP_SERVER:JMX_PORT solr/\<instance\>:type=documentCache,id=org.apache.solr.search.LRUCache hits</pre>

Exemplo utilizando o check_jmx para nagios
<pre>./check_jmx IP_SERVER:JMX_PORT solr/\<instance\>:type=search,id=org.apache.solr.handler.component.SearchHandler avgRequestsPerSecond</pre>

Habilitar a instancia Java para receber conexoes remotas JMX (adicione no seu JAVA_OPTS)
<pre>-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=12345 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false</pre>

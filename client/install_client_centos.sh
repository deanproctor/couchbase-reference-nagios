#!/bin/bash

yum install -y epel-release
yum install -y nrpe nagios-plugins-load nagios-plugins-swap nagios-plugins-disk nagios-plugins-procs nagios-plugins-ntp sysstat bc PyYAML
yum install -y yum install -y http://www.nsca-ng.org/download/redhat/nsca-ng-client-1.4-1.el6.x86_64.rpm

echo "allowed_hosts=192.168.0.0/16" >> /etc/nagios/nrpe.cfg
echo "dont_blame_nrpe=1" >> /etc/nagios/nrpe.cfg 

curl -o /usr/lib64/nagios/plugins/check_mem.sh "https://exchange.nagios.org/components/com_mtree/attachment.php?link_id=6509&cf_id=24"
chmod a+x /usr/lib64/nagios/plugins/check_mem.sh

curl -o /tmp/check_diskio.sh "https://exchange.nagios.org/components/com_mtree/attachment.php?link_id=3944&cf_id=24"
tr "\r" "\n" < /tmp/check_diskio.sh > /usr/lib64/nagios/plugins/check_diskio
rm /tmp/check_diskio.sh
chmod a+x /usr/lib64/nagios/plugins/check_diskio

curl -o /usr/lib64/nagios/plugins/check_tcp_stat.sh https://raw.githubusercontent.com/June-Wang/NagiosPlugins/master/check_tcp_stat.sh
chmod a+x /usr/lib64/nagios/plugins/check_tcp_stat.sh

curl -o /usr/lib64/nagios/plugins/check_process_resources.sh https://gist.githubusercontent.com/deanproctor/d4417f011a926855646b0f1483f3a64f/raw/2fb064daf0d4d2205c4d309e173c4c0f97fee34d/check_process_resources.sh
chmod a+x /usr/lib64/nagios/plugins/check_process_resources.sh

curl -o /usr/lib64/nagios/plugins/check_open_fds https://gist.githubusercontent.com/deanproctor/62730446d2a35030ad5f7054fe1d3537/raw/8c868c9522bf4cca865fcd69e156d97e353b5c77/check_open_fds
chmod a+x /usr/lib64/nagios/plugins/check_open_fds

curl -o /usr/lib64/nagios/plugins/check_cpu_perf.sh https://raw.githubusercontent.com/skywalka/check-cpu-perf/master/check_cpu_perf.sh
chmod a+x /usr/lib64/nagios/plugins/check_cpu_perf.sh

curl -o /usr/lib64/nagios/plugins/check_couchbase.py https://raw.githubusercontent.com/deanproctor/nagios-plugin-couchbase/master/check_couchbase.py
chmod a+x /usr/lib64/nagios/plugins/check_couchbase.py

curl -o /etc/nagios/check_couchbase.yaml https://raw.githubusercontent.com/deanproctor/nagios-plugin-couchbase/master/check_couchbase.yaml

curl -o /etc/nrpe.d/couchbase.cfg https://raw.githubusercontent.com/deanproctor/couchbase-nagios-reference/master/client/nrpe_couchbase.cfg

systemctl enable nrpe.service
systemctl start  nrpe.service

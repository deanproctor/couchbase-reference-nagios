FROM centos:latest

ENV NAGIOS_CONF_DIR=/etc/nagios
ENV NAGIOS_PLUGINS_DIR=/usr/lib64/nagios/plugins

RUN yum update && \ 
    yum install -y epel-release && \
    yum install -y curl nrpe nagios-plugins-load nagios-plugins-swap nagios-plugins-disk nagios-plugins-procs nagios-plugins-ntp sysstat bc PyYAML python-requests  && \
    yum install -y http://www.nsca-ng.org/download/redhat/nsca-ng-client-1.4-1.el6.x86_64.rpm

RUN curl -o $NAGIOS_PLUGINS_DIR/check_couchbase.py https://raw.githubusercontent.com/deanproctor/nagios-plugin-couchbase/master/check_couchbase.py  && \
    curl -o $NAGIOS_CONF_DIR/check_couchbase.yaml https://raw.githubusercontent.com/deanproctor/nagios-plugin-couchbase/master/check_couchbase.yaml && \
    curl -o /usr/local/bin/dumb-init -L https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64 

ADD nrpe/nrpe.cfg $NAGIOS_CONF_DIR/nrpe.cfg 		
ADD nrpe/nrpe_couchbase.cfg /etc/nrpe.d/couchbase.cfg 
ADD plugins $NAGIOS_PLUGINS_DIR 		
ADD run-nrpe.sh /usr/sbin/run-nrpe.sh

RUN chmod +x -R $NAGIOS_PLUGINS_DIR   && \
    chmod +x /usr/local/bin/dumb-init && \
    chmod +x /usr/sbin/run-nrpe.sh			

EXPOSE 5666

CMD ["/usr/local/bin/dumb-init", "/usr/sbin/run-nrpe.sh"]

#!/bin/bash

NRPE_EXEC="/sbin/nrpe"

$NRPE_EXEC -c $NAGIOS_CONF_DIR/nrpe.cfg -d

# Wait for NRPE Daemon to exit
PID=$(ps -ef | grep -v grep | grep  "${NRPE_EXEC}" | awk '{print $2}')
if [ ! "$PID" ]; then
  echo "Error: Unable to start nrpe daemon..."
  # exit 1
fi
while [ -d /proc/$PID ] && [ -z `grep zombie /proc/$PID/status` ]; do
    echo "Collecting Couchbase stats..."
    $NAGIOS_PLUGINS_DIR/check_couchbase.py -v -c $NAGIOS_CONF_DIR/check_couchbase.yaml
    sleep 60s
done
echo "NRPE daemon exited. Quitting.."

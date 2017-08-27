# Couchbase Nagios Reference Implementation
This project provides a reference implementation for monitoring Couchbase with Nagios.

Two Docker images are provided: 
* couchbase/nagios: the Nagios server with preconfigured Couchbase host and service templates
* couchbase/nrpe: the Nagios Remote Plugin Execution (NRPE) server with check_couchbase and plugins to monitor the OS

The Nagios container should reside on your monitoring server.

The NRPE container runs on the Couchbase servers.

## Building the images

To build the Nagios server:
```bash
docker build docker/nagios -t couchbase/nagios
```

To build tne NRPE server:
```bash
docker build docker/nrpe -t couchbase/nrpe
```
## Running the containers
To run the Nagios container:
```bash
docker run --name nagios -v $(pwd)/etc:/opt/nagios/etc/ -p 8080:80 -p 5668:5668 -it couchbase/nagios
```

To run the NRPE container:
```bash
docker run --name nrpe -v /:/mnt/ROOT -p 5666:5666 --net=host -it couchbase/nrpe
```

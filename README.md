For the nagios server, run:

docker build docker/nagios -t couchbase/nagios
docker run --name nagios -v $(pwd)/etc:/opt/nagios/etc/ -p 8080:80 -p 5668:5668 -it couchbase/nagios

For the nrpe client, run:

docker build docker/nrpe -t couchbase/nrpe
docker run --name nrpe -v /:/mnt/ROOT -p 5666:5666 --net=host -it couchbase/nrpe

#!/bin/bash

uri=$(pg_tmp -w 10 -t -p 5433 -o "-c listen_addresses='*'")
echo $uri
datadir=$(psql $uri --no-psqlrc -At -c 'show data_directory')
echo $datadir
cat <<EOF >> $datadir/pg_hba.conf
host          all           all          0.0.0.0/0             trust
EOF
pg_ctl -D $datadir reload
cat iris_create.sql | sed "s|{pwd}|$(pwd)|" > iris_create.sql.tmp
cat fire_incident.sql | sed "s|{pwd}|$(pwd)|" > fire_incident.sql.tmp
psql $uri -c "CREATE EXTENSION postgis;"
psql $uri -f iris_create.sql.tmp
psql $uri -f fire_incident.sql.tmp
psql $uri -f sf_jurisdictions.sql
psql $uri -f jurisdiction_incidents.sql
rm iris_create.sql.tmp
rm fire_incident.sql.tmp
psql $uri


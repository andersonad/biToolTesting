uri=$(pg_tmp -w 10 -t -p 5433 -o "-c listen_addresses='*'")
echo $uri
datadir=$(psql $uri --no-psqlrc -At -c 'show data_directory')
echo $datadir
cat <<EOF >> $datadir/pg_hba.conf
host          all           all          0.0.0.0/0             trust
EOF
pg_ctl -D $datadir reload
# psql $uri -c "CREATE EXTENSION postgis;"
psql $uri -f iris_create.sql
psql $uri -f fire_incident.sql
psql $uri

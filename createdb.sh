cd
createuser _renderd
createdb -E UTF8 -O _renderd gis
psql -a -f postgres.sql

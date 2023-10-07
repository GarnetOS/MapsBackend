#!/bin/bash
set -e
cd
wget https://raw.githubusercontent.com/GarnetOS/MapsBackend/main/postgres.sql
createuser _renderd
createdb -E UTF8 -O _renderd gis
psql -a -f postgres.sql
mkdir ~/src
cd ~/src
git clone https://github.com/gravitystorm/openstreetmap-carto
cd openstreetmap-carto
sudo npm install -g carto
carto -v
carto project.mml > mapnik.xml
mkdir ~/data
cd ~/data
wget https://download.geofabrik.de/europe/czech-republic-latest.osm.pbf
chmod o+rx ~
sudo -u _renderd osm2pgsql -d gis --create --slim  -G --hstore --tag-transform-script ~/src/openstreetmap-carto/openstreetmap-carto.lua -C 2500 --number-processes 2 -S ~/src/openstreetmap-carto/openstreetmap-carto.style ~/data/czech-republic-latest.osm.pbf
cd ~/src/openstreetmap-carto/
sudo -u _renderd psql -d gis -f indexes.sql
cd ~/src/openstreetmap-carto/
mkdir data
sudo chown _renderd data
sudo -u _renderd scripts/get-external-data.py
cd ~/src/openstreetmap-carto/
scripts/get-fonts.sh

\c gis
CREATE EXTENSION postgis;
CREATE EXTENSION hstore;
ALTER TABLE geometry_columns OWNER TO _renderd;
ALTER TABLE spatial_ref_sys OWNER TO _renderd;
\q

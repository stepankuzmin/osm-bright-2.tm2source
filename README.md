# OSM Bright 2 source

## Description

OSM Bright 2 Mapbox Studio source

![thumb](/.thumb.png?raw=true "thumb")

## Dependencies

* Python & Psycopg2 in a Unixy environment
* Osmosis (requires version >= 0.42 for planet files newer than Feb 9 2013)
* PostgreSQL (tested with 9.2)
* PostGIS (tested with 2.0)
* Osmium - make sure osmjs is compiled and in your PATH
* imposm
* shp2pgsql

## Create database

```shell
createdb <database>
psql -d <database> -c 'create extension postgis;'
```

## Setup project

```shell
git clone git@github.com:mystand/osm-bright-2.tm2source.git
cd osm-bright-2.tm2source
git submodule init
git submodule update
psql -d <database> -f postgis-vt-util/postgis-vt-util.sql
```

## Process data

```shell
./setup.sh <database>
```

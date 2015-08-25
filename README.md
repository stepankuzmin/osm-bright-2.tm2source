# OSM Bright 2 source

## Description

OSM Bright 2 Mapbox Studio source

![thumb](/.thumb.png?raw=true "thumb")

## Dependencies

* PostgreSQL
* PostGIS
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
psql -d <database> -f postgis-vt-util/postgis-vt-util.sql
```

## Process data

```shell
./setup.sh <database>
```

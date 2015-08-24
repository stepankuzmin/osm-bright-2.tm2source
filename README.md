# OSM Bright 2 source

## Description

OSM Bright 2 Mapbox Studio source

![thumb](/.thumb.png?raw=true "thumb")

## Dependencies

* PostgreSQL
* imposm

## Create database

```shell
createdb <database>
psql -d <database> -c 'create extension postgis;'
psql -d <database> -f functions.sql
```

## Setup

Load openstreetmap data to database

```shell
./setup.sh <database>
```

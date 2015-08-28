#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

if [ -z "$1" ]; then
   echo "Usage: ./setup.sh <database>"
   exit 1
fi

db=$1
cachedir="$1-cache"

mkdir -p data/$cachedir
cd data

urls=('http://download.geofabrik.de/europe/russia-european-part-latest.osm.pbf'
      'http://download.geofabrik.de/asia/russia-asian-part-latest.osm.pbf'
      'http://download.geofabrik.de/asia/north-korea-latest.osm.pbf'
      'http://download.geofabrik.de/asia/south-korea-latest.osm.pbf'
      'http://download.geofabrik.de/asia/china-latest.osm.pbf'
      'http://download.geofabrik.de/asia/japan-latest.osm.pbf')

# Download and import openstreetmap data
for url in "${urls[@]}"
do
  filename=$(basename $url)
  if [ ! -f $filename ]; then
    echo "${green}[*] Downloading $url${reset}"
    curl -O $url

    echo "${green}[*] Importing $filename${reset}"
    ~/venv/bin/imposm -d $db \
                      -m ../imposm-mapping.py \
                      --cache-dir=$cachedir \
                      --read \
                      --write \
                      --merge-cache \
                      --optimize \
                      --deploy-production-tables \
                      $filename
  fi
done

# Download and import water polygons
if [ ! -f water_polygons.sql ]; then
  url="http://data.openstreetmapdata.com/water-polygons-split-3857.zip"
  filename=$(basename $url)

  echo "${green}[*] Downloading $url${reset}"
  curl -O $url

  echo "${green}[*] Processing $filename${reset}"
  unzip $filename
  shp2pgsql -I -s 3857 water-polygons-split-3857/water_polygons.shp water_polygons > water_polygons.sql

  echo "${green}[*] Importing $filename${reset}"
  psql -d $db -f water_polygons.sql
fi

# echo "${green}[*] Creating indices${reset}"
# psql -d $db -f ../create-indices.sql

# Done!
echo "${green}[*] Done${reset}"
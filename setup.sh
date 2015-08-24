#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

if [ -z "$1" ]; then
   echo "Usage: ./setup.sh <database>"
   exit 1
fi

db=$1
cachedir="cache_$1"

mkdir -p data
cd data

urls=('http://download.geofabrik.de/europe/russia-european-part-latest.osm.pbf'
      'http://download.geofabrik.de/asia/russia-asian-part-latest.osm.pbf')

for url in "${urls[@]}"
do
  filename=$(basename $url)
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
done

echo "${green}[*] Done${reset}"
#!/bin/bash
set -e

cd $(dirname $0)

if [[ -z "$1" ]]; then
  echo "Usage: $0 newver [tag] [headof]"
  exit
fi

set -x

newver=$1
tag=${2:-ruby-${newver}}
headof=$3

if [ ! -d $tag ]; then
  cp -R skel ${tag}

  version="${newver}"
  if [[ -n $headof ]]; then
    version="${version} ${headof}"
  fi

  sed -i'' -e "s/{{version}}/${version}/g" ${tag}/Dockerfile
fi

#!/bin/bash
set -e

cd $(dirname $0)

if [[ -z "$1" ]]; then
  echo "Usage: $0 newver [tag] [headof]"
  exit
fi

set -x

newver=$1
headof=$3

if [ -z $headof ]; then
  headof=${newver:0:3}
fi

tag=${2:-ruby-${headof}}

if [ ! -d $tag ]; then
  cp -R skel ${tag}

  version="${newver}"
  if [[ -n $headof ]]; then
    version="${version} ${headof}"
  fi

  sed -i'' -e "s/{{version}}/${version}/g" ${tag}/Dockerfile
fi

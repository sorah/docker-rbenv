#!/bin/bash

set -x
set -e

REPO=${REPO:-quay.io/sorah/rbenv}
BUILD_RESULT_FILE=${BUILD_RESULT_FILE:-/tmp/docker-rbenv.tags}

rm -f ${BUILD_RESULT_FILE}

build_ruby() {
  local dockerfile
  dockerfile=$1/Dockerfile
  install_line="$(grep install-ruby ${dockerfile} | head -n1)"

  local version
  local headof
  version="$(echo "${install_line}" | cut -d ' ' -f 3)"
  headof="$(echo "${install_line}" | cut -d ' ' -f 4)"

  if [ -z $headof ]; then
    headof=${version:0:3}
  fi

  if [ "_${BUILD_AGAIN}" != "_1" ]; then
    docker pull ${REPO}:${version} && return
  fi

  docker build -t ${REPO}:${version} $(dirname ${dockerfile})
  docker tag -f ${REPO}:${version} ${REPO}:${headof}

  echo "${REPO}:${version}" >> ${BUILD_RESULT_FILE}
  echo "${REPO}:${headof}" >> ${BUILD_RESULT_FILE}
}

docker pull quay.io/sorah/gentoo-flavored:latest

docker pull ${REPO}:base || :
docker build -t ${REPO}:base ./base
echo "${REPO}:base" >> ${BUILD_RESULT_FILE}

docker pull ${REPO}:ruby-build || :
docker build -t ${REPO}:ruby-build ./ruby-build
echo "${REPO}:ruby-build" >> ${BUILD_RESULT_FILE}

for x in $(cat ./series); do
  build_ruby $x
done

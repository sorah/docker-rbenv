#!/bin/bash

set -x
set -e

REPO=${REPO:-quay.io/sorah/rbenv}
BUILD_RESULT_FILE=${BUILD_RESULT_FILE:-/tmp/docker-rbenv.tags}

for x in $(cat ${BUILD_RESULT_FILE}); do
  docker push $x
done

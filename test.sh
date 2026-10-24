#!/bin/sh

set -e

cleanup() {
  set +e

  echo "Logs"
  docker logs test

  echo "Stopping Docker image"
  docker stop test
  docker rm -f test
}

echo "Running Docker image"
docker run -d --name test -e LOG_TO_STDOUT=1 -p 80:80 "${CI_REGISTRY_IMAGE}:${TAG}"
trap cleanup EXIT

echo "Sleeping"
sleep 10

echo "Testing"
# Without configuration, Baikal redirects to its installation wizard.
wget -T 30 -q -O - http://docker/baikal/dav.php | grep -q 'Maintenance</title>'
wget -T 30 -q -O - http://docker/baikal/res/core/JQuery/jquery.min.js | grep -q 'jQuery'
echo "Success"

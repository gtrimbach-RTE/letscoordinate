#!/bin/bash

# Copyright (c) 2020, RTE (https://www.rte-france.com)
# Copyright (c) 2020 RTE international (https://www.rte-international.com)
# See AUTHORS.txt
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
# This file is part of the Let’s Coordinate project.

if [[ $1 == 'stop' ]]; then
  ps aux | grep 'bin/run_letscoos.sh' | grep -v '/bin/run_letscoos.sh stop' | awk '{ print $2 }' | xargs kill
  netstat -nlp | grep -E '8082|8080' | awk '{ split($NF,a,"/"); print a[1] }' | xargs kill
  #docker service remove letscoos_kafka letscoos_mariadb letscoos_zookeeper
  cd bin
  docker-compose kill
  exit 0
fi

cd bin
#docker stack deploy -c docker-compose.yml letscoos
docker-compose up -d
sleep 5s
cd ../letsco-data-provider
mvn spring-boot:run &
cd ../letsco-api/
mvn spring-boot:run
returnCode=$?

loopCount=0
while [[ $returnCode != 0 ]] && [[ $loopCount -le 5 ]]; do
  mvn spring-boot:run
  returnCode=$?
  loopCount=$((loopCount + 1))
  echo "loop count: $loopCount"
  sleep 5s
done

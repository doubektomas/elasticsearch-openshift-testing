#!/bin/bash

# create a backup
mkdir -p config-files/backups
oc get -f config-files/elasticsearch-search-guard-users.yaml -o yaml > config-files/backups/elasticsearch-search-guard-users-$(date '+%Y-%m-%d-%H.%M').yaml

# apply the updates
oc apply -f config-files/elasticsearch-search-guard-users.yaml

# restart 
oc scale statefulset elasticsearch --replicas=0
oc scale statefulset elasticsearch --replicas=1
while [ "$(oc get $(oc get pod -l io.kompose.service=elasticsearch -o name) -o 'jsonpath={.status.phase}')" != "Running" ]
do
  echo "waiting for elasticsearch to come up"
  sleep 3
done
echo "elasticsearch is up"

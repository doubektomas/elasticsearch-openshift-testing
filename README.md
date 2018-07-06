
# Elasticsearch Cluster on Openshift

Run the latest version of the Elastic stack on Openshift with [Search Guard support](https://github.com/floragunncom/search-guard).

Based on the official Docker images from Elastic:

* [elasticsearch](https://github.com/elastic/elasticsearch-docker)
* [logstash](https://github.com/elastic/logstash-docker)
* [kibana](https://github.com/elastic/kibana-docker)

**Check the [Demo users and roles](http://docs.search-guard.com/latest/demo-users-roles) documentation page for a list
and description of the built-in Search Guard users.**

PS: This assumes that your cluster is configured to dynamically provision PersistentVolumes.
If your cluster is not configured to do so, you will have to manually provision
10 GiB volumes prior to starting.

You need to set at least 2 `ELASTICSEARCH_URL` and `KIBANA_URL` variables.
If your default storageClassName name is NOT `standard`, then you'll need to set
`STORAGECLASSNAME` also to get started.

### Quick start

```bash
# Create a new project
oc new-project elasticsearch

# Start deployments. Change the variable to your need
oc process -f elasticsearch-search-guard-single-node-version.yaml \
-p NAMESPACE="$(oc project -q)" \
-p KIBANA_URL="kibana.example.com" \
-p ELASTICSEARCH_URL="es.example.com" \
-p STORAGECLASSNAME="managed-nfs-storage" \
| oc apply -f -

```

Once you have your deployment, you can use files in `config-files` folder to
update your config file, like updating users and roles.

For example, to update/change `admin` password:

```bash
# edit 'config-files/elasticsearch-search-guard-users.yaml' with the updated
# password

# run update-sg-user.sh to update elasticsearch
./bin/update-sg-user.sh

```

### Parameters

List of parameters:

```console
  - name: NAMESPACE
    displayName: Your project's namespace
    required: true 
  - name: CLUSTER_NAME
    displayName: Cluster name (cluster.name)
    value: docker-cluster
    required: true 
  - name: ELASTICSEARCH_USERNAME
    displayName: Internal Kibana server user, for configuring elasticsearch.username in kibana.yml
    value: kibanaserver
    required: true 
  - name: ELASTICSEARCH_PASSWORD
    displayName: Internal Kibana server user, for configuring elasticsearch.password in kibana.yml
    value: kibanaserver
    required: true 
  - name: LIVENESSPROBE_CREDENTIALS
    displayName: username & password for liveness probes (default => kibanaserver:kibanaserver)
    description: use 'echo -n "kibanaserver:kibanaserver" | base64' to create the string. ref- https://stackoverflow.com/a/43948832
    value: a2liYW5hc2VydmVyOmtpYmFuYXNlcnZlcg==
    required: true 
  - name: ELASTICSEARCH_IMAGE
    displayName: Elasticsearch image to use
    value: docker.io/jefferyb/elasticsearch-oss:6.3.0-searchguard-22.3
    required: true 
  - name: STORAGECLASSNAME
    displayName: Your storage class name (storageClassName) used in your cluster
    value: standard
    required: true 
  - name: ELASTICSEARCH_VOLUME_CAPACITY
    displayName: Volume space available for data, e.g. 512Mi, 2Gi.
    value: 10Gi
    required: true 
  - name: KIBANA_IMAGE
    displayName: Kibana image to use
    value: docker.io/jefferyb/kibana-oss:6.3.0-searchguard-13
    required: true 
  - name: ELASTICSEARCH_URL
    displayName: Kibana image to use
    required: true 
  - name: KIBANA_URL
    displayName: Kibana image to use
    required: true 
```

For more info:

* https://github.com/deviantony/docker-elk/tree/searchguard
* https://github.com/linkbynet/openshift-stateful-elasticsearch-cluster


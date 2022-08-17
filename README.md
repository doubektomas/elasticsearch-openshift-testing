
# Elasticsearch Cluster on Openshift

PS: This assumes that your cluster is configured to dynamically provision PersistentVolumes.
If your cluster is not configured to do so, you will have to manually provision
10 GiB volumes prior to starting.

You need to set at least 2 `ELASTICSEARCH_URL` and `KIBANA_URL` variables.
If your default storageClassName name is NOT `standard`, then you'll need to set
`STORAGECLASSNAME` also to get started.

### Quick start

```bash
# Create a new project
oc new-project elasticsearch-testing

oc adm policy add-scc-to-user privileged -z default -n elasticsearch-testing

# Start deployments. Make sure you change the variables/parametes to your need
oc process -f https://raw.githubusercontent.com/doubektomas/elasticsearch-openshift-testing/master/openshift-templates/search-guard-version/elasticsearch-search-guard-single-node-version.yaml \
-p NAMESPACE="$(oc project -q)" \
-p KIBANA_URL="kibana.example.com" \
-p ELASTICSEARCH_URL="es.example.com" \
-p STORAGECLASSNAME="managed-nfs-storage" \
| oc apply -f -

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
  - name: STORAGECLASSNAME
    displayName: Your storage class name (storageClassName) used in your cluster
    value: standard
    required: true 
  - name: ELASTICSEARCH_VOLUME_CAPACITY
    displayName: Volume space available for data, e.g. 512Mi, 2Gi.
    value: 10Gi
    required: true 
  - name: ELASTICSEARCH_URL
    displayName: Kibana image to use
    required: true 
  - name: KIBANA_URL
    displayName: Kibana image to use
    required: true 
```


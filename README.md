# TODO:
 - [ ] Make ports for elastic and kibana as parameters
 - [ ] Remove env from elasticsearch pod, it is deprecated, and not needed
 - [ ] Clean up the yaml
 - [ ] Test everything

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
oc process -f https://raw.githubusercontent.com/doubektomas/elasticsearch-openshift-testing/master/openshift-templates/search-guard-version/elasticsearch-search-kibana-single-node.yaml \
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


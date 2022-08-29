# TODO:
 - [x] Make ports for elastic and kibana as parameters
 - [x] Remove env from elasticsearch pod, it is deprecated, and not needed
 - [x] Clean up the yaml (at least from my view)
 - [x] Test everything

# OpenSearch Cluster on Openshift

PS: This assumes that your cluster is configured to dynamically provision PersistentVolumes.
If your cluster is not configured to do so, you will have to manually provision
10 GiB volumes prior to starting.

You need to set at least 2 `ELASTICSEARCH_URL` and `KIBANA_URL` variables.
If your default storageClassName name is NOT `standard`, then you'll need to set
`STORAGECLASSNAME` also to get started.

### Quick start

```bash
# Create a new project
oc new-project opensearch-testing

oc adm policy add-scc-to-user privileged -z default -n opensearch-testing

# Start deployments. Make sure you change the variables/parametes to your need
oc process -f https://raw.githubusercontent.com/doubektomas/elasticsearch-openshift-testing/opensearch-test/openshift-templates/search-guard-version/opensearch-with-dashboards-single-node.yaml \
-p NAMESPACE="$(oc project -q)" \
-p DASHBOARDS_URL="dashboards.example.com" \
-p OPENSEARCH_URL="es.example.com" \
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
  - name: OPENSEARCH_VOLUME_CAPACITY
    displayName: Volume space available for data, e.g. 512Mi, 2Gi.
    value: 10Gi
    required: true
  - name: OPENSEARCH_URL
    displayName: OpenSearch url
    required: true 
  - name: OS_HTTP_PORT
    displayName: OpenSearch http port
    value: "9200"
    required: true
  - name: OS_TRANSPORT_PORT
    displayName: OpenSearch transport port
    value: "9600"
    required: true
  - name: DASHBOARDS_URL
    displayName: OpenSearch-Dashboards url
    required: true 
  - name: DASHBOARDS_PORT
    displayName: OpenSearch-Dashboards port
    value: "5601"
    required: true
```


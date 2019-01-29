# https://github.com/elastic/kibana-docker
FROM docker.elastic.co/kibana/kibana-oss:6.5.4

# Search Guard plugin
# http://docs.search-guard.com/latest/kibana-plugin-installation
ENV searchguard_version='6.5.4-17'
RUN kibana-plugin install https://repo1.maven.org/maven2/com/floragunn/search-guard-kibana-plugin/${searchguard_version}/search-guard-kibana-plugin-${searchguard_version}.zip

# Add your kibana plugins setup here
# Example: RUN kibana-plugin install <name|url>

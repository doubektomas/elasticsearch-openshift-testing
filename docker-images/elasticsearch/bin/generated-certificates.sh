#!/bin/bash

# https://docs.search-guard.com/latest/demo-installer-generated-artefacts

cd config/sgconfig || exit 1

rm -fv esnode* kirk* root-ca* *keystore*

export NODE_FILE_NAME=esnode
export KIRK_FILE_NAME=kirk
export ROOT_CA_FILE_NAME=root-ca

# create root ca
openssl req -x509 -sha256 -nodes -newkey rsa:4096 -new -keyout ${ROOT_CA_FILE_NAME}.key -days 730 -out ${ROOT_CA_FILE_NAME}.pem -subj "/C=de/L=test/O=client/OU=client/CN=root"

# create csr files
openssl req -sha256 -nodes -newkey rsa:4096 -new -keyout ${NODE_FILE_NAME}-key.pem -out ${NODE_FILE_NAME}.csr -subj "/C=de/L=test/O=client/OU=client/CN=node"
openssl req -sha256 -nodes -newkey rsa:4096 -new -keyout ${KIRK_FILE_NAME}-key.pem -out ${KIRK_FILE_NAME}.csr -subj "/C=de/L=test/O=client/OU=client/CN=kirk"

# create/sign certificates
openssl x509 -req -in ${NODE_FILE_NAME}.csr -CA ${ROOT_CA_FILE_NAME}.pem -CAkey ${ROOT_CA_FILE_NAME}.key -CAcreateserial -out ${NODE_FILE_NAME}.pem -days 730 -sha256
openssl x509 -req -in ${KIRK_FILE_NAME}.csr -CA ${ROOT_CA_FILE_NAME}.pem -CAkey ${ROOT_CA_FILE_NAME}.key -CAcreateserial -out ${KIRK_FILE_NAME}.pem -days 730 -sha256

# some clean-up
rm -f *csr root-ca.srl

# check the certs
echo
echo "Checking ${NODE_FILE_NAME}.pem certificate"
openssl x509 -in ${NODE_FILE_NAME}.pem -noout -text | egrep -A4 "Issuer"
echo
echo "Checking ${KIRK_FILE_NAME}.pem certificate"
openssl x509 -in ${KIRK_FILE_NAME}.pem -noout -text | egrep -A4 "Issuer"


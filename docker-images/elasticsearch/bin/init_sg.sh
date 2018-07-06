#!/bin/sh
plugins/search-guard-6/tools/sgadmin.sh \
	-cd config/sgconfig/ \
        -key config/sgconfig/kirk-key.pem \
        -cert config/sgconfig/kirk.pem \
        -cacert config/sgconfig/root-ca.pem \
	-nhnv \
	-icl

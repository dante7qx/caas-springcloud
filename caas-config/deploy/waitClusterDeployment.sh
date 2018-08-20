#!/usr/bin/env sh

Namespace="chsun"
ServerName="caas-config"

SIGNAL=0
while [ $SIGNAL != 1 ]; do
	IMAGE_BUILD_STATUS=`curl --insecure -s -X GET -H "Cache-Control: no-cache" \
		"https://caas.haihangyun.com/rest/deploy/BJ1/$Namespace/$ServerName/status" | \
		python -c "import sys, json; print json.load(sys.stdin)['serviceRuntimeStatus']"`
	echo "IMAGE_BUILD_STATUS: $IMAGE_BUILD_STATUS"
	if [ "$IMAGE_BUILD_STATUS" = "Running" ]; then
		SIGNAL=1
		echo "Deployment succeed"
	elif [ "$IMAGE_BUILD_STATUS" = "Failed" ]; then
		echo "Deployment failed"
		exit -1
	else
		echo "wait for 10s, please waiting....."
		sleep 10s 
	fi
done
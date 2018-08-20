#!/usr/bin/env sh

Namespace="chsun"
ServerCluster1="caas-eureka-1"
ServerCluster2="caas-eureka-2"
ServerCluster3="caas-eureka-3"

SIGNAL1=0
while [ $SIGNAL1 != 1 ]; do
	IMAGE_BUILD_STATUS_1=`curl --insecure -s -X GET -H "Cache-Control: no-cache" \
		"https://caas.haihangyun.com/rest/deploy/BJ1/$Namespace/$ServerCluster1/status" | \
		python -c "import sys, json; print json.load(sys.stdin)['serviceRuntimeStatus']"`
	if [ "$IMAGE_BUILD_STATUS_1" = "Running" ]; then
		SIGNAL1=1
		echo "Deployment 1 succeed"
	elif [ "$IMAGE_BUILD_STATUS_1" = "Failed" ]; then
		echo "Deployment 1 failed"
		exit -1
	else
		echo "wait for 10s, please waiting....."
		sleep 10s 
	fi
done

SIGNAL2=0
while [ $SIGNAL2 != 1 ]; do
	IMAGE_BUILD_STATUS_2=`curl --insecure -s -X GET -H "Cache-Control: no-cache" \
		"https://caas.haihangyun.com/rest/deploy/BJ1/$Namespace/$ServerCluster2/status" | \
		python -c "import sys, json; print json.load(sys.stdin)['serviceRuntimeStatus']"`
	if [ "$IMAGE_BUILD_STATUS_2" = "Running" ]; then
		SIGNAL2=1
		echo "Deployment 2 succeed"
	elif [ "$IMAGE_BUILD_STATUS_2" = "Failed" ]; then
		echo "Deployment 2 failed"
		exit -1
	else
		echo "wait for 10s, please waiting....."
		sleep 10s 
	fi
done

SIGNAL3=0
while [ $SIGNAL3 != 1 ]; do
	IMAGE_BUILD_STATUS_3=`curl --insecure -s -X GET -H "Cache-Control: no-cache" \
		"https://caas.haihangyun.com/rest/deploy/BJ1/$Namespace/$ServerCluster3/status" | \
		python -c "import sys, json; print json.load(sys.stdin)['serviceRuntimeStatus']"`
	if [ "$IMAGE_BUILD_STATUS_3" = "Running" ]; then
		SIGNAL3=1
		echo "Deployment 3 succeed"
	elif [ "$IMAGE_BUILD_STATUS_3" = "Failed" ]; then
		echo "Deployment 3 failed"
		exit -1
	else
		echo "wait for 10s, please waiting....."
		sleep 10s 
	fi
done
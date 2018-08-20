#!/usr/bin/env sh
set -e

if [ ! -f ImageTag.tmp ]; then
    echo "Error: ImageTag.tmp file not found!"
    exit 1
fi

ImageName="caas-eureka"
AppName="caas-springcloud"
Namespace="chsun"
ServerCluster1="caas-eureka-1"
ServerCluster2="caas-eureka-2"
ServerCluster3="caas-eureka-3"
ImageTag=`cat ImageTag.tmp | sed -n '1p'`
echo "ImageTag: $ImageTag"

CREATESERVER1=`curl --insecure -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d "{
    \"imageName\":\"$ImageName\",
    \"tagName\":\"$ImageTag\",
    \"appName\":\"$AppName\",
    \"replicas\":\"1\",
    \"location\":\"BJ1\",
    \"containerConfig\":{\"cpu\":\"2\",\"memory\":\"1024\"},
    \"portsJson\":[{\"containerPort\":\"8761\",\"protocol\":\"TCP\"}],
    \"envsJson\":{\"SPRING_PROFILES_ACTIVE\":\"cluster1\",\"eureka_node1\":\"$ServerCluster1\",\"eureka_node2\":\"$ServerCluster2\",\"eureka_node3\":\"$ServerCluster3\"}
}" "https://caas.haihangyun.com/rest/deploy/$Namespace/services/$ServerCluster1/create" | \
python -c "import sys, json; print json.load(sys.stdin)['statusCode']"`

echo "CREATESERVER1: $CREATESERVER1"
if [ $CREATESERVER1 = -8 ]
then 
    echo "$ServerCluster1 exists"
elif [ $CREATESERVER1 -ne 0 ]
then
    echo "Create Server1 fial"
    exit 1
fi

CREATESERVER2=`curl --insecure -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d "{
    \"imageName\":\"$ImageName\",
    \"tagName\":\"$ImageTag\",
    \"appName\":\"$AppName\",
    \"replicas\":\"1\",
    \"location\":\"BJ1\",
    \"containerConfig\":{\"cpu\":\"2\",\"memory\":\"1024\"},
    \"portsJson\":[{\"containerPort\":\"8761\",\"protocol\":\"TCP\"}],
    \"envsJson\":{\"SPRING_PROFILES_ACTIVE\":\"cluster2\",\"eureka_node1\":\"$ServerCluster1\",\"eureka_node2\":\"$ServerCluster2\",\"eureka_node3\":\"$ServerCluster3\"}
}" "https://caas.haihangyun.com/rest/deploy/$Namespace/services/$ServerCluster2/create" | \
python -c "import sys, json; print json.load(sys.stdin)['statusCode']"`

echo "CREATESERVER2 = $CREATESERVER2"
if [ $CREATESERVER2 = -8 ]
then 
    echo "$ServerCluster2 exists"
elif [ $CREATESERVER2 -ne 0 ]
then
    echo "Create Server2 fial"
    exit 1
fi

CREATESERVER3=`curl --insecure -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d "{
    \"imageName\":\"$ImageName\",
    \"tagName\":\"$ImageTag\",
    \"appName\":\"$AppName\",
    \"replicas\":\"1\",
    \"location\":\"BJ1\",
    \"containerConfig\":{\"cpu\":\"2\",\"memory\":\"1024\"},
    \"portsJson\":[{\"containerPort\":\"8761\",\"protocol\":\"TCP\"}],
    \"envsJson\":{\"SPRING_PROFILES_ACTIVE\":\"cluster3\",\"eureka_node1\":\"$ServerCluster1\",\"eureka_node2\":\"$ServerCluster2\",\"eureka_node3\":\"$ServerCluster3\"}
}" "https://caas.haihangyun.com/rest/deploy/$Namespace/services/$ServerCluster3/create" | \
python -c "import sys, json; print json.load(sys.stdin)['statusCode']"`

echo "CREATESERVER3 = $CREATESERVER3"
if [ $CREATESERVER3 = -8 ]
then 
    echo "$ServerCluster3 exists"
elif [ $CREATESERVER3 -ne 0 ]
then
    echo "Create Server3 fial"
    exit 1
fi


echo "Create begin !"

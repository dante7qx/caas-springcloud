#!/usr/bin/env sh

set -e

if [ ! -f ImageTag.tmp ]; then
    echo "Error: ImageTag.tmp file not found!"
    exit 1
fi

ImageTag=`cat ImageTag.tmp | sed -n '1p'`

echo "ImgTag: $ImageTag"

AppName="caas-springcloud"
Namespace="chsun"
ImageName="caas-getway"
ServerName="caas-getway"
EurekaCluster="http://caas-eureka-1:8761/eureka/,http://caas-eureka-2:8761/eureka/,http://caas-eureka-3:8761/eureka/"

CREATESERVER=`curl --insecure -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d "{
    \"imageName\":\"$ImageName\",
    \"tagName\":\"$ImageTag\",
    \"appName\":\"$AppName\",
    \"replicas\":\"2\",
    \"location\":\"BJ1\",
    \"forceUpdate\":true,
    \"containerConfig\":{\"cpu\":\"2\",\"memory\":\"1024\"},
    \"portsJson\":[{\"containerPort\":\"8010\",\"protocol\":\"HTTP\"}],
    \"envsJson\":{\"eureka_cluster\":\"$EurekaCluster\"}
}" "https://caas.haihangyun.com/rest/deploy/$Namespace/services/$ServerName/create" | \
python -c "import sys, json; print json.load(sys.stdin)['statusCode']"`

echo "CREATESERVER: $CREATESERVER"
if [ $CREATESERVER = -8 ]
then 
    echo "$ServerName exists, begin to upgrade..."
    UPGRADESTATUSCODE=`curl --insecure -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '' \
    "https://caas.haihangyun.com/rest/deploy/$Namespace/$ServerName/$ImageTag/upgrade" | \
    python -c "import sys, json; print json.load(sys.stdin)['statusCode']"`
    echo "UPGRADESTATUSCODE: $UPGRADESTATUSCODE"
    if [ $UPGRADESTATUSCODE -ne 0 ]; then
        echo "Upgrade fial"
        exit 1
    fi
elif [ $CREATESERVER -ne 0 ]
then
    echo "Create Server fial"
    exit 1
fi

echo "Upgrade begin !"
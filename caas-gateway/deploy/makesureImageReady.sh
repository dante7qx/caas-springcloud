#!/usr/bin/env sh

if [ ! -f ImageTag.tmp ]; then
    echo "Error: ImageTag.tmp file not found!"
    exit 1
fi

ImageName="caas-getway"
Namespace="chsun"
ImageTag=`cat ImageTag.tmp | sed -n '1p'`
echo "ImageTag: $ImageTag"

SIGNAL=0
while [[ $SIGNAL != 1 ]]
    do
        IMAGE_BUILD_STATUS=`curl --insecure -s -X GET -H "Cache-Control: no-cache" \
            "https://caas.haihangyun.com/rest/queryImage/$Namespace/$ImageName/$ImageTag" | \
            python -c "import sys, json; print json.load(sys.stdin)['imageBuildStatus']"`
        if [ "$IMAGE_BUILD_STATUS" = "Complete" ]; then
            SIGNAL=1
            echo "build image complete"
        elif [ "$IMAGE_BUILD_STATUS" = "Failed" ]; then
            echo "build image failed"
            exit -1
        else
            echo "wait for 10s, please waiting....."
            sleep 10s 
        fi
done

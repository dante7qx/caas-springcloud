#!/usr/bin/env sh

ImageName="caas-eureka"
Namespace="chsun"

BUILDRESULT=`curl --insecure -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d "{
  \"namespace\":\"$Namespace\",
  \"gitlabBranch\":\"master\",
  \"gitlabPassword\":\"qwe123!@\",
  \"gitlabUser\":\"devops\",
  \"imageName\":\"$ImageName\",
  \"gitlabRepo\":\"http://gitbj.haihangyun.com/ch.sun/caas.git\",
  \"dockerPath\":\"caas-eureka/deploy/Dockerfile\"
}" "https://caas.haihangyun.com/rest/buildImage" | \
  python -c "import sys, json; print json.dumps(json.load(sys.stdin))"`

function getField
{
    Json=${1}
    Field=${2}
    echo $BUILDRESULT | python -c "import sys, json; \
        val = json.load(sys.stdin)[\"${Field}\"]; \
        print unicode(val).encode('utf8')"
}

BUILDSTATUSCODE=`getField "$BUILDRESULT" "statusCode"`
BUILDSTATUSMSG=`getField "$BUILDRESULT" "status"`
if [ "$BUILDSTATUSCODE" = "0" ]; then 
    echo $BUILDRESULT
    IMAGETAG=`echo $BUILDRESULT | python -c 'import sys, json; print json.load(sys.stdin)["imageTag"]'`
    echo $IMAGETAG | cut -d ':' -f 2 > ImageTag.tmp
    echo "build image success: $IMAGETAG"
else
    echo "build image fail. Exit code: $BUILDSTATUSCODE, $BUILDSTATUSMSG"
    exit  1
fi
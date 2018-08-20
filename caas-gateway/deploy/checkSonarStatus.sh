#!/bin/bash

SONAR_KEY="CAAS:PROVIDER"
STATUS=$(curl -qsSL "http://sonar.haihangyun.com/api/qualitygates/project_status?projectKey=${SONAR_KEY}" | jq .projectStatus.status | grep -o "\w\+")
if [ "${STATUS}" = "ERROR" ]; then
    echo "代码质量扫描未通过，请检查 http://http://sonar.haihangyun.com/overview?id=${SONAR_KEY} 的扫描报告并修复！"
    exit -1
fi
echo "代码质量扫描完成！"

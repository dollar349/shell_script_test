#!/bin/bash
GITLAB_TOKEN=xxxxxxxxxxxxxxxxxx
CI_PROJECT_ID=40183407
CI_API_V4_URL=https://gitlab.com/api/v4
PER_PAGE=100
PAGE=1
JSON_TMP_FILE=package.json
DATE=2022-11-30
while [ 1 ];do
    curl -s -o ${JSON_TMP_FILE} -H "PRIVATE-TOKEN:${GITLAB_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/packages?page=${PAGE}&per_page=${PER_PAGE}"
    DELETE_URL=`cat ${JSON_TMP_FILE} | jq ".[] | select(.name==\"DailyBuild\")| select(.version==\"${DATE}\") | ._links.delete_api_path"`
    if test "${DELETE_URL}" != ""; then
        # Remove first and last quote (")
        DELETE_URL=`echo ${DELETE_URL} | tr -d '"'`
        echo "delete ${DATE}'s DailyBuild URL = ${DELETE_URL}"
        curl -s --request DELETE -H "PRIVATE-TOKEN:${GITLAB_TOKEN}" ${DELETE_URL}
        break
    fi
    COUNT=`cat ${JSON_TMP_FILE} | jq '. | length'` 
    if [[ "$COUNT" == "" ||  "$COUNT" -lt "${PER_PAGE}" ]]; then
        break
    fi
    PAGE=$((PAGE+1))
    echo $PAGE
done


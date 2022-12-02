#!/bin/bash

GITLAB_TOKEN=""
getVertivAccessToken()
{
    local git_credentials=""
    local token_tmp=""

    if [ ! -f ${HOME}/.git-credentials ]; then
        echo "${HOME}/.git-credentials not found."
        return 1
    fi

    git_credentials="$(cat ${HOME}/.git-credentials | grep -v '^#' | grep "gitlab.com")"

    if test "x${git_credentials}" = "x"; then
        echo "Credentials for gitlab.com not found."
        return 1
    fi

    token_tmp="$(echo ${git_credentials} | awk -F '@' '{print $1}' | awk -F '//' '{print $NF}')"

    if test "${token_tmp}" = ""; then
         echo "Access token for gitlab.com not found."
         return 1
    fi

    if [ $(echo "${token_tmp}" | grep -i ":" | wc -w) -gt 0 ]; then
        # remove username.
        GITLAB_TOKEN="$(echo ${token_tmp} | awk -F ':' '{print $NF}')"
    else
        GITLAB_TOKEN="${token_tmp}"
    fi
}

TARGET_MACHINE=ast2600evb
ENV_CACHE="No cache use"
CI_JOB_URL="http:112/"
#cat <<EOF > COMMENT
## [${TARGET_MACHINE}] The auto merge-request build has been started (${ENV_CACHE})
#\`\`\`
#\$ 123
#\`\`\`
#EOF
cat << EOF > COMMENT
## Image loaction
* http://10.162.243.217/inc/dailybuild/inc-ipsl/
\`\`\`
$ setenv serverip 10.162.243.220;setenv rootpath dollar/;saveenv;dhcp
\`\`\` 
EOF
# Get access token from 
getVertivAccessToken
CI_API_V4_URL="https://gitlab.com/api/v4"
CI_PROJECT_ID="40183407"
CI_MERGE_REQUEST_IID=84
#curl --request POST --header "PRIVATE-TOKEN:${GITLAB_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/merge_requests/84/notes?body=%60Please wait ...%60"
cp COMMENT msg_tmp
sed -i "s/#/%23/g" msg_tmp
sed -i "s/\!/%21/g" msg_tmp
COMMENT=$(sed ":a;N;s/\n/ %20%0A/g;ta" msg_tmp)
curl -s -X POST -H "PRIVATE-TOKEN:${GITLAB_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/merge_requests/${CI_MERGE_REQUEST_IID}/notes?body=${COMMENT}" | jq .id
#COMMENT_ID=$(curl -s -X POST -H "PRIVATE-TOKEN:${GITLAB_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/merge_requests/${CI_MERGE_REQUEST_IID}/notes?body=${COMMENT}" | jq .id)
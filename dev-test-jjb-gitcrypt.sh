#!/bin/bash

source config/api_token.env

cat > dev_jenkins_jobs.ini <<EOF
[job_builder]
ignore_cache=True
keep_descriptions=False
recursive=True

[jenkins]
url=https://dev-jenkins-lab.duckdns.org/
user=Mounika
password=$API_TOKEN
query_plugins_info=False
EOF

jenkins-jobs --conf dev_jenkins_jobs.ini test jobs

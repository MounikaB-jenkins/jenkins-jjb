#!/bin/bash

# Get the JSON secret
SECRET=$(aws secretsmanager get-secret-value \
  --secret-id jenkins-apitoken \
  --query SecretString \
  --output text)

# Extract username and token
USER=$(echo "$SECRET" | jq -r '.username')
TOKEN=$(echo "$SECRET" | jq -r '.token')

# Generate jenkins_jobs.ini
cat > jenkins_jobs.ini <<EOF
[job_builder]
ignore_cache=True
keep_descriptions=False
recursive=True

[jenkins]
url=https://my-jenkins-lab.duckdns.org/
user=$USER
password=$TOKEN
query_plugins_info=False
EOF

echo "===== Generated jenkins_jobs.ini ====="
cat jenkins_jobs.ini
echo "======================================"

# Test JJB
jenkins-jobs --conf jenkins_jobs.ini update jobs

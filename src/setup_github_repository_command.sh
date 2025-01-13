#!/bin/bash

check_variable GITHUB_TOKEN
check_variable ECHO_SERVICE_DOCKERHUB_IMAGE
check_variable DOCKERHUB_USERNAME
check_variable DOCKERHUB_TOKEN


# This script will create a new repository in GitHub and return the clone URL
# and the manifest clone URL

# change directory to the root of the repo
cd resources/git-automation || exit

# initialize terraform
terraform init

# apply terraform
terraform apply

# get the clone URL
ECHO_SERVICE_GIT_CLONE_URL=$(terraform output -raw echo_service_http_clone_url)

# get the manifest clone URL
MANIFEST_GIT_CLONE_URL=$(terraform output -raw echo_service_manifest_http_clone_url)

# get the cluster bootstrap manifest clone URL
CLUSTER_BOOTSTRAP_MANIFEST_GIT_CLONE_URL=$(terraform output -raw cluster_bootstrap_manifest_http_clone_url)

# change directory back to the root of the repo
cd - || exit


# create the echo-service repository
setup_repository echo-service "$ECHO_SERVICE_GIT_CLONE_URL"

# create the echo-service-manifest repository
setup_repository echo-service-manifest "$MANIFEST_GIT_CLONE_URL"

# create the cluster-bootstrap-manifest repository
setup_repository cluster-bootstrap-manifest "$CLUSTER_BOOTSTRAP_MANIFEST_GIT_CLONE_URL"




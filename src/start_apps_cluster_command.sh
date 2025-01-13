#!/bin/bash
echo "# this file is located in 'src/start_apps_cluster_command.sh'"
echo "# code for 'miniArgo start-apps-cluster' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

MEMORY=${args[memory]}
CPUS=${args[cpu]}
KUBERNETESVERSION=${args[kubernetes-version]}
DRIVER=${args[driver]}

# check if minikube is installed
check_mimikube_is_installed

# check if minikube is running with the apps-cluster profile
if ! minikube status --profile apps-cluster | grep -q "host: Running"; then
    echo "apps-cluster is not running"
    # start minikube with the apps-cluster profile
    echo "starting apps-cluster"
    #minikube start  --memory=2096 --cpus=2 --kubernetes-version=1.23.1 --apiserver-ips=$(ipconfig getifaddr en0) --driver=docker --profile apps-cluster
    minikube start  --memory=$MEMORY --cpus=$CPUS --kubernetes-version=$KUBERNETESVERSION --apiserver-ips=$(ipconfig getifaddr en0) --driver=$DRIVER --profile apps-cluster
  exit 1
fi

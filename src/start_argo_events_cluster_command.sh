#!/bin/bash
echo "# this file is located in 'src/start_argo_events_cluster_command.sh'"
echo "# code for 'miniArgo start argo-events-cluster' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

MEMORY=${args[memory]}
CPUS=${args[cpu]}
KUBERNETESVERSION=${args[kubernetes-version]}
DRIVER=${args[driver]}

# check if minikube is installed
check_mimikube_is_installed

# check if minikube is running with the argo-rollouts profile
if ! minikube status --profile argo-events-cluster | grep -q "host: Running"; then
    echo "argo-events-cluster is not running"
    # start minikube with the argo-events-cluster profile
    echo "starting argo-events-cluster"
    #minikube start  --memory=2096 --cpus=2 --kubernetes-version=1.23.1 --apiserver-ips=$(ipconfig getifaddr en0) --driver=docker --profile argo-event-cluster
    minikube start  --memory=$MEMORY --cpus=$CPUS --kubernetes-version=$KUBERNETESVERSION --apiserver-ips=$(ipconfig getifaddr en0) --driver=$DRIVER --profile argo-events-cluster
    minikube addons enable ingress --profile argo-events-cluster
  exit 1
fi

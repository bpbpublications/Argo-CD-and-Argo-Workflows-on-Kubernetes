#!/bin/bash

MEMORY=${args[memory]}
CPUS=${args[cpu]}
KUBERNETESVERSION=${args[kubernetes-version]}
DRIVER=${args[driver]}
NODES=${args[nodes]}
# check if minikube is installed
check_mimikube_is_installed

# check if minikube is running with the argocd-cluster profile
if ! minikube status --profile argocd-cluster | grep -q "host: Running"; then
    echo "argocd-cluster is not running"
    # start minikube with the argocd-cluster profile
    echo "starting argocd-cluster"
    minikube start --container-runtime=docker   --nodes=$NODES  --memory=$MEMORY --cpus=$CPUS --kubernetes-version=$KUBERNETESVERSION --apiserver-ips=$(ipconfig getifaddr en0) --driver=$DRIVER --profile argocd-cluster
    echo "argocd-cluster in running"
else
    echo "argocd-cluster is running"
fi

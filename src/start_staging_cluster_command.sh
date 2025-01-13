#!/bin/bash
echo "# this file is located in 'src/start_staging_cluster_command.sh'"
echo "# code for 'miniArgo start staging-cluster' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args


MEMORY=${args[memory]}
CPUS=${args[cpu]}
KUBERNETESVERSION=${args[kubernetes-version]}
DRIVER=${args[driver]}

# check if minikube is installed
check_mimikube_is_installed

# check if minikube is running with the staging-cluster profile
if ! minikube status --profile staging-cluster | grep -q "host: Running"; then
    echo "staging-cluster is not running"
    # start minikube with the staging-cluster profile
    echo "starting staging-cluster"
    minikube start  --memory=$MEMORY --cpus=$CPUS --kubernetes-version=$KUBERNETESVERSION --apiserver-ips=$(ipconfig getifaddr en0)   --listen-address='0.0.0.0' --driver=$DRIVER --profile staging-cluster
    echo "argocd-cluster in running"
else
    echo "argocd-cluster is running"
fi

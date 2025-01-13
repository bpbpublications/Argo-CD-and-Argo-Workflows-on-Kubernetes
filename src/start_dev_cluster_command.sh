#!/bin/bash
echo "# this file is located in 'src/start_engineering_dev_cluster_command.sh'"
echo "# code for 'miniArgo start dev-cluster' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args


MEMORY=${args[memory]}
CPUS=${args[cpu]}
KUBERNETESVERSION=${args[kubernetes-version]}
DRIVER=${args[driver]}

# check if minikube is installed
check_mimikube_is_installed

# check if minikube is running with the dev-cluster profile
if ! minikube status --profile dev-cluster | grep -q "host: Running"; then
    echo "dev-cluster is not running"
    # start minikube with the dev-cluster profile
    echo "starting dev-cluster"
    minikube start  --memory=$MEMORY --cpus=$CPUS --kubernetes-version=$KUBERNETESVERSION --apiserver-ips=$(ipconfig getifaddr en0)   --listen-address='0.0.0.0' --driver=$DRIVER --profile dev-cluster
    minikube addons enable ingress --profile dev-cluster
    echo "argocd-cluster in running"
else
    echo "argocd-cluster is running"
fi

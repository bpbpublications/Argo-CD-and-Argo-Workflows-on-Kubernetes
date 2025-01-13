#!/bin/bash
echo "# this file is located in 'src/start_argoworkflow_cluster_command.sh'"
echo "# code for 'miniArgo start argoworkflow-cluster' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

MEMORY=${args[memory]}
CPUS=${args[cpu]}
KUBERNETESVERSION=${args[kubernetes-version]}
DRIVER=${args[driver]}
NODES=${args[nodes]}

# check if minikube is installed
check_mimikube_is_installed

# check if minikube is running
if ! minikube status | grep -q "minikube is running"; then
    echo "minikube is not running"
    # start minikube
    echo "starting minikube"
    minikube start --insecure-registry="10.0.0.0/24" --addons=registry --nodes=$NODES --memory=$MEMORY --cpus=$CPUS --kubernetes-version=$KUBERNETESVERSION --driver=$DRIVER --profile argoworkflow-cluster
fi



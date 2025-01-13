#!/bin/bash
echo "# this file is located in 'src/delete_argo_rollouts_cluster_command.sh'"
echo "# code for 'miniArgo delete argo-rollouts-cluster' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

minikube delete --profile argo-rollouts-cluster

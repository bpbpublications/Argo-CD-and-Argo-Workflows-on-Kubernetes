#!/bin/bash
echo "# this file is located in 'src/delete_argocd_cluster_command.sh'"
echo "# code for 'miniArgo delete-argocd-cluster' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

minikube delete --profile argocd-cluster

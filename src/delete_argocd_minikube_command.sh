#!/bin/bash
echo "# this file is located in 'src/delete_argocd_minikube_command.sh'"
echo "# code for 'miniArgo delete-argocd-minikube' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

minikube delete --profile argocd-cluster

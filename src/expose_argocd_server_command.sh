#!/bin/bash
echo "# this file is located in 'src/expose_argocd_server_command.sh'"
echo "# code for 'miniArgo expose-argocd-server' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

kubectl config use-context argocd-cluster

# minikube service argocd-server --url -n argocd --profile argocd-cluster &

kubectl -n argocd port-forward svc/argocd-server 2746:80 -n argocd &

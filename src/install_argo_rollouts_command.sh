#!/bin/bash
echo "# this file is located in 'src/install_argo_rollouts_command.sh'"
echo "# code for 'miniArgo install argo-rollouts' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

NS=$(kubectl get namespace argo-rollouts --ignore-not-found)
if [[ "$NS" ]]; then
  echo "Skipping creation of namespace argo-rollouts - already exists"
else
  echo "Creating namespace argo-rollouts"
  kubectl create namespace argo-rollouts;
fi;

#https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
kubectl apply -n argo-rollouts -f resources/argo-rollouts/install.yaml

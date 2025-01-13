#!/bin/bash
echo "# this file is located in 'src/install_argo_workflow_command.sh'"
echo "# code for 'miniArgo install argo-workflow' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args


NS=$(kubectl get namespace argo --ignore-not-found)
if [[ "$NS" ]]; then
  echo "Skipping creation of namespace argo - already exists"
else
  echo "Creating namespace argo"
  kubectl create namespace argo;
fi;

echo "Checking the diff"
kubectl diff -f resources/argo/install.yaml &>/dev/null || rc=$? || true

if [ $rc -eq 0 ];then
  echo "Looks like argo is already installed on the cluster"
elif [ $rc -eq 1 ];then
  echo "Looks like the argo install but the manifests is diffrent going to apply new chnages."
  kubectl apply -n argo -f resources/argo-workflows/install.yaml
else
  echo "Unable to determine the difference of manifests files."
fi

#Source https://github.com/argoproj/argo-workflows/releases/download/v3.3.9/install.yaml
kubectl apply -n argo -f resources/argo-workflows/install.yaml

kubectl -n argo wait deploy --all --for condition=Available --timeout 2m

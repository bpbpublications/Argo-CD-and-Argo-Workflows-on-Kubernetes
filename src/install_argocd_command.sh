#!/bin/bash
echo "# this file is located in 'src/install_argocd_command.sh'"
echo "# code for 'miniArgo install-argocd' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

kubectl config use-context argocd-cluster


NS=$(kubectl get namespace argocd --ignore-not-found)
if [[ "$NS" ]]; then
  echo "Skipping creation of namespace argocd - already exists"
else
  echo "Creating namespace argocd"
  kubectl create namespace argocd;
fi;

echo "Checking the diff"
kubectl diff -f resources/argocd/install.yaml &>/dev/null || rc=$? || true

if [ $rc -eq 0 ];then
  echo "Looks like argocd is already installed on the cluster"
elif [ $rc -eq 1 ];then
  echo "Looks like the argocd install but the manifests is diffrent going to apply new chnages."
  kubectl apply -n argocd -f resources/argocd/install.yaml
else
  echo "Unable to determine the difference of manifests files."
fi

#Source https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -n argocd -f resources/argocd/install.yaml

#waiting for pod ready

kubectl wait  --timeout=300s --for=condition=Ready pods --all -n argocd

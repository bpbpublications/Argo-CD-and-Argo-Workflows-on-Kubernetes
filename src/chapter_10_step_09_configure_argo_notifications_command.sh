#!/bin/bash
# Switch to the argo cd cluster context:

kubectl config use-context argocd-cluster
# Configure argo cd notifications:
./miniargo configure argocd-notifications

# Test argocd notifications

kubectl delete -f github-repositories/echo-service-manifest/argocd/applications.yaml
kubectl apply -f github-repositories/echo-service-manifest/argocd/applications.yaml
argocd app sync echo-service

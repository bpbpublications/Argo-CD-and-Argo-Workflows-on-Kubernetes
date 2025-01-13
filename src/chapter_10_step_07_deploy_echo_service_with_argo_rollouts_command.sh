#!/bin/bash
# switch to argocd-cluster
kubectl config use-context argocd-cluster
# apply manifests
kubectl apply -f github-repositories/echo-service-manifest/argocd/applications-rollouts.yaml




#!/bin/bash

# start the argocd cluster
./miniargo start argocd-cluster

# install argocd
./miniargo install argocd

# start the dev cluster
./miniargo start dev-cluster

# port forward argocd-server
./miniargo expose argocd-server

# add dev cluster to argocd
./miniargo add-cluster-to-argocd dev-cluster


# cluster bootstrap
kubectl apply -f github-repositories/cluster-bootstrap-manifest/applicationset-cluster-bootstrap.yaml -n argocd


# simple applicationset for argocd
kubectl apply -f github-repositories/echo-service-manifest/cluster-bootstrap/applicationset-echo-service.yaml -n argocd



# start the staging cluster
./miniargo start staging-cluster

# add staging cluster to argocd
./miniargo add-cluster-to-argocd staging-cluster

# start the prod cluster
./miniargo start prod-cluster

# add prod cluster to argocd
./miniargo add-cluster-to-argocd prod-cluster

# change context to argocd-cluster
kubectl config use-context argocd-cluster

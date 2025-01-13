#!/bin/bash

# expose-argocd-server
./miniargo expose argocd-server

kubectl config use-context argocd-cluster

ARGOCDPASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)


argocd login  127.0.0.1:2746 --username admin --password $ARGOCDPASSWORD


kubectl -n argocd port-forward kube-controller-manager-dev-cluster 2746:80 -n argocd &

# mac os spacific
LOCALIP=$(ipconfig getifaddr en0)

#add dev-cluster to argocd
ARGOAPSCLUSTERPORT=$(cat ~/.kube/config | yq '.clusters[] | select(.name == "dev-cluster") | .cluster.server'| cut -f 3 -d ':')
yq eval '(.clusters[] | select(has("name")) | select(.name == "dev-cluster")).cluster.server = "https://'$LOCALIP':'$ARGOAPSCLUSTERPORT'"' -i ~/.kube/config

argocd cluster add dev-cluster


# configure argocd
kubectl config use-context argocd-cluster

ARGO_SERVER="https://$LOCALIP:$ARGOAPSCLUSTERPORT"

yq e '.spec.destination.server = "'$ARGO_SERVER'"' -i github-repositories/echo-service-manifest/argocd/applications.yaml
yq e '.spec.destination.server = "'$ARGO_SERVER'"' -i github-repositories/echo-service-manifest/argocd/applications-rollouts.yaml

# Apply only regcred not exist
kubectl get secret regcred -n argocd || \
kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v2/ --docker-username=$DOCKERHUB_USERNAME --docker-password=$DOCKERHUB_TOKEN -n argocd

# configure argocd notifications
./miniargo configure argocd-notifications

# apply echo-service manifest
kubectl apply -f github-repositories/echo-service-manifest/argocd/projects.yaml
kubectl apply -f github-repositories/echo-service-manifest/argocd/applications.yaml


# open argocd ui
open https://127.0.0.1:2746





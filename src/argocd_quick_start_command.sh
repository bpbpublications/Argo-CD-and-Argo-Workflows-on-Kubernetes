#!/bin/bash

# Starting argocd cluster
./miniargo start argocd-cluster

# installing argocd in argocd-cluster
./miniargo install argocd

# Starting argocd apps cluster
./miniargo start apps-cluster

# expose-argocd-server
./miniargo expose argocd-server

# switch to argocd-cluster
kubectl config use-context argocd-cluster
# get argocd password
ARGOCDPASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)

# login to argocd
argocd login  127.0.0.1:2746 --username admin --password $ARGOCDPASSWORD

# mac os spacific
LOCALIP=$(ipconfig getifaddr en0)

# apps cluster
ARGOAPSCLUSTERPORT=$(cat ~/.kube/config | yq '.clusters[] | select(.name == "apps-cluster") | .cluster.server'| cut -f 3 -d ':')
yq eval '(.clusters[] | select(has("name")) | select(.name == "apps-cluster")).cluster.server = "https://'$LOCALIP':'$ARGOAPSCLUSTERPORT'"' -i ~/.kube/config

# add apps-cluster to argocd
argocd cluster add apps-cluster

# create guestbook app
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default

# expose argocd-server
./miniargo expose argocd-server

# open argocd-server
open https://localhost:2746/

#!/bin/bash

# start the argocd cluster
./miniargo start argocd-cluster

# install argocd
./miniargo install argocd

# start the dev cluster
./miniargo start dev-cluster

# port forward argocd-server
./miniargo expose argocd-server

# collect the argocd-server password
./miniargo get-argocd-user-password

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


# install argoworkflow in argocd-cluster, before install switch to argocd-cluster context
kubectl config use-context dev-cluster

./miniargo install argo-workflow

kubectl patch deployment \
    argo-server  --namespace argo  --type='json' \
    -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [  "server",  "--auth-mode=server" ]}]'

# expose argo argo-workflow-ui
./miniargo expose argo-workflow-ui

#install the argo events in argocd-cluster
./miniargo install argo-events
minikube addons enable ingress --profile dev-cluster

kubectl apply -n argo-events -f resources/argo-events/webhook-eventsource-zap-proxy.yaml

kubectl -n argo-events create -f resources/argo-events/zap-proxy-sensor.yaml



# port forward argo-events webhook
kubectl -n argo-events port-forward $(kubectl -n argo-events get pod -l eventsource-name=webhook-zap-proxy -o name) 14000:14000

# now test the webhook
curl -d '{"target_url":"http://echo-service.echo-service.svc.local"}' -H "Content-Type: application/json" -X POST http://localhost:14000/argoeventswebhook



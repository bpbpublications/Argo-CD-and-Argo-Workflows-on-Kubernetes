#!/bin/bash
# switch to dev-cluster
kubectl config use-context  dev-cluster
# install argo rollouts
./miniargo install argo-rollouts

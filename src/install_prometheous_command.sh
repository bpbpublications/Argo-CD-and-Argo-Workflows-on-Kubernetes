#!/bin/bash
echo "# this file is located in 'src/install_prometheous_command.sh'"
echo "# code for 'miniArgo install prometheous' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args


NS=$(kubectl get namespace monitoring --ignore-not-found)
if [[ "$NS" ]]; then
  echo "Skipping creation of namespace monitoring - already exists"
else
  echo "Creating namespace monitoring"
  kubectl create namespace monitoring;
fi;

helm template  prometheus prometheus-community/prometheus -n monitoring  >  resources/manifrest/prometheus.yaml


helm template  prometheus prometheus-community/prometheus -n monitoring  >  resources/manifrest/prometheus.yaml

kubectl apply -f resources/manifrest/prometheus.yaml -n monitoring

kubectl wait  --timeout=300s --for=condition=Ready pods --all -n monitoring

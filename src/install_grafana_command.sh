#!/bin/bash
echo "# this file is located in 'src/install_grafana_command.sh'"
echo "# code for 'miniArgo install grafana' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args


NS=$(kubectl get namespace monitoring --ignore-not-found)
if [[ "$NS" ]]; then
  echo "Skipping creation of namespace monitoring - already exists"
else
  echo "Creating namespace monitoring"
  kubectl create namespace monitoring;
fi;


helm repo add grafana https://grafana.github.io/helm-charts

helm template grafana grafana/grafana -n monitoring  > resources/manifrest/grafana.yaml


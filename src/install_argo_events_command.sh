#!/bin/bash
echo "# this file is located in 'src/install_argo_events_command.sh'"
echo "# code for 'miniArgo install argo-events' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

NS=$(kubectl get namespace argo-events --ignore-not-found)
if [[ "$NS" ]]; then
  echo "Skipping creation of namespace argo-events - already exists"
else
  echo "Creating namespace argo-events"
  kubectl create namespace argo-events;
fi;

# Deploy Argo Events SA, ClusterRoles, and Controller for Sensor, EventBus, and EventSource.
# https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install.yaml
kubectl apply -f resources/argo-events/install.yaml

# Install with a validating admission controller
# https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install-validating-webhook.yaml
kubectl apply -f resources/argo-events/install-validating-webhook.yaml

# Deploy the eventbus.
# https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml
kubectl apply -n argo-events -f resources/argo-events/native.yaml

kubectl -n argo-events wait deploy --all --for condition=Available --timeout 2m



 # sensor rbac
 # https://raw.githubusercontent.com/argoproj/argo-events/master/examples/rbac/sensor-rbac.yaml
kubectl apply -n argo-events -f resources/argo-events/sensor-rbac.yaml
 # workflow rbac
 # https://raw.githubusercontent.com/argoproj/argo-events/master/examples/rbac/workflow-rbac.yaml
kubectl apply -n argo-events -f resources/argo-events/workflow-rbac.yaml



# depoloy webhook
#https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/event-sources/webhook.yaml

kubectl apply -n argo-events -f resources/argo-events/webhook-eventsource.yaml

# depoloy sensor
#https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/sensors/webhook.yaml

kubectl apply -n argo-events -f resources/argo-events/sensor.yaml



# curl -d '{"message":"this is my first webhook"}' -H "Content-Type: application/json" -X POST http://localhost:12000/example

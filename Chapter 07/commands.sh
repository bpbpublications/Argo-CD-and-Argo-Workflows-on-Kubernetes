# Start minikube with 4GB of memory and 2 CPUs
minikube start  --memory=2096 --cpus=2 --kubernetes-version=1.23.1 --driver=docker --profile argo-events-cluster

# enable ingress addon
minikube addons enable ingress --profile argo-events-cluster

# We are going to trigger an Argo Workflow with Argo events So we need to install the Argo Workflow in the same cluster.
kubectl apply -n argo -f resources/argo-workflows/install.yaml

# Argo Events Cluster-wide Installation
# install argo-workflows
kubectl apply -n argo -f resources/argo-workflows/install.yaml

# Create a namespace with named argo-events with the following command

kubectl create namespace argo-events

# To deploy Argo Events with a validating admission controller, use the following command from the root folder of this book source code:

kubectl apply -f resources/argo-events/install.yaml

# Deploy the eventbus.
kubectl apply -n argo-events -f resources/argo-events/native.yaml

# port-forward the eventbus service
kubectl -n argo-events port-forward $(kubectl -n argo-events get pod -l eventsource-name=webhook -o name) 13000:13000

# Test the eventbus
curl -d '{"message":"this is my first webhook"}' -H "Content-Type: application/json" -X POST http://localhost:13000/argoeventswebhook



# Install with validating admission controller
# install validating admission controller
kubectl apply -f resources/argo-events/install-validating-webhook.yaml
# install argo-events rbac
kubectl apply -n argo-events -f resources/argo-events/workflow-rbac.yaml
# install webhook eventsource
kubectl apply -n argo-events -f resources/argo-events/webhook-eventsource.yaml
# install sensor
kubectl apply -n argo-events -f resources/argo-events/sensor.yaml




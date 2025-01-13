# Check if argo is installed
if ! command -v argo &> /dev/null
then
    echo "argo could not be found"
    exit
fi

# Start minikube with 4GB of memory and 2 CPUs
minikube start --memory=4096 --cpus=2 --kubernetes-version=1.23.1 --driver=docker --profile argoworkflow-cluster

# directly install argo-workflow from the install.yaml file, remember to change the version
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/<version>/install.yaml

# install argo-workflow from the install.yaml file in the resources/argo-workflows directory, already downloaded
kubectl apply -n argo -f resources/argo-workflows/install.yaml

# Check if argo-workflow deployment is ready
kubectl -n argo rollout status --watch --timeout=600s deployment/argo-server

# forward argo-workflow port to localhost
kubectl -n argo port-forward deployment/argo-server 2746:2746

# patch argo-workflow deployment to enable server authentication
kubectl patch deployment \
  argo-server  --namespace argo  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [  "server",  "--auth-mode=server" ]}]'

# submit argo-workflow hello-world example
argo submit -n argo --watch https://raw.githubusercontent.com/argoproj/argo-workflows/master/examples/hello-world.yaml

# list argo-workflow workflows
argo list -n argo

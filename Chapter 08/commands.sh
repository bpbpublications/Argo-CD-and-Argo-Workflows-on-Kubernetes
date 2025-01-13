# Create a namespace for Argo Rollouts by running the following command:
kubectl create namespace argo-rollouts
# apply the Argo Rollouts installation manifest
kubectl apply -n argo-rollouts -f resources/argo-rollouts/install.yaml

# install argo-rollouts cli
brew install argoproj/tap/kubectl-argo-rollouts
# verify the installation
kubectl argo rollouts version

# install kustomize
brew install kustomize

# Start minikube with 4GB of memory and 2 CPUs
minikube start  --memory=2096 --cpus=2 --kubernetes-version=1.23.1 --driver=docker --profile argo-rollouts-cluster

# enable ingress addon
minikube addons enable ingress

# change the context to argo-rollouts-cluster
cd ../resources/argo-rollouts/example

# apply the manifests
kustomize build blue-green | kubectl apply -f -

# watch the rollout status
kubectl argo rollouts get rollout argo-rollouts-bluegreen-demo  --watch

# open the argo rollouts dashboard
kubectl argo rollouts dashboard

# Start minikube cluster for argocd cluster profile with 4GB memory and 2 CPUs
minikube start –nodes=2 --memory=4096 --cpus=2 --kubernetes-version=1.23.1 --driver=docker --profile argocd-cluster

# Create argocd namespace
kubectl create namespace argocd

# Apply argocd crds
kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable

# Install the namespace install from directory resources/argocd/high-availability
kubectl apply -f resources/argocd/high-availability/namespace-install.yaml -n argocd


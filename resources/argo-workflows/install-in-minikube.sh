kubectl create ns argo
kubectl apply -n argo -f quick-start-postgres.yaml

kubectl -n argo port-forward deployment/argo-server 2746:2746

open https://localhost:2746/

# Install the argo cli https://github.com/argoproj/argo-workflows/releases/tag/v3.3.9

wget https://raw.githubusercontent.com/argoproj/argo-workflows/master/examples/hello-world.yaml

argo submit -n argo --watch https://raw.githubusercontent.com/argoproj/argo-workflows/master/examples/hello-world.yaml



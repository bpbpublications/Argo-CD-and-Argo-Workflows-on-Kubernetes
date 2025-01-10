# Make sure the lab environment has those well configured with following tools
# Kubectl commands line tool.  We can find the installation instruction at this link https://kubernetes.io/docs/tasks/tools/
# Docker Desktop. Install instruction  ​​On Mac (https://docs.docker.com/desktop/install/mac-install/) , Windows(https://docs.docker.com/desktop/install/windows-install/) or Linux (https://docs.docker.com/desktop/install/linux-install/)
# Minikube. Install instruction https://minikube.sigs.k8s.io/docs/start/


# Check if required tools are installed
if ! command -v kubectl &> /dev/null
then
    echo "kubectl could not be found"
    exit
fi

if ! command -v docker &> /dev/null
then
    echo "Docker could not be found"
    exit
fi

if ! command -v minikube &> /dev/null
then
    echo "Minikube could not be found"
    exit
fi


# Start minikube cluster for argocd cluster profile with 4GB memory and 2 CPUs
minikube start --memory=4096 --cpus=2 --kubernetes-version=1.23.1 --driver=docker --profile argocd-cluster

# Create argocd namespace
kubectl create namespace argocd

# Apply argocd installation manifest
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Get the all pods in argocd namespace
kubectl get pod -n argocd

# Get the password for argocd admin user
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

# Port forwarding argocd-server service
kubectl -n argocd port-forward svc/argocd-server 2746:80 &

# Get argocd password
ARGOCDPASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)

# Login to argocd
argocd login  127.0.0.1:2746 --username admin --password $ARGOCDPASSWORD

# Argocd cli command to get the argocd context
argocd context


# Use the following command to create guestbook app in argocd
argocd app create guestbook \
--repo https://github.com/argoproj/argocd-example-apps.git \
--path guestbook \
--dest-server https://kubernetes.default.svc \
--dest-namespace default

# Get argocd app
argocd app get guestbook

# argocd app diff
argocd app diff guestbook

# argocd app sync
argocd app sync guestbook

# argocd app get
argocd app get guestbook


# Deploying apps in a different cluster

# Starting minikube cluster for apps cluster profile with 2GB memory and 2 CPUs
minikube start --memory=2096 --cpus=2 --kubernetes-version=1.23.1 --apiserver-ips=$(ipconfig getifaddr en0) --driver=docker --profile apps-cluster

# Check the change in kubeconfig file
cat ~/.kube/config


# mac os spacific
# modify the kubeconfig file to use the local ip address
LOCALIP=$(ipconfig getifaddr en0)
ARGOAPSCLUSTERPORT=$(cat ~/.kube/config | yq '.clusters[] | select(.name == "apps-cluster") | .cluster.server'| cut -f 3 -d ':')
yq eval '(.clusters[] | select(has("name")) | select(.name == "apps-cluster")).cluster.server = "https://'$LOCALIP':'$ARGOAPSCLUSTERPORT'"' -i ~/.kube/config


# Add apps-cluster to argocd, read more on the book
kubectl config use-context argocd-cluster
ARGOCDPASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)
argocd login  127.0.0.1:2746 --username admin --password $ARGOCDPASSWORD
argocd cluster add apps-cluster
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://192.168.0.4:53981 --dest-namespace default




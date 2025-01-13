
add_cluster_to_argocd() {

CLUSTER_PROFILE="$1"

# print CLUSTER_PROFILE to stdout
echo "CLUSTER_PROFILE: $CLUSTER_PROFILE"


kubectl config use-context argocd-cluster

ARGOCDPASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)


argocd login  127.0.0.1:2746 --username admin --password $ARGOCDPASSWORD


# mac os spacific
LOCALIP=$(ipconfig getifaddr en0)

#add $CLUSTER_PROFILE to argocd
ARGOAPSCLUSTERPORT=$(cat ~/.kube/config | yq '.clusters[] | select(.name == "'$CLUSTER_PROFILE'") | .cluster.server'| cut -f 3 -d ':')
yq eval '(.clusters[] | select(has("name")) | select(.name == "'$CLUSTER_PROFILE'")).cluster.server = "https://'$LOCALIP':'$ARGOAPSCLUSTERPORT'"' -i ~/.kube/config

argocd cluster add $CLUSTER_PROFILE

echo "CLUSTER_PROFILE: '$CLUSTER_PROFILE' added and configured in ArgoCD."

}

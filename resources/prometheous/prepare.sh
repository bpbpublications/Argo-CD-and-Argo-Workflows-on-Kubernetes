helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus-operator prometheus-community/kube-prometheus-stack -n argocd



kubectl port-forward svc/prometheus-operated 9090:9090 -n argocd
kubectl port-forward svc/prometheus-operator-grafana 8080:80 -n argocd
kubectl get secret prometheus-operator-grafana -o jsonpath="{.data.admin-password}" -n argocd  | base64 --decode ; echo

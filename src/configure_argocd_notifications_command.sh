#!/bin/bash
# apply argocd-notifications catalog
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/notifications_catalog/install.yaml

# Show error if SLACK_TOKEN and TELEGRAM_TOKEN env variables are not set
check_variable SLACK_TOKEN
check_variable TELEGRAM_TOKEN
# apply argocd-notifications secret, use envsubst to replace env variables
envsubst < resources/argocd-notifications/argocd-notifications-secret-slack.yaml | kubectl apply -n argocd -f -

# apply argocd-notifications configmap
kubectl apply -n argocd -f  resources/argocd-notifications/argocd-notifications-cm-default-subscription.yaml


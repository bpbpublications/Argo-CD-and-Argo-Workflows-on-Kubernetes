#!/bin/bash
echo "# this file is located in 'src/get_argocd_user_password_command.sh'"
echo "# code for 'miniArgo get-argocd-user-password' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

#get argocd password
ARGOCDPASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)

echo "Here is the argocd user: admin"
echo "Here is the argocd password: $ARGOCDPASSWORD"

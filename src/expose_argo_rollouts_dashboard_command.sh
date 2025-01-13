#!/bin/bash
echo "# this file is located in 'src/expose_argo_rollouts_dashboard_command.sh'"
echo "# code for 'miniArgo expose argo-rollouts-dashboard' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

kubectl argo rollouts dashboard

#!/bin/bash
echo "# this file is located in 'src/expose_argo_workflow_ui_command.sh'"
echo "# code for 'miniArgo expose argo-workflow-ui' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args
kubectl -n argo port-forward deployment/argo-server 2747:2746 &

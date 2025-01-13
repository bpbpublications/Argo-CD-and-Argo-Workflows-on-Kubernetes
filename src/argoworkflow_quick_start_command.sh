#!/bin/bash
echo "# this file is located in 'src/argoworkflow_interactive_learning_command.sh'"
echo "# code for 'miniArgo argoworkflow-interactive-learning' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

# Starting argoworkflow cluster
./miniargo start argoworkflow-cluster

#Installing Argo Workflow
./miniargo install argo-workflow

kubectl patch deployment \
  argo-server  --namespace argo  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [  "server",  "--auth-mode=server" ]}]'

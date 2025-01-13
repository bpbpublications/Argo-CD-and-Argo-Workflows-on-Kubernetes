#!/bin/bash
echo "# this file is located in 'src/delete_argoworkflow_cluster_command.sh'"
echo "# code for 'miniArgo delete argoworkflow-cluster' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

minikube delete --profile argoworkflow-cluster

#!/bin/bash
echo "# this file is located in 'src/argorollouts_interactive_learning_install_argo_rollouts_command.sh'"
echo "# code for 'miniArgo argorollouts-interactive-learning install-argo-rollouts' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args


# start argo rollouts cluster
./miniargo start argo-rollouts-cluster

# install argo rollouts
./miniargo install argo-rollouts

# install istio
./miniargo install istio

# install istio-prometheus
./miniargo install istio-prometheus-addon

#!/bin/bash
echo "# this file is located in 'src/install_istio_prometheus_addon_command.sh'"
echo "# code for 'miniArgo install istio-prometheus-addon' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

cd resources/istio-1.17.1/
kubectl apply -f  samples/addons/prometheus.yaml
cd -

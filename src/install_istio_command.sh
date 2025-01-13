#!/bin/bash
echo "# this file is located in 'src/install_istio_command.sh'"
echo "# code for 'miniArgo install istio' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

# Change directory to istio
cd resources/istio-1.17.1/

# export the istio bin path
export PATH=$PWD/bin:$PATH
# back to root directory
cd -

istioctl install --set profile=demo -y

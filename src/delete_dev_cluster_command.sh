echo "# this file is located in 'src/delete_dev_cluster_command.sh'"
echo "# code for 'miniargo delete dev-cluster' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

minikube delete --profile dev-cluster

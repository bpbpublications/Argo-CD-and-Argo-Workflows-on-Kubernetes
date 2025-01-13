#!/bin/bash
PROFILE=${args[profile]}
minikube delete --profile $PROFILE

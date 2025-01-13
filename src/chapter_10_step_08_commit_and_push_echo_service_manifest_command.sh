#!/bin/bash
cd github-repositories/echo-service-manifest/argocd || exit
git commit -am "echo-service-manifest commit with miniargo"
git push
cd - || exit

#!/bin/bash
echo "# this file is located in 'src/create_apps_from_gitrepo_command.sh'"
echo "# code for 'miniArgo create-apps-from-gitrepo' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

argocd app create guestbook \
    --repo https://github.com/argoproj/argocd-example-apps.git \
    --path guestbook --dest-server https://192.168.0.4:57487 \
    --dest-namespace default

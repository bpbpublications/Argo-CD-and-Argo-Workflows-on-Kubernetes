#!/bin/bash
echo "# this file is located in 'src/expose_argo_events_command.sh'"
echo "# code for 'miniArgo expose argo-events' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args



kubectl -n argo-events port-forward $(kubectl -n argo-events get pod -l eventsource-name=webhook -o name) 13000:13000



curl -d '{"message":"this is my first webhook"}' -H "Content-Type: application/json" -X POST http://localhost:13000/argoeventswebhook

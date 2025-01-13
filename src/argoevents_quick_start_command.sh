#!/bin/bash
spinner()
{
  local i j n message chars
  message="$1"
  chars=('F' 'o' 'l' 'l' 'o' 'w' ' ' 't' 'h' 'i' 's' '🗣️' '🗣️' '🗣️')
  n=${#chars[@]}
  while :; do
    for ((i=0; i<n; i++)); do
      printf '\r'
      for ((j=0; j<=i; j++)); do
        printf '%s' "${chars[j]}"
      done
      sleep 0.5
    done
  done
}



echo "🗣️  Starting argo-events-cluster"
./miniargo start  argo-events-cluster

echo "🗣️  Installing Argo Workflow"
./miniargo install argo-workflow

echo "🗣️  Installing Argo Events"
./miniargo install argo-events

echo "🗣️🗣️🗣️  Now Port Forwarding, This will block this terminal, Do not close this terminal and try the following command in another terminal."


spinner "Follow this 🗣️🗣️🗣️" &

echo $'\033[32mcurl -d \'{"message":"this is my first webhook"}\' -H "Content-Type: application/json" -X POST http://localhost:13000/argoeventswebhook\033[0m'


echo "🗣️  Port Forwarding"
kubectl -n argo-events port-forward $(kubectl -n argo-events get pod -l eventsource-name=webhook -o name) 13000:13000


#kill "$!" # Stop the spinner
#printf '\n'  # Print a newline at the end

#!/bin/bash

_miniargo_completions()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="start install expose delete configure setup-github-repository"

    case "${prev}" in
        start)
            local clusters="argocd-cluster apps-cluster argo-events-cluster argo-rollouts-cluster argoworkflow-cluster dev-cluster prod-cluster staging-cluster"
            COMPREPLY=( $(compgen -W "${clusters}" -- ${cur}) )
            return 0
            ;;
        install)
            local components="argocd argo-workflow argo-events argo-rollouts istio grafana prometheus"
            COMPREPLY=( $(compgen -W "${components}" -- ${cur}) )
            return 0
            ;;
        expose)
            local services="argocd-server argo-workflow-ui argo-rollouts-dashboard argo-events"
            COMPREPLY=( $(compgen -W "${services}" -- ${cur}) )
            return 0
            ;;
        delete)
            local clusters="argocd-cluster apps-cluster argo-events-cluster argo-rollouts-cluster argoworkflow-cluster dev-cluster prod-cluster staging-cluster"
            COMPREPLY=( $(compgen -W "${clusters}" -- ${cur}) )
            return 0
            ;;
        configure)
            local configs="argocd-notifications"
            COMPREPLY=( $(compgen -W "${configs}" -- ${cur}) )
            return 0
            ;;
        *)
            ;;
    esac

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _miniargo_completions miniargo
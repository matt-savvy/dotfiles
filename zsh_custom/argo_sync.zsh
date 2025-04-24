#!/bin/bash

function argo_sync() {
    SERVICE=$1
    ENV=$2
    if [[ -z $ENV ]]; then
        ENV=staging
    fi

    echo "SERVICE: $SERVICE"
    echo "ENV: $ENV"

    # argocd app list -p scorebet-$SERVICE -o name --grpc-web | grep "$SERVICE-helm-.*-$ENV" | xargs argocd app sync --grpc-web
    argocd app list -p scorebet-$SERVICE -o name --grpc-web | grep "$SERVICE-helm-.*-$ENV" | xargs argocd app sync --async --grpc-web
}

function argo_list() {
    SERVICE=$1
    ENV=$2
    if [[ -z $ENV ]]; then
        ENV=staging
    fi

    echo "SERVICE: $SERVICE"
    echo "ENV: $ENV"

    argocd app list -p scorebet-$SERVICE --grpc-web | grep "$SERVICE-helm-.*-$ENV"
}

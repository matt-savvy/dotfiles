#!/bin/bash

function k8s_logs() {
    SERVICE=$1
    ENV=$2
    REGION=$3
    kubectl get pods --context scorebet-$REGION-$ENV --namespace $SERVICE --field-selector=status.phase=Running --output name | head -n 1 | xargs kubectl logs --follow --since=20m --context scorebet-$REGION-$ENV --namespace $SERVICE
}


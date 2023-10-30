#!/bin/sh

namespace="skripsi"

declare -a kubeWorkflow=("deployment my-app"
                         "statefulset db"
                         "service app-service db-service"
                         "pvc db-pvc"
                         "pv db-pv"
                         "ingress app-ingress")

declare -a gcloudWorkflow=("disk delete persistant-disk-documenso"
                           "cluster delete documenso-deployment")

# Terminate Kubernetes resource
echo -e "Deleting Kubernetes Workflow"
for i in "${kubeWorkflow[@]}"
do
   kubectl delete $i -n $namespace
done
kubectl delete namespace $namespace

# Terminate Google Cloud resource
echo -e "Deleting Google Cloud Resource"
gcloud compute addresses delete static-documenso-deployment  --global
for i in "${gcloudWorkflow}"
do
    gcloud compute $gcloudWorkflow --zone=us-east1-a
done
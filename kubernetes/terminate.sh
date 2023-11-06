#!/bin/sh

namespace="thesis"

declare -a kubeWorkflow=("deployment documenso-deployment"
                         "statefulset postgres-statefulset"
                         "service app-service db-service"
                         "pvc db-storage-claim"
                         "pv PersistentVolume"
                         "hpa hpa-app"
                         "ingress app-ingress")

# Terminate Kubernetes resource
echo -e "Deleting Kubernetes Workflow"
for i in "${kubeWorkflow[@]}"
do
   kubectl delete $i -n $namespace
done
kubectl delete namespace $namespace

# Terminate Google Cloud resource
echo -e "Deleting Google Cloud Resource"
gcloud compute addresses delete documenso-public-ip  --global
gcloud compute disks delete gke-pv-disk  --zone=us-central1-a
gcloud compute cluster delete documenso-deployment --zone=us-central1-a

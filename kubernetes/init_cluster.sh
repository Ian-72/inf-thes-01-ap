#!/bin/sh

# Create kubernetes cluster
gcloud beta container --project "rich-aspect-403310" clusters create "documenso-deployment" \
    --zone "us-central1-a" \
    --machine-type "n1-standard-2" \
    --image-type "UBUNTU_CONTAINERD" \
    --disk-type "pd-standard" \
    --disk-size "30" \
    --num-nodes "2" \
    --node-locations "asia-southeast1-a" \
    --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
    --logging=SYSTEM,WORKLOAD \
    --monitoring=SYSTEM,STORAGE,POD,DEPLOYMENT,STATEFULSET,HPA \
    --enable-ip-alias \
    --network "projects/rich-aspect-403310/global/networks/default" \
    --subnetwork "projects/rich-aspect-403310/regions/us-central1/subnetworks/default" \
    --no-enable-intra-node-visibility \
    --default-max-pods-per-node "110" \
    --no-enable-master-authorized-networks \
    --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver

# Create 50 persistent disk
gcloud compute disks create gke-pv-disk \
    --project=rich-aspect-403310 \
    --type=pd-standard \
    --size=50GB \
    --zone=asia-southeast1-a

# Reservate static public ip
gcloud compute addresses create documenso-public-ip --project=rich-aspect-403310 --global
gcloud compute addresses list


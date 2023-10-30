gcloud beta container --project "rich-aspect-403310" clusters create "documenso-deployment" \
    --zone "us-central1-a" \
    --machine-type "n1-standard-2" \
    --image-type "UBUNTU_CONTAINERD" \
    --disk-type "pd-standard" \
    --disk-size "30" \
    --num-nodes "2" \
    --node-locations "us-central1-a" \
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

gcloud compute disks create gke-pv-disk \
    --project=rich-aspect-403310 \
    --type=pd-standard \
    --size=50GB \
    --zone=us-central1-a

gcloud compute addresses create documenso-public-ip --project=rich-aspect-403310 --region=us-central1

# Apply namespace
kubectl apply -f namespace.yaml

# Create volume
kubectl apply -f pv.yaml

# Create Ingress
kubectl apply -f ingress/ingress.yaml

# Create service app and database
kubectl apply -f app/service.yaml
kubectl apply -f database/service.yaml

# Create secret management
kubectl apply -f secret.yaml

# Create database statefulset workload
kubectl apply -f database/database.yaml

# Create documenso statefulset workload
kubectl apply -f app/app.yaml

# Enable high availability pod auto scaling
kubectl apply -f app/hpa.yaml


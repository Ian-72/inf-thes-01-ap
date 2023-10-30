#!/bin/bash

# VAR
TIMENOW=$(date)

SUCCESSCOLOR="\e[32m"
ERRORCOLOR="\e[31m"
ENDCOLOR="\e[0m"

enableAPI() {
    countOfSuccess=0
    for api in ${LIST_API[@]}; do
        eval "gcloud services enable $api > /dev/null" 
        if [ $? -eq 0 ]; then
            successAPI=$(($successAPI+1))
            echo -e "${api} : ${SUCCESSCOLOR} ENABLE ${ENDCOLOR}"
        fi
    done

    echo -e "\nTotal All = ${#LIST_API[@]}"
    echo -e "Total Success = ${SUCCESSCOLOR} ${countOfSuccess} ${ENDCOLOR}"
    echo -e "Total Fail = ${ERRORCOLOR} $((${#LIST_API[@]}-$countOfSuccess)) ${ENDCOLOR}"
}

setupKubernetes() {
    gcloud beta container --project "rich-aspect-403310" clusters create "documenso-deployment" \
    --zone "us-central1-a" \
    --no-enable-basic-auth \
    --cluster-version "1.27.3-gke.100" \
    --release-channel "regular" \
    --machine-type "n1-standard-2" \
    --image-type "UBUNTU_CONTAINERD" \
    --disk-type "pd-standard" \
    --disk-size "30" \
    --metadata disable-legacy-endpoints=true \
    --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
    --num-nodes "2" \
    --logging=SYSTEM,WORKLOAD \
    --monitoring=SYSTEM,STORAGE,POD,DEPLOYMENT,STATEFULSET,HPA \
    --enable-ip-alias \
    --network "projects/rich-aspect-403310/global/networks/default" \
    --subnetwork "projects/rich-aspect-403310/regions/us-central1/subnetworks/default" \
    --no-enable-intra-node-visibility \
    --default-max-pods-per-node "110" \
    --security-posture=standard \
    --workload-vulnerability-scanning=disabled \
    --no-enable-master-authorized-networks \
    --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver \
    --enable-autoupgrade \
    --enable-autorepair \
    --max-surge-upgrade 1 \
    --max-unavailable-upgrade 0 \
    --binauthz-evaluation-mode​=DISABLED \
    --enable-managed-prometheus \
    --enable-shielded-nodes \
    --node-locations "us-central1-a"

    gcloud compute disks create disk-1 \
    --project=rich-aspect-403310 \
    --type=pd-standard \
    --size=50GB \
    --zone=us-central1-a

    gcloud compute addresses create test-public-ip --project=rich-aspect-403310 --description=tes --region=us-central1

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
}

setupAutomation() {

}

excute() {
    echo -e "===== Running on $TIMENOW ====="
    ## TODO :  
    # Setup base project
    if ! command -v git &> /dev/null
    then
        sudo apt update; sudo apt install git -y
    fi

    git clone https://github.com/Ian-72/documenso.git


    case $1 in
        '--local-deployment')
            # Read all env local deployment


            # from beggining?


            # prepare to setup database service and integration


            # prepare to setup and storage bucket and integration


            # prepare to setup email service and integration


            # prepare to setup cloud monitoring and integration


            # Create kubernetes cluster


            # 1. Create Cluster
             
            # Create GKE cluster
            echo -e "\n-----CREATE CLUSTER-----"
            gcloud container clusters create example-cluster \
            --num-nodes=2 \
            --zone=us-central1-a \
            --node-locations=us-central1-a,us-central1-b,us-central1-f \
            --enable-autoscaling --min-nodes=1 --max-nodes=4 

            # 2. Create deployment
            ## TODO : Continue to building from deployment.yaml
            
            # 3. Create service

            # 4. Expose service


            # create a user


            # print info


            # runing automation

            ;;
        '--cloud-deployment')
            # Read all env local deployment

            # All API are enable?
            # Start all required API resource
            echo -e "-----ENABLING API-----"
            enableAPI

            # from beggining?

            # prepare to setup database service and integration

            # prepare to setup and storage bucket and integration

            # prepare to setup email service and integration
            
            # prepare to setup cloud monitoring and integration

            # Create kubernetes cluster

            # 1. Create Cluster
            # 2. Create deployment
            # 3. Create service
            # 4. Expose service

            # create a user

            # print info

            # runing automation
            
        ;;
        *)
            echo -e "can't running script with invalid options, avaliable options :"
            echo -e "--local-deployment | to running service on local deployment"
            echo -e "--cloud-deployment | to running service on cloud deploytmnet"
    esac
    
    echo -e "===== Done Execute on $TIMENOW ====="
}

excute

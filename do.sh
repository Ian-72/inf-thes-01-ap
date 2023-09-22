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

}

setupBucket() {

}

setupDatabase() {

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

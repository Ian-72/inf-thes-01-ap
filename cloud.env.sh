#!/bin/bash

PROJECT_ID=$(gcloud config get-value project)
LIST_API=(
    ""
    ""
)

# Adding to more specific
CLUSTER_NAME=''
NUM_OF_NODE=''
CLUSTER_ZONE=''
NODE_LOCATION=''
ENABLE_AUTO_SCALING=''
MIN_NODE=''
MAX_NODE=''
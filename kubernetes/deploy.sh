#!/bin/sh

# Apply namespace
kubectl apply -f namespace.yaml

# Create volume
kubectl apply -f pv.yaml

# Create secret management
kubectl apply -f secret.yaml

# Create database statefulset and db-service
kubectl apply -f database/database.yaml
kubectl apply -f database/service.yaml

# Create documenso deployment and app-service
kubectl apply -f app/app.yaml
kubectl apply -f app/service.yaml

# Create Ingress
kubectl apply -f ingress/ingress.yaml

# Enable high availability pod auto scaling
kubectl apply -f app/hpa.yaml


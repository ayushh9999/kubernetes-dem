#!/bin/bash
# Bash deployment script for Kubernetes
# This script is designed for Linux/Mac environments and includes Docker Hub push

# Define variables for the application name and Docker image
NAME="kubernetes-demo-api"      # Application name
USERNAME="ayush"                # Docker Hub username
IMAGE="$USERNAME/$NAME:latest"  # Full Docker image name with tag

# Step 1: Build the Docker image using the Dockerfile
# The image is tagged with the full name including Docker Hub username
echo "Building Docker image ..."
docker build -t $IMAGE .

# Step 2: Push the built image to Docker Hub
# This makes the image available for pulling from remote Kubernetes clusters
# Note: You must be logged in to Docker Hub (docker login) before this works
echo "Pushing image to Docker Hub ..."
docker push $IMAGE

# Step 3: Apply Kubernetes manifests to create/update resources
# This creates the Deployment (pods) and Service (networking) in the cluster
echo "Applying Kubernetes manifests ..."
kubectl apply -f k8s/deployment.yaml  # Create/update the deployment
kubectl apply -f k8s/service.yaml     # Create/update the service

# Step 4: Display the status of all pods in the cluster
# This shows if pods are running, pending, or have errors
echo "Getting pods ..."
kubectl get pods

# Step 5: Display all services in the cluster
# This shows the service name, type, cluster IP, and ports
echo "Getting services ..."
kubectl get services

# Step 6: Display detailed information about the specific service
# This shows the service configuration and endpoints
echo "Fetching the main service ..."
kubectl get service $NAME-service

# PowerShell deployment script for Kubernetes
# This script automates the complete deployment process for local Kubernetes (Minikube)

# Define variables for the application name and Docker image
$NAME = "kubernetes-demo-api"      # Application name
$USERNAME = "ayush"                # Docker Hub username (if pushing to registry)
$IMAGE = "$USERNAME/$NAME:latest"  # Full Docker image name with tag

# Step 1: Configure the shell to use Minikube's Docker daemon
# This allows Docker commands to build images directly in Minikube's environment
Write-Host "Configuring Minikube Docker environment..." -ForegroundColor Green
& minikube docker-env --shell powershell | Invoke-Expression

# Step 2: Build the Docker image using the Dockerfile in the current directory
# The image is tagged with the application name and 'latest' tag
Write-Host "`nBuilding Docker image..." -ForegroundColor Green
docker build -t $NAME`:latest .

# Step 3: Apply Kubernetes manifests to create/update resources
# This creates the Deployment (pods) and Service (networking) in the cluster
Write-Host "`nApplying Kubernetes manifests..." -ForegroundColor Green
kubectl apply -f k8s/deployment.yaml  # Create/update the deployment
kubectl apply -f k8s/service.yaml     # Create/update the service

# Step 4: Wait for pods to initialize and become ready
# Gives Kubernetes time to schedule and start the pods
Write-Host "`nWaiting for pods to be ready..." -ForegroundColor Green
Start-Sleep -Seconds 5

# Step 5: Display the status of all pods in the cluster
# This shows if pods are running, pending, or have errors
Write-Host "`nGetting pods..." -ForegroundColor Green
kubectl get pods

# Step 6: Display all services in the cluster
# This shows the service name, type, cluster IP, and ports
Write-Host "`nGetting services..." -ForegroundColor Green
kubectl get services

# Step 7: Display detailed information about the specific service
# This shows the NodePort assigned for external access
Write-Host "`nFetching the main service..." -ForegroundColor Green
kubectl get service $NAME-service

# Step 8: Display success message and instructions
Write-Host "`nDeployment complete!" -ForegroundColor Green
Write-Host "To access the service, run: minikube service $NAME-service" -ForegroundColor Yellow

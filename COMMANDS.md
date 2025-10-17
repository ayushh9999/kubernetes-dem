# 🚀 Quick Reference Commands

## Minikube Commands

```powershell
# Start Minikube
minikube start --driver=docker

# Stop Minikube
minikube stop

# Delete cluster
minikube delete

# Check status
minikube status

# Open dashboard
minikube dashboard

# Access service
minikube service kubernetes-demo-api-service

# Get service URL
minikube service kubernetes-demo-api-service --url

# Configure Docker to use Minikube's daemon
minikube docker-env --shell powershell | Invoke-Expression
```

## Kubernetes Commands

```powershell
# Deploy application
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

# Get resources
kubectl get all
kubectl get pods
kubectl get services
kubectl get deployments

# Describe resources
kubectl describe pod <pod-name>
kubectl describe service kubernetes-demo-api-service
kubectl describe deployment kubernetes-demo-api

# View logs
kubectl logs <pod-name>
kubectl logs -l app=kubernetes-demo-api
kubectl logs -f <pod-name>  # Follow logs

# Port forward
kubectl port-forward service/kubernetes-demo-api-service 8080:3000

# Scale deployment
kubectl scale deployment kubernetes-demo-api --replicas=3

# Delete resources
kubectl delete -f k8s/deployment.yaml
kubectl delete -f k8s/service.yaml
kubectl delete pod <pod-name>

# Execute commands in pod
kubectl exec -it <pod-name> -- /bin/sh

# Get pod details
kubectl get pods -o wide
kubectl get pods -o yaml
```

## Docker Commands

```powershell
# Build image
docker build -t kubernetes-demo-api:latest .

# Run container locally
docker run -p 3000:3000 kubernetes-demo-api:latest

# List images
docker images

# Remove image
docker rmi kubernetes-demo-api:latest

# Docker Compose
docker compose up --build
docker compose down
```

## NPM Commands

```powershell
# Install dependencies
npm install

# Run in development mode
npm run dev

# Run in production mode
npm start

# Deploy to Kubernetes
npm run deploy
```

## Testing Commands

```powershell
# Test main endpoint
curl http://localhost:8080/

# Test health endpoint
curl http://localhost:8080/healthz

# Test readiness endpoint
curl http://localhost:8080/readyz

# Test with Invoke-RestMethod
Invoke-RestMethod -Uri http://localhost:8080/ | ConvertTo-Json
```

## Troubleshooting Commands

```powershell
# Check pod events
kubectl get events --sort-by=.metadata.creationTimestamp

# Check pod logs
kubectl logs <pod-name> --previous

# Describe pod for troubleshooting
kubectl describe pod <pod-name>

# Check Minikube logs
minikube logs

# Restart deployment
kubectl rollout restart deployment kubernetes-demo-api

# Check rollout status
kubectl rollout status deployment kubernetes-demo-api

# View rollout history
kubectl rollout history deployment kubernetes-demo-api
```

## Useful Aliases (Optional)

Add these to your PowerShell profile (`$PROFILE`):

```powershell
# Kubectl aliases
function k { kubectl $args }
function kgp { kubectl get pods $args }
function kgs { kubectl get services $args }
function kgd { kubectl get deployments $args }
function kl { kubectl logs $args }
function kd { kubectl describe $args }
function ka { kubectl apply -f $args }
function kdel { kubectl delete $args }

# Minikube aliases
function mk { minikube $args }
function mks { minikube start $args }
function mkstop { minikube stop }
function mkdel { minikube delete }
function mksvc { minikube service $args }
```

## Quick Deploy & Test

```powershell
# Full deployment and test
npm run deploy
Start-Sleep -Seconds 5
minikube service kubernetes-demo-api-service --url
```

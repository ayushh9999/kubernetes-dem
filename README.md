# 🚀 Kubernetes Demo API

<div align="center">

![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Node.js](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white)
![Express.js](https://img.shields.io/badge/express.js-%23404d59.svg?style=for-the-badge&logo=express&logoColor=%2361DAFB)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

**A beginner-friendly Node.js Express API deployed on Kubernetes using Minikube**

[🎯 Features](#-features) • [🛠️ Prerequisites](#️-prerequisites) • [📦 Quick Start](#-quick-start) • [☸️ Kubernetes](#️-kubernetes-commands-cheat-sheet) • [📚 API Docs](#-api-endpoints)

</div>

---

## 🎯 Features

✨ **Simple & Clean** - Minimal Express.js API perfect for learning Kubernetes  
🐳 **Containerized** - Multi-stage Docker build for optimized images  
☸️ **Kubernetes Ready** - Complete deployment and service configurations  
🔄 **High Availability** - Runs 2 replicas for fault tolerance  
💚 **Health Checks** - Built-in liveness and readiness probes  
🔐 **Secure** - Non-root container execution  
📊 **Pod Identification** - Each pod reports its own name in responses  
🎨 **Cross-Platform** - Deployment scripts for both Windows and Linux/Mac

---

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed:

| Tool | Version | Purpose |
|------|---------|---------|
| 📗 **Node.js** | v18 or higher | JavaScript runtime |
| 🐳 **Docker** | Latest | Container platform |
| ☸️ **Minikube** | Latest | Local Kubernetes cluster |
| 🔧 **kubectl** | Latest | Kubernetes CLI tool |

### 📥 Installation Links

- **Node.js**: [https://nodejs.org/](https://nodejs.org/)
- **Docker**: [https://www.docker.com/get-started](https://www.docker.com/get-started)
- **Minikube**: [https://minikube.sigs.k8s.io/docs/start/](https://minikube.sigs.k8s.io/docs/start/)
- **kubectl**: [https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/)

---

## 📂 Project Structure

```
kubernetes-dem/
├── 📁 k8s/                      # Kubernetes manifests
│   ├── 📄 deployment.yaml       # Pod deployment configuration
│   └── 📄 service.yaml          # Service networking configuration
├── 📄 index.js                  # 🎯 Main Express API application
├── 📄 package.json              # 📦 NPM dependencies and scripts
├── 📄 Dockerfile                # 🐳 Container image definition
├── 📄 docker-compose.yaml       # 🐳 Local Docker Compose setup
├── 📄 deploy.ps1                # 🪟 Windows deployment script
├── 📄 deploy.sh                 # 🐧 Linux/Mac deployment script
├── 📄 .dockerignore             # Docker build exclusions
├── 📄 .gitignore                # Git exclusions
├── 📄 README.md                 # 📖 This file!
├── 📄 COMMANDS.md               # 📋 Quick reference guide
├── 📄 VERIFICATION.md           # ✅ Test results
└── 📄 CLEANUP.md                # 🧹 Cleanup documentation
```

---

## 🌐 API Endpoints

| Method | Endpoint | Description | Response |
|--------|----------|-------------|----------|
| 🟢 GET | `/` | Main endpoint - returns service info | `{ message, service, pod, time }` |
| 💚 GET | `/healthz` | Health check for Kubernetes liveness probe | `ok` |
| 💙 GET | `/readyz` | Readiness check for Kubernetes readiness probe | `ready` |

### 📋 Example Response

```json
{
  "message": "Hello, from a container",
  "service": "hello-node",
  "pod": "kubernetes-demo-api-676bff7d88-k57jz",
  "time": "2025-10-18T20:11:05.482Z"
}
```

---

## 🚀 Quick Start

### 1️⃣ Install Dependencies

```bash
npm install
```

### 2️⃣ Start Minikube

```bash
minikube start
```

> 💡 **Tip**: On first run, Minikube will download the Kubernetes cluster image. This may take a few minutes.

### 3️⃣ Deploy to Kubernetes

Choose your platform:

#### 🪟 **Windows (PowerShell)**
```bash
npm run deploy
```

#### 🐧 **Linux/Mac (Bash)**
```bash
npm run deploy:sh
```

> 🎯 **What happens?**
> - Configures Docker to use Minikube's daemon
> - Builds the Docker image locally
> - Applies Kubernetes manifests
> - Creates 2 pod replicas
> - Exposes the service via NodePort

### 4️⃣ Access the Service

Open the service in your browser:
```bash
minikube service kubernetes-demo-api-service
```

Or get the URL without opening browser:
```bash
minikube service kubernetes-demo-api-service --url
```

### 5️⃣ Test the API

```bash
# Using curl
curl http://<minikube-ip>:<port>/

# Using PowerShell
Invoke-RestMethod -Uri http://<minikube-ip>:<port>/ | ConvertTo-Json
```

---

## 💻 Local Development

### 🔥 Run with Hot Reload

```bash
npm run dev
```

The API will be available at `http://localhost:3000`

> 📝 **Note**: Uses Node.js `--watch` flag for automatic restart on file changes

### 🐳 Test with Docker Compose

```bash
docker compose up --build
```

Access at: `http://localhost:3000`

### 🔨 Build Docker Image Manually

```bash
docker build -t kubernetes-demo-api:latest .
```

### 🧪 Run Tests Locally

```bash
# Test main endpoint
curl http://localhost:3000/

# Test health endpoint
curl http://localhost:3000/healthz

# Test readiness endpoint
curl http://localhost:3000/readyz
```

---

## ☸️ Kubernetes Commands Cheat Sheet

### 📊 View Resources

```bash
# View all resources at once
kubectl get all

# View pods
kubectl get pods

# View services
kubectl get services

# View deployments
kubectl get deployment

# Watch resources in real-time
kubectl get pods --watch
```

### 🔍 Inspect Resources

```bash
# Describe a specific pod
kubectl describe pod <pod-name>

# View pod logs
kubectl logs <pod-name>

# Follow logs in real-time
kubectl logs -f <pod-name>

# View logs from all pods with label
kubectl logs -l app=kubernetes-demo-api
```

### ⚙️ Manage Deployment

```bash
# Scale replicas
kubectl scale deployment kubernetes-demo-api --replicas=3

# Restart deployment
kubectl rollout restart deployment kubernetes-demo-api

# Check rollout status
kubectl rollout status deployment kubernetes-demo-api
```

### 🗑️ Clean Up

```bash
# Delete specific resources
kubectl delete -f k8s/deployment.yaml
kubectl delete -f k8s/service.yaml

# Delete all resources with label
kubectl delete all -l app=kubernetes-demo-api
```

---

## ⚙️ Configuration

### 📦 Deployment Configuration (`k8s/deployment.yaml`)

| Setting | Value | Description |
|---------|-------|-------------|
| **Replicas** | `2` | Number of pod instances for high availability |
| **Image** | `kubernetes-demo-api:latest` | Docker image name |
| **Pull Policy** | `Never` | Uses local image (Minikube) |
| **Container Port** | `3000` | Port exposed by the container |
| **NODE_ENV** | `production` | Node.js environment mode |
| **POD_NAME** | `metadata.name` | Dynamically injected pod identifier |

### 🌐 Service Configuration (`k8s/service.yaml`)

| Setting | Value | Description |
|---------|-------|-------------|
| **Type** | `NodePort` | Exposes service on each node's IP |
| **Port** | `3000` | Internal cluster port |
| **Target Port** | `3000` | Container port to forward traffic to |
| **Selector** | `app=kubernetes-demo-api` | Routes traffic to matching pods |

> 💡 **Production Tip**: Change service type to `LoadBalancer` when deploying to cloud platforms like AWS, GCP, or Azure.

---

## 🔧 Troubleshooting

<details>
<summary>🔴 <b>Pods not starting?</b></summary>

Check pod status and events:
```bash
kubectl describe pod <pod-name>
kubectl get events --sort-by=.metadata.creationTimestamp
```

Common causes:
- Image not found (rebuild with Minikube's Docker)
- Resource constraints (check `kubectl top nodes`)
- Configuration errors (check deployment YAML)
</details>

<details>
<summary>🟠 <b>Image pull errors?</b></summary>

Make sure you're using Minikube's Docker daemon:

**PowerShell:**
```bash
minikube docker-env --shell powershell | Invoke-Expression
```

**Bash:**
```bash
eval $(minikube docker-env)
```

Then rebuild the image:
```bash
docker build -t kubernetes-demo-api:latest .
```
</details>

<details>
<summary>🟡 <b>Service not accessible?</b></summary>

1. Check if Minikube is running:
```bash
minikube status
```

2. Verify service exists:
```bash
kubectl get service kubernetes-demo-api-service
```

3. Get the correct URL:
```bash
minikube service kubernetes-demo-api-service --url
```

4. Try port forwarding:
```bash
kubectl port-forward service/kubernetes-demo-api-service 8080:3000
```
Then access at `http://localhost:8080`
</details>

<details>
<summary>🔵 <b>Minikube won't start?</b></summary>

Try these solutions:

```bash
# Delete and recreate cluster
minikube delete
minikube start --driver=docker

# Specify more resources
minikube start --cpus=2 --memory=4096

# Check Docker is running
docker ps
```
</details>

---

## 🧹 Clean Up

### Stop Minikube (preserves cluster)
```bash
minikube stop
```

### Delete Minikube cluster (complete removal)
```bash
minikube delete
```

### Remove Docker images
```bash
docker rmi kubernetes-demo-api:latest
```

### Delete Kubernetes resources only
```bash
kubectl delete -f k8s/
```

---

## 🎓 Learning Resources

Want to learn more about the technologies used in this project?

- 📘 [Kubernetes Official Docs](https://kubernetes.io/docs/home/)
- 📗 [Node.js Documentation](https://nodejs.org/docs/latest/api/)
- 📙 [Express.js Guide](https://expressjs.com/en/guide/routing.html)
- 📕 [Docker Documentation](https://docs.docker.com/)
- 📔 [Minikube Tutorial](https://minikube.sigs.k8s.io/docs/tutorials/)

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the **ISC License**.

---

## 👨‍💻 Author

**Ayush Mondal**

- GitHub: [@ayushh9999](https://github.com/ayushh9999)
- Repository: [kubernetes-dem](https://github.com/ayushh9999/kubernetes-dem)

---

## ⭐ Show Your Support

If this project helped you learn Kubernetes, give it a ⭐️!

---

<div align="center">

**Made with ❤️ and ☕ by Ayush Mondal**

![Made with Love](https://img.shields.io/badge/Made%20with-Love-red?style=for-the-badge)
![Kubernetes](https://img.shields.io/badge/Powered%20by-Kubernetes-blue?style=for-the-badge&logo=kubernetes)

</div>

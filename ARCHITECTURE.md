# 🏗️ Project Architecture

This document explains the architecture and design decisions of the Kubernetes Demo API project.

---

## 📐 Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                        User / Browser                        │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       │ HTTP Request
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                    Minikube Cluster                         │
│  ┌───────────────────────────────────────────────────────┐ │
│  │              Kubernetes Service                        │ │
│  │         (kubernetes-demo-api-service)                  │ │
│  │              Type: NodePort                            │ │
│  │            Port: 3000 → NodePort                       │ │
│  └───────┬─────────────────────────┬─────────────────────┘ │
│          │                         │                        │
│          │ Load Balance            │ Load Balance           │
│          ▼                         ▼                        │
│  ┌──────────────┐          ┌──────────────┐               │
│  │   Pod #1     │          │   Pod #2     │               │
│  │ ┌──────────┐ │          │ ┌──────────┐ │               │
│  │ │Container │ │          │ │Container │ │               │
│  │ │  Node.js │ │          │ │  Node.js │ │               │
│  │ │ Express  │ │          │ │ Express  │ │               │
│  │ │   API    │ │          │ │   API    │ │               │
│  │ │Port: 3000│ │          │ │Port: 3000│ │               │
│  │ └──────────┘ │          │ └──────────┘ │               │
│  └──────────────┘          └──────────────┘               │
└─────────────────────────────────────────────────────────────┘
```

---

## 🧩 Components Explained

### 1. 🎯 Express.js Application (`index.js`)

**Purpose**: Simple REST API that responds with pod information

**Key Features**:
- **Main Endpoint** (`/`): Returns JSON with service info and pod name
- **Health Check** (`/healthz`): Liveness probe for Kubernetes
- **Readiness Check** (`/readyz`): Readiness probe for Kubernetes

**Why Express.js?**
- Lightweight and fast
- Easy to understand for beginners
- Industry-standard for Node.js APIs
- Perfect for microservices

---

### 2. 🐳 Docker Container (`Dockerfile`)

**Purpose**: Package the application in a portable, isolated environment

**Build Strategy**: Multi-stage build
```
Base Image (node:18-alpine)
    ↓
Copy package files
    ↓
Install dependencies (production only)
    ↓
Copy application code
    ↓
Switch to non-root user (security)
    ↓
Define startup command
```

**Why Alpine Linux?**
- ✅ Minimal size (~40MB base image vs ~900MB for full Node)
- ✅ Faster builds and deployments
- ✅ Smaller attack surface (security)
- ✅ Less bandwidth usage

**Why Non-root User?**
- 🔐 Security best practice
- 🔐 Prevents privilege escalation
- 🔐 Complies with enterprise security policies

---

### 3. ☸️ Kubernetes Deployment (`k8s/deployment.yaml`)

**Purpose**: Manage pod lifecycle and ensure desired state

**Configuration**:
```yaml
Replicas: 2
    ↓
Ensures 2 pods are always running
    ↓
If one fails, Kubernetes restarts it
    ↓
Enables zero-downtime updates
```

**Why 2 Replicas?**
- 🔄 High availability
- 🔄 Load distribution
- 🔄 Fault tolerance
- 🔄 Demonstrates Kubernetes scaling

**Environment Variables**:
- `NODE_ENV=production` → Optimizes Node.js performance
- `POD_NAME` → Allows identifying which pod served the request

---

### 4. 🌐 Kubernetes Service (`k8s/service.yaml`)

**Purpose**: Expose pods to network traffic with load balancing

**How it Works**:
```
External Request → NodePort → Service → Load Balancer → Pod
```

**Service Types Explained**:

| Type | Use Case | Accessibility |
|------|----------|---------------|
| **ClusterIP** | Internal only | Within cluster |
| **NodePort** | Development/Testing | External via node IP |
| **LoadBalancer** | Production (Cloud) | External with LB IP |

**Why NodePort?**
- ✅ Works with Minikube out of the box
- ✅ No cloud provider needed
- ✅ Easy to test locally
- ⚠️ Change to LoadBalancer for cloud deployments

---

## 🔄 Request Flow

### Typical API Request Flow

```
1. User opens browser → http://<minikube-ip>:<node-port>
                ↓
2. Request hits Minikube node
                ↓
3. NodePort forwards to Service (port 3000)
                ↓
4. Service load balances between Pod #1 and Pod #2
                ↓
5. Selected pod's container processes request
                ↓
6. Express app in container generates response
                ↓
7. Response includes pod name (e.g., "pod-676bff7d88-k57jz")
                ↓
8. Response returns through Service → NodePort → User
```

---

## 🔐 Security Considerations

### Implemented Security Measures

| Security Feature | Implementation | Benefit |
|------------------|----------------|---------|
| **Non-root User** | `USER node` in Dockerfile | Prevents privilege escalation |
| **Minimal Image** | Alpine Linux | Reduces attack surface |
| **Production Deps** | `npm ci --omit=dev` | No unnecessary packages |
| **Explicit Ports** | Only port 3000 exposed | Limits network exposure |
| **Health Checks** | `/healthz` & `/readyz` | Detects compromised pods |

### Additional Recommendations for Production

- 🔒 Add HTTPS/TLS termination
- 🔒 Implement network policies
- 🔒 Use secrets for sensitive data
- 🔒 Add resource limits (CPU/Memory)
- 🔒 Enable pod security policies
- 🔒 Use image scanning tools

---

## 📊 Scaling Strategy

### Horizontal Scaling

```bash
# Scale up to 5 replicas
kubectl scale deployment kubernetes-demo-api --replicas=5

# Scale down to 1 replica
kubectl scale deployment kubernetes-demo-api --replicas=1
```

**When to Scale?**
- 📈 High traffic volumes
- 📈 Resource constraints on existing pods
- 📈 Need for higher availability

### Auto-scaling (Future Enhancement)

```yaml
# Horizontal Pod Autoscaler (HPA)
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
spec:
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70
```

---

## 🎯 Design Decisions

### Why This Stack?

| Technology | Reason |
|------------|--------|
| **Node.js** | Easy to learn, widely used, great for APIs |
| **Express** | Minimal, unopinionated, industry standard |
| **Docker** | Standard containerization, works everywhere |
| **Kubernetes** | Industry-leading orchestration, highly demanded skill |
| **Minikube** | Free local Kubernetes, perfect for learning |

### Why This Structure?

- ✅ **Separation of Concerns**: App code, Docker config, and K8s manifests are separate
- ✅ **Reusability**: Can easily swap Node.js with Python/Java
- ✅ **Best Practices**: Follows 12-factor app principles
- ✅ **Learning-Focused**: Simple enough to understand, complex enough to be useful

---

## 🔮 Future Enhancements

### Potential Improvements

- [ ] Add ConfigMaps for configuration
- [ ] Add Secrets for sensitive data
- [ ] Implement Ingress for better routing
- [ ] Add Horizontal Pod Autoscaler
- [ ] Implement resource requests/limits
- [ ] Add persistent storage with PVC
- [ ] Set up monitoring with Prometheus
- [ ] Add distributed tracing
- [ ] Implement CI/CD pipeline
- [ ] Add integration tests

---

## 📚 Related Documentation

- [README.md](README.md) - Getting started guide
- [COMMANDS.md](COMMANDS.md) - Quick reference
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- [VERIFICATION.md](VERIFICATION.md) - Test results

---

<div align="center">

**Understanding the architecture is the first step to mastering Kubernetes!** 🚀

</div>

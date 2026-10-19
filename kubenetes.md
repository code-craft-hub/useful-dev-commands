If you're running **Kubernetes locally with Docker Desktop** (for example, Docker Desktop Kubernetes), don't use `docker stop` to stop Kubernetes workloads. Kubernetes will usually recreate the containers.

Use `kubectl`.

### Stop/delete all Kubernetes workloads

For the current namespace:

```bash
kubectl delete pods --all
```

For **all namespaces**:

```bash
kubectl delete pods --all --all-namespaces
```

However, if you have Deployments, Kubernetes will immediately create new Pods.

### Actually stop an application

Scale its Deployment to zero:

```bash
kubectl scale deployment <deployment-name> --replicas=0
```

Example:

```bash
kubectl scale deployment my-api --replicas=0
```

All Deployments in the current namespace:

```bash
kubectl scale deployment --all --replicas=0
```

---

### Stop EVERYTHING in a namespace

You can remove the workloads:

```bash
kubectl delete deployment --all
kubectl delete statefulset --all
kubectl delete daemonset --all
kubectl delete job --all
kubectl delete cronjob --all
kubectl delete pods --all
```

Or simply delete the entire namespace:

```bash
kubectl delete namespace <namespace>
```

For example:

```bash
kubectl delete namespace my-app
```

---

### If you mean stop Kubernetes itself in Docker Desktop

If your goal is **"I want Kubernetes completely stopped because Docker is consuming CPU/RAM"**, don't delete the Pods.

In **Docker Desktop → Settings → Kubernetes**, disable Kubernetes.

Or, depending on your Docker Desktop version, you can use:

```bash
docker desktop stop
```

That stops **Docker Desktop itself**, not just Kubernetes.

### See what's currently running

```bash
kubectl get pods -A
```

```bash
kubectl get deployments -A
```

```bash
docker ps
```

Important distinction:

```text
kubectl delete pod
        ↓
Kubernetes controller
        ↓
creates a replacement pod
```

Whereas:

```text
kubectl scale deployment my-api --replicas=0
        ↓
Deployment has zero desired replicas
        ↓
Pods stay stopped
```


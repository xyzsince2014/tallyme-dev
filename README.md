# infra-dev

<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/xyzsince2014/infra-dev">
<img alt="GitHub tag (latest by date)" src="https://img.shields.io/github/v/tag/xyzsince2014/infra-dev">

Dev environment for
- https://idp.tallyme.xyz (accessible by https://tallyme-idp.localhost)
- https://resource.tallyme.xyz (accessible by https://tallyme-resource.localhost)
- https://www.tokyomap.live (accessible by http://localhost:3000)

## Prerequisites

- [Minikube](https://minikube.sigs.k8s.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Docker

## Make commands

| Command | Description |
|---------|-------------|
| `make up` | Full setup: start Minikube, build images, and deploy all resources |
| `make setup` | Start Minikube with the Docker driver, enable the Ingress addon, and open a `minikube tunnel` window |
| `make build` | Build the Postgres Docker image inside the Minikube environment |
| `make deploy` | Apply all Kubernetes manifests (Postgres, Redis, IdP, Resource) |
| `make stop` | Stop the Minikube cluster |
| `make delete` | Delete the Minikube cluster |
| `make psql` | Open a psql session against the in-cluster Postgres |

## Quick start

```bash
# Bring up the entire dev environment
make up

# Stop the cluster (keeps all data/config)
make stop

# Destroy the cluster entirely
make delete
```

## Related repositories

- https://github.com/xyzsince2014/tallyme-idp
- https://github.com/xyzsince2014/tallyme-resource
- https://github.com/xyzsince2014/tokyomap-app

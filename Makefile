.PHONY: colima hosts psql setup apply stop destroy deploy

# ----------------------------
# 🚀 Setup
# ----------------------------
colima:
	@echo "🐳 Starting Colima..."
	./scripts/setup/colima-start.sh

hosts:
	@echo "🌐 Configuring local DNS..."
	./scripts/setup/hosts.sh

# ----------------------------
# 🐘 Postgres
# ----------------------------
psql:
	./scripts/postgres/psql.sh

# ----------------------------
# 📦 Application Deployment
# ----------------------------
deploy:
	./scripts/postgres/create-configmap.sh
	kubectl apply -f ./manifests/

# ----------------------------
# ☁️ Minikube
# ----------------------------
setup:
	@echo "🚀  Starting Minikube..."
	minikube start --driver=docker --cpus=4 --memory=3072
	minikube addons enable ingress

	@echo "⌛  Starting Minikube Tunnel in a new window..."
	@-pkill -f "minikube tunnel" || true
	osascript -e 'tell app "Terminal" to do script "minikube tunnel"'

	@echo "⌛  Waiting for Docker daemon to be ready..."
	@until minikube docker-env > /dev/null 2>&1; do \
		echo "Still waiting for Docker..."; \
		sleep 2; \
	done

	@echo "⌛  Waiting for Ingress Controller to be ready..."
	@sleep 10
	@kubectl wait --namespace ingress-nginx \
	  --for=condition=ready pod \
	  --selector=app.kubernetes.io/component=controller \
	  --timeout=120s

	@echo "🌟  Infrastructure is ready!"

apply: setup deploy
	@echo "✅  Done."

stop:
	@echo "⌛ Stopping Minikube cluster..."
	minikube stop
	@echo "✅  Minikube stopped."

destroy:
	@echo "⚠️  WARNING: Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]
	minikube delete
	@echo "✅  Deleted."

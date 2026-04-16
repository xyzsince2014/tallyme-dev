# ============================================================================
# .PHONY: Declare targets not associated with files
# ============================================================================
.PHONY: setup build deploy up stop delete psql

# ****** Infrastructure Setup ******
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
	@kubectl wait --namespace ingress-nginx \
	  --for=condition=ready pod \
	  --selector=app.kubernetes.io/component=controller \
	  --timeout=90s >/dev/null 2>&1 || true

	@echo "🌟  Infrastructure is ready!"

# ****** Build & Deploy ******
# Execute Docker build inside the Minikube environment
build:
	./postgres/docker-build.sh

# Provision k8s resources
deploy:
	./postgres/create-configmap.sh
	kubectl apply -f ./postgres/
	kubectl apply -f ./redis/
	kubectl apply -f ./idp/
	kubectl apply -f ./resource/

# ****** Orchestrate ******
up: setup build deploy
	@echo "✅  Done."

# ****** Clean Up ******
stop:
	@echo "⌛ Stopping Minikube cluster..."
	minikube stop
	@echo "✅  Minikube stopped."

delete:
	@echo "⚠️  WARNING: Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]
	minikube delete
	@echo "✅  Deleted."

# ****** Misc ******
# Quick access to the DB
psql:
	./postgres/psql.sh

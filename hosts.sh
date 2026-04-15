#!/bin/bash

# ============================================================================
# Local Domain Resolution Setup
# ============================================================================
# Ensures that local microservice domains point to the loopback IP.
# * tallyme-idp.localhost
# * tallyme-resource.localhost
# * tokyomap.localhost: Frontend & BFF
# ============================================================================

HOSTS_FILE="/etc/hosts"

# tallyme-idp.localhost -> 127.0.0.1 -> minikube tunnel -> Ingress Controller
# tallyme-resource.localhost -> 127.0.0.1 -> minikube tunnel -> Ingress Controller
# tokyomap.localhost -> 127.0.0.1 -> localhost:3000
DOMAIN_LINE="127.0.0.1 tallyme-idp.localhost tallyme-resource.localhost tokyomap.localhost"

if grep -q "tallyme-idp.localhost" "$HOSTS_FILE"; then
    echo "Hosts entry already exists. Skipping..."
else
    echo "Appending entries to $HOSTS_FILE..."
    echo "$DOMAIN_LINE" | sudo tee -a "$HOSTS_FILE" > /dev/null
fi

cat -n "$HOSTS_FILE"

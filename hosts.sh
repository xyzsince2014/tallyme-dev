#!/bin/bash

# ============================================================================
# Local Domain Resolution Setup
# ============================================================================
# This script ensures that local microservice domains point to the loopback IP.
# - as.localhost: AS
# - rs.localhost: RS
# - tokyomap.localhost: Frontend & BFF
# ============================================================================

HOSTS_FILE="/etc/hosts"

# as.localhost -> 127.0.0.1 -> minikube tunnel -> Ingress Controller
# rs.localhost -> 127.0.0.1 -> minikube tunnel -> Ingress Controller
# tokyomap.localhost -> 127.0.0.1 -> localhost:3000
DOMAIN_LINE="127.0.0.1 as.localhost rs.localhost tokyomap.localhost"

if grep -q "as.localhost" "$HOSTS_FILE"; then
    echo "Hosts entry already exists. Skipping..."
else
    echo "Appending entries to $HOSTS_FILE..."
    echo "$DOMAIN_LINE" | sudo tee -a "$HOSTS_FILE" > /dev/null
fi

cat -n "$HOSTS_FILE"

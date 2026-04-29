#!/bin/bash

# ============================================================================
# PostgreSQL Access Script
# ============================================================================
# Usage: ./psql.sh
# Automatically finds the active Postgres Pod and connects via psql.
# ============================================================================

DB_DATABASE="tallyme"
DB_USER="postgres"

# fetch the pod's name with label 'app=postgres'
POD_NAME=$(kubectl get pods -l app=postgres -o jsonpath='{.items[0].metadata.name}')

if [ -z "$POD_NAME" ]; then
    echo "Postgres Pod Not Found."
    exit 1
fi

echo "Connecting to Pod: $POD_NAME as '$DB_USER'..."
kubectl exec -it "$POD_NAME" -- psql -U "$DB_USER" -d "$DB_DATABASE"

#!/bin/bash

# ============================================================================
# Database Provisioning
# ============================================================================
# Bootstraps the persistence layer for the AS.
# - Creates a K8s ConfigMap containing SQL initialization scripts.
# - These scripts are automatically executed during the PostgreSQL container's initialization phase via the /docker-entrypoint-initdb.d volume.
# ============================================================================

# $0 means where the script lives
# dirname <path> return the directory of <path>
# $(<cmd>) return the stdout of <cmd>
cd "$(dirname "$0")"

# output the stdout of the dry-run as a yaml, which is given to `kubectl apply -f`
kubectl create configmap postgres-init-sql \
  --from-file=initdb.d/01.create_t_usr.sql \
  --from-file=initdb.d/02.create_t_refresh_token.sql \
  --from-file=initdb.d/03.create_t_access_token.sql \
  --from-file=initdb.d/04.create_t_client.sql \
  --from-file=initdb.d/05.create_t_resource.sql \
  --from-file=initdb.d/06.create_t_rsa_public_key.sql \
  --from-file=initdb.d/07.insert_t_resource.sql \
  --from-file=initdb.d/99.create_postgres_users.sql \
  --dry-run=client -o yaml | kubectl apply -f -

#!/bin/bash

# ============================================================================
# Generates self-signed SSL certificates for HTTPS in local environment
# ============================================================================

# Exit on any error
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CERT_DIR="${SCRIPT_DIR}"

echo "==> Generating self-signed SSL certificates for localhost..."
echo "==> Certificate directory: ${CERT_DIR}"

# Generate private key and certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "${CERT_DIR}/privkey.pem" \
  -out "${CERT_DIR}/cert.pem" \
  -subj "/C=JP/ST=Tokyo/L=Tokyo/O=Tokyomap/OU=Development/CN=localhost"

# Copy cert as fullchain for self-signed, they're the same.
cp "${CERT_DIR}/cert.pem" "${CERT_DIR}/fullchain.pem"

echo ""
echo "==> ✅ Certificates generated successfully!"
echo ""
echo "Generated files:"
echo "  - privkey.pem    (private key)"
echo "  - cert.pem       (certificate)"
echo "  - fullchain.pem  (full chain - same as cert for self-signed)"
echo ""
echo "⚠️  These are self-signed certificates for LOCAL DEVELOPMENT ONLY"
echo "    Your browser will show a security warning - this is expected."
echo ""
echo "To trust the certificate on macOS:"
echo "  sudo security add-trusted-cert -d -r trustRoot \\"
echo "    -k /Library/Keychains/System.keychain ${CERT_DIR}/cert.pem"
echo ""

# Generate certificate with manual DNS challenge
# Certbot is doing this:
# Contacts Let's Encrypt - Asks for a certificate for tokyomap.live
# Gets a challenge - Let's Encrypt says "prove you own this domain by adding this TXT record"
# Pauses and waits - Certbot stops and asks YOU to add the TXT record to DNS
# You add the record - (We already did this with AWS Route53)
# You press Enter - Tells certbot "okay, I've added it, check now"
# Let's Encrypt verifies - Checks if _acme-challenge.tokyomap.live has the correct TXT value
# Issues certificate - If verified, gives you the SSL certificate files
# Saves to disk - Stores them in /etc/letsencrypt/live/tokyomap.live/
sudo certbot certonly \
  --manual \
  --preferred-challenges dns \
  -d dev.tokyomap.live \
  --email xyzsince2014@gmail.com \
  --agree-tos

# Update the TXT record with the NEW value
cat > /tmp/txt-record.json <<EOF
{
  "Changes": [{
    "Action": "UPSERT",
    "ResourceRecordSet": {
      "Name": "_acme-challenge.tokyomap.live",
      "Type": "TXT",
      "TTL": 60,
      "ResourceRecords": [{"Value": "\"5wFRFZrL9s-re5nK-nhhQFD8bxeOu6qXS_sSy7_OxGY\""}]
    }
  }]
}
EOF

# Apply the change
aws route53 change-resource-record-sets \
  --hosted-zone-id Z02765923I319MWQH7F4Y \
  --change-batch file:///tmp/txt-record.json

# Check the TXT record (note the _acme-challenge prefix)
dig TXT _acme-challenge.tokyomap.live +short

# Upload directly with sudo (no need to cd)
sudo aws s3 cp /etc/letsencrypt/live/tokyomap.live/cert.pem s3://tokyomap-web/certs/cert.pem
sudo aws s3 cp /etc/letsencrypt/live/tokyomap.live/fullchain.pem s3://tokyomap-web/certs/fullchain.pem
sudo aws s3 cp /etc/letsencrypt/live/tokyomap.live/privkey.pem s3://tokyomap-web/certs/privkey.pem

# Verify upload
aws s3 ls s3://tokyomap-web/certs/

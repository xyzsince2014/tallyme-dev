FROM nginx:1.23.1

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy SSL certificates
COPY certs/cert.pem /etc/ssl/certs/cert.pem
COPY certs/fullchain.pem /etc/ssl/certs/fullchain.pem
COPY certs/privkey.pem /etc/ssl/certs/privkey.pem

# Set proper permissions
RUN chmod 644 /etc/ssl/certs/cert.pem && \
    chmod 644 /etc/ssl/certs/fullchain.pem && \
    chmod 600 /etc/ssl/certs/privkey.pem

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

FROM alpine:latest

# Install nginx
RUN apk add --no-cache nginx

# Create required directories
RUN mkdir -p /usr/share/nginx/html /run/nginx

# Copy your index.html
COPY index.html /usr/share/nginx/html/index.html

# Overwrite the main nginx.conf with our own
RUN echo 'events {} \
http { \
    server { \
        listen 80; \
        server_name localhost; \
        root /usr/share/nginx/html; \
        index index.html; \
        location / { \
            try_files $uri $uri/ =404; \
        } \
    } \
}' > /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Run nginx in foreground
CMD ["nginx", "-g", "daemon off;"]


FROM nginx:alpine

# Copy static website files
COPY . /usr/share/nginx/html/

# Configure nginx with basic optimization and logging to stdout/stderr
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html index.htm; \
    \
    # Enable access logging to stdout \
    access_log /dev/stdout; \
    error_log /dev/stderr; \
    \
    # Enable gzip compression \
    gzip on; \
    gzip_vary on; \
    gzip_types text/plain text/css application/json application/javascript; \
    \
    # Basic cache settings \
    location ~* \\.(?:css|js|jpg|jpeg|gif|png|ico|svg)$ { \
        expires 7d; \
        add_header Cache-Control "public"; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Forward nginx logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

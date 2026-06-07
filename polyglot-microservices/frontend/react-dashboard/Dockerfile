# Use official nginx base image
FROM nginx:alpine

# Copy your custom nginx.conf (with pid + temp paths redirected to /tmp)
COPY nginx.conf /etc/nginx/nginx.conf

# Copy your application static files (adjust path as needed)
COPY ./dist /usr/share/nginx/html

# Ensure /tmp directories exist and are owned by nginx user
RUN mkdir -p /tmp/client_temp /tmp/proxy_temp /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp \
    && chown -R nginx:nginx /tmp

# Switch to non-root user (nginx is defined in the base image)
USER nginx

# Expose port 80
EXPOSE 80

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

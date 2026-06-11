# Stage 1: Build React app with Node
FROM node:18-alpine AS build
WORKDIR /app

# Copy package files and install ALL dependencies (including devDependencies)
COPY package*.json ./
RUN npm install

# Copy the rest of the source code (including vite.config.js, etc.)
COPY . .

# Run the Vite build
RUN npm run build

# Stage 2: Serve with nginx
FROM nginx:alpine

# Copy your custom nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Copy built React app from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Ensure /tmp directories exist and are owned by nginx user
RUN mkdir -p /tmp/client_temp /tmp/proxy_temp /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp \
    && chown -R nginx:nginx /tmp

# Switch to non-root user
USER nginx

# Expose port 80
EXPOSE 80

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

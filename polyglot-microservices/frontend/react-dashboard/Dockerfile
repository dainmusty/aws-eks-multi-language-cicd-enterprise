# ==========================================================

# BUILD STAGE

# ==========================================================

FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

# ==========================================================

# RUNTIME STAGE

# ==========================================================

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

RUN mkdir -p /var/cache/nginx \
    && mkdir -p /var/run \
    && chown -R nginx:nginx /var/cache/nginx \
    && chown -R nginx:nginx /var/run \
    && chown -R nginx:nginx /usr/share/nginx/html

USER nginx

EXPOSE 80

CMD ["nginx","-g","daemon off;"]

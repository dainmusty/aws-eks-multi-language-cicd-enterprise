############################################################
# STAGE 1 — DEPENDENCY INSTALLATION
############################################################
FROM node:22-alpine AS builder

# Security updates and dumb-init for proper signal handling
RUN apk update && apk upgrade && \
    apk add --no-cache dumb-init

# Set working directory
WORKDIR /app

# Copy package files first (for better caching)
COPY package*.json ./

# Install only production dependencies
RUN npm ci --omit=dev

# Copy application source
COPY src ./src

############################################################
# STAGE 2 — PRODUCTION IMAGE
############################################################
FROM node:22-alpine

# Security updates and dumb-init
RUN apk update && apk upgrade && \
    apk add --no-cache dumb-init

# Set environment to production
ENV NODE_ENV=production

# Set working directory
WORKDIR /app

# Copy required files from builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
COPY --from=builder /app/package.json ./package.json

# Drop root privileges
USER node

# Expose application port
EXPOSE 3000

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Entrypoint with dumb-init
ENTRYPOINT ["dumb-init", "--"]

# Start application
CMD ["node", "src/index.js"]

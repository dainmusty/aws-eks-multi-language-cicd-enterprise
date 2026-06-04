# JavaScript API Microservice

A Node.js/Express microservice providing RESTful API endpoints.

## Features

- Express.js web framework
- RESTful API design
- Containerized deployment
- Health check endpoint
- Modular architecture (routes, controllers)

## Getting Started

### Prerequisites

- Node.js 18+
- Docker (optional)

### Installation

```bash
npm install
```

### Development

```bash
npm run dev
```

### Testing

```bash
npm test
```

### Docker Build

```bash
docker build -t javascript-api:1.0.0 .
docker run -p 3000:3000 javascript-api:1.0.0
```

## API Endpoints

- `GET /health` - Health check
- `GET /api/items` - Get all items
- `POST /api/items` - Create item
- `GET /api/items/:id` - Get item by ID
- `PUT /api/items/:id` - Update item
- `DELETE /api/items/:id` - Delete item

## Environment Variables

- `PORT` - Server port (default: 3000)




JavaScript/Node.js Best Practices
Optimized Dockerfile:
# Multi-stage build for Node.js
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files first (layer caching)
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Production image
FROM node:20-alpine

WORKDIR /app

# Copy only production dependencies and code
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY package.json ./

# Security: non-root user
USER node

EXPOSE 3000

CMD ["node", "dist/index.js"]

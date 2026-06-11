# Java Microservice

A Spring Boot microservice providing RESTful API endpoints.

## Features

- Spring Boot 3.0 framework
- Spring Web MVC
- RESTful API design
- Actuator endpoints
- JUnit testing
- Multi-stage Docker build
- Health check endpoint

## Getting Started

### Prerequisites

- Java 17+
- Maven 3.8+
- Docker (optional)

### Build

```bash
mvn clean package
```

### Run

```bash
mvn spring-boot:run
```

### Testing

```bash
mvn test
```

### Docker Build

```bash
docker build -t dainmusty/java-service:staging-latest .
docker push dainmusty/java-service:dev-latest
docker run -p 8080:8080 java-service:1.0.0
```

## API Endpoints

- `GET /api/health` - Health check
- `GET /api/items` - Get all items
- `POST /api/items` - Create item
- `GET /api/items/{id}` - Get item by ID
- `PUT /api/items/{id}` - Update item
- `DELETE /api/items/{id}` - Delete item

## Actuator Endpoints

- `GET /actuator` - All actuator endpoints
- `GET /actuator/health` - Application health
- `GET /actuator/metrics` - Application metrics


Java/Spring Boot Best Practices
Optimized Dockerfile:
# Multi-stage build for Java
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy pom.xml first (dependency caching)
COPY pom.xml .

# Download dependencies (cached layer)
RUN mvn dependency:go-offline

# Copy source and build
COPY src ./src
RUN mvn package -DskipTests

# Production image
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy only the JAR
COPY --from=builder /app/target/*.jar app.jar

# Security
USER nobody

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

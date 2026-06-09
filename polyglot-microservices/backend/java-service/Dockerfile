############################################################
# STAGE 1 — BUILD APPLICATION
#
# Uses Maven to compile and package the application.
############################################################

FROM maven:3.9-eclipse-temurin-17 AS builder

############################################################
# WORKING DIRECTORY
############################################################

WORKDIR /app

############################################################
# COPY MAVEN FILE FIRST
#
# Improves layer caching.
# Dependencies are only re-downloaded when pom.xml changes.
############################################################

COPY pom.xml .

############################################################
# DOWNLOAD DEPENDENCIES
############################################################

RUN mvn dependency:go-offline

############################################################
# COPY SOURCE CODE
############################################################

COPY src ./src

############################################################
# BUILD APPLICATION
#
# Skip tests because CI pipeline already executes them.
############################################################

RUN mvn clean package -DskipTests

############################################################
# STAGE 2 — PRODUCTION IMAGE
#
# Small JRE image only.
# No Maven tooling included.
############################################################

FROM eclipse-temurin:17-jre-alpine

############################################################
# OCI IMAGE METADATA
############################################################

LABEL maintainer="Platform Engineering Team"
LABEL application="java-service"
LABEL runtime="spring-boot"

############################################################
# WORKING DIRECTORY
############################################################

WORKDIR /app

############################################################
# JVM OPTIONS
#
# Container-aware JVM settings.
############################################################

ENV JAVA_OPTS="-XX:+UseContainerSupport \
-XX:MaxRAMPercentage=75.0 \
-XX:+ExitOnOutOfMemoryError"

############################################################
# COPY APPLICATION JAR
############################################################

COPY --from=builder /app/target/*.jar app.jar

############################################################
# SECURITY HARDENING
#
# Run as non-root user.
############################################################

USER nobody

############################################################
# APPLICATION PORT
############################################################

EXPOSE 8080

############################################################
# HEALTH CHECK
#
# Spring Boot actuator endpoint.
############################################################

HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=20s \
            --retries=3 \
  CMD wget --quiet --tries=1 --spider \
  http://localhost:8080/actuator/health || exit 1

############################################################
# APPLICATION STARTUP
#
# exec form ensures proper signal handling
# during Kubernetes pod termination.
############################################################

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
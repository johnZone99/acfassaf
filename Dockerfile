# Stage 1: Build the application
FROM maven:3.8.3-openjdk-17 AS build

# Set the working directory
WORKDIR /app

# Copy the POM file
COPY pom.xml .

# Copy the entire project (excluding the target directory to reduce image size)
COPY src ./src

# Build the Maven project
RUN mvn clean package

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim

# Expose port 8080
EXPOSE 8080

# Copy the JAR file from the build stage
COPY --from=build /app/target/demo-1.jar /app.jar

# Set the entry point for the container
ENTRYPOINT ["java", "-jar", "app.jar"]

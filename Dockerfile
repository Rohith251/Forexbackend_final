 
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
COPY target/Backend.jar /app/Backend.jar
EXPOSE 8085
ENTRYPOINT ["java", "-jar", "Backend.jar"]


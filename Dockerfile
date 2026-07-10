
FROM eclipse-temurin:21-jre

WORKDIR /usr/app

COPY target/springbootapi.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]

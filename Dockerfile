FROM openjdk:8-jdk-alpine

# Set necessary environment variables needed for our running image
ENV OAUTH2_AUTH_DATASOURCE_URL='jdbc:mysql://valid_mysql:3306/valid-security?useSSL=false' \
    OAUTH2_AUTH_DATASOURCE_USERNAME='root' \
    OAUTH2_AUTH_DATASOURCE_PASSWORD='v4l1d-gu1d0-m4nt*' \
    OAUTH2_AUTH_ENVIRONMENT='dev'

VOLUME /tmp

ARG JAR_FILE=build/libs/valid_oauth2.jar

ADD ${JAR_FILE} app.jar

EXPOSE 8443

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

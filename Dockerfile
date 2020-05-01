FROM openjdk:8-jdk-alpine

# Set necessary environment variables needed for our running image
ENV VALID_OAUTH2_DATASOURCE_URL='jdbc:mysql://valid_mysql:3306/valid-security?useSSL=false&allowPublicKeyRetrieval=true' \
    VALID_OAUTH2_DATASOURCE_USERNAME='root' \
    VALID_OAUTH2_DATASOURCE_PASSWORD='v4l1d-gu1d0-m4nt*' \
    VALID_OAUTH2_ENVIRONMENT='dev'

VOLUME /tmp

ARG JAR_FILE=build/libs/valid_oauth2.jar

ADD ${JAR_FILE} app.jar

EXPOSE 8443

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

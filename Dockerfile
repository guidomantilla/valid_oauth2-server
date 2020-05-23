FROM gradle:6.4.1-jdk8 AS builder

ENV APP_HOME='/app/' \
    VALID_APP_NAME='valid-oauth2'

WORKDIR $APP_HOME
COPY . .
RUN gradle build -x test --continue && \
    mv build/libs/$(ls build/libs) build/libs/${VALID_APP_NAME}.jar


FROM openjdk:8-jre-alpine

# Set necessary environment variables needed for running image
ENV APP_HOME='/app/' \
    VALID_APP_NAME='valid-oauth2' \
    VALID_MYSQL_HOSTNAME='valid-mysql' \
    VALID_MYSQL_PORT='3306' \
    VALID_OAUTH2_DATASOURCE_URL='jdbc:mysql://${VALID_MYSQL_HOSTNAME}:${VALID_MYSQL_PORT}/valid-security?useSSL=false&allowPublicKeyRetrieval=true' \
    VALID_OAUTH2_DATASOURCE_USERNAME='root' \
    VALID_OAUTH2_DATASOURCE_PASSWORD='v4l1d-gu1d0-m4nt*' \
    VALID_OAUTH2_ENVIRONMENT='dev'

WORKDIR $APP_HOME
COPY --from=builder ${APP_HOME}/build/libs/ $APP_HOME/
RUN mv ${VALID_APP_NAME}.jar valid-oauth2.jar && apk --no-cache add curl

VOLUME /tmp
EXPOSE 8443

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/valid-oauth2.jar"]

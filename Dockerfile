FROM gradle:6.4.1-jdk8 AS builder

ENV APP_HOME='/root/dev/app/' \
    VALID_APP_NAME='valid-oauth2'

WORKDIR $APP_HOME
COPY . .
RUN gradle build -x test --continue && \
    echo $(ls build/libs) \
    mv build/libs/$(ls build/libs) build/libs/${VALID_APP_NAME}.jar


FROM openjdk:8-jre-alpine

ENV APP_HOME='/root/dev/app/' \
    VALID_APP_NAME='valid-oauth2'

COPY --from=builder ${APP_HOME}/build/libs/${VALID_APP_NAME}.jar .

# Set necessary environment variables needed for running image
ENV VALID_MYSQL_HOSTNAME='valid-mysql' \
    VALID_MYSQL_PORT='3306' \
    VALID_OAUTH2_DATASOURCE_URL='jdbc:mysql://${VALID_MYSQL_HOSTNAME}:${VALID_MYSQL_PORT}/valid-security?useSSL=false&allowPublicKeyRetrieval=true' \
    VALID_OAUTH2_DATASOURCE_USERNAME='root' \
    VALID_OAUTH2_DATASOURCE_PASSWORD='v4l1d-gu1d0-m4nt*' \
    VALID_OAUTH2_ENVIRONMENT='dev'

RUN apk --no-cache add curl

VOLUME /tmp

RUN mv ${VALID_APP_NAME}.jar valid-oauth2.jar

EXPOSE 8443

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/valid-oauth2.jar"]

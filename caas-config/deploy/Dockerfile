FROM bjdhub.haihangyun.com/chsun/spirit-java:8
MAINTAINER Michael Dante <ch.sun@hnair.com>

ENV APPS_HOME=/AppServer
RUN mkdir -p $APPS_HOME/
WORKDIR $APPS_HOME/
ADD http://maven.haihangyun.com/content/repositories/Spirit-Central/com/haihangyun/caas/caas-config/1.0/caas-config-1.0.jar $APPS_HOME/app.jar

RUN sh -c 'touch $APPS_HOME/app.jar'

ENV JAVA_OPTS="-Xms1024m -Xmx1024m"

EXPOSE 8888
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar $APPS_HOME/app.jar" ]
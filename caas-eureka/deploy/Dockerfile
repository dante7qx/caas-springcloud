FROM java:8
LABEL AUTHOR="Michael Dante <ch.sun@hnair.com>"

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV APPS_HOME=/AppServer
RUN mkdir -p $APPS_HOME/
WORKDIR $APPS_HOME/
ADD https://raw.githubusercontent.com/dante7qx/mvnrepo/master/caas-eureka-1.0.jar $APPS_HOME/app.jar

RUN sh -c 'touch $APPS_HOME/app.jar'

ENV JAVA_OPTS="-Xms1024m -Xmx1024m"

EXPOSE 8761
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar $APPS_HOME/app.jar" ]
FROM openjdk:17-alpine
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
COPY . /app
RUN ./mvnw clean package
ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.16/bin/apache-tomcat-10.1.16.tar.gz /opt
WORKDIR /opt
RUN tar -xvzf apache-tomcat-10.1.16.tar.gz \
    && ln -s /opt/apache-tomcat-10.1.16 $CATALINA_HOME \
    && rm -rf apache-tomcat-10.1.16.tar.gz
WORKDIR /app
RUN ./mvnw clean package
RUN cp /app/target/petclinic.war /opt/apache-tomcat-10.1.16/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
FROM tomcat:8.5
COPY ./webapp.war /usr/local/tomcat/webapps/
EXPOSE 8080


#This dockerfile generates the image with tomcat as server and .war file deployed in it
FROM tomcat:latest
RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/
COPY webapp/target/webapp.war /usr/local/tomcat/webapps/

FROM tomcat:9-jre8
MAINTAINER Masaaki Kawamura "yamame0111@gmail.com"

# Setting timezone.
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Download OpenGrok.
ADD https://github.com/OpenGrok/OpenGrok/releases/download/1.0/opengrok-1.0.tar.gz /opengrok.tar.gz
RUN tar zxvf /opengrok.tar.gz && mv opengrok-* /opengrok && chmod -R +x /opengrok/bin

# Installing dependencies.
RUN apt-get update && apt-get install -y exuberant-ctags git subversion mercurial unzip inotify-tools

# Environment variables.
ENV DATA_ROOT /var/opengrok
ENV SRC_ROOT /var/opengrok/src
ENV OPENGROK_TOMCAT_BASE /usr/local/tomcat
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV PATH /opengrok/bin:$PATH
ENV CATALINA_BASE /usr/local/tomcat
ENV CATALINA_HOME /usr/local/tomcat
ENV CATALINA_TMPDIR /usr/local/tomcat/temp
ENV JRE_HOME /usr
ENV CLASSPATH /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar

WORKDIR $CATALINA_HOME
RUN /opengrok/bin/OpenGrok deploy

EXPOSE 8080

# Settings for Tomcat.
RUN mkdir -p /tomcat/conf
RUN rm /usr/local/tomcat/webapps/ROOT/index.jsp
ADD index.html /usr/local/tomcat/webapps/ROOT/index.html

ADD scripts /scripts
RUN chmod -R +x /scripts
CMD ["/scripts/start.sh"]

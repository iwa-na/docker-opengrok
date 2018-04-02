#!/bin/bash

catalina_setting() {
    # config setting
    if [ -z "$(ls /tomcat/conf/)" ]; then
        cp -rf /usr/local/tomcat/conf/* /tomcat/conf/
    fi
    rm -rf /usr/local/tomcat/conf
    ln -s /tomcat/conf /usr/local/tomcat/conf
}

# Settings for Tomcat.
catalina_setting

# Start service.
catalina.sh run


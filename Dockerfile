#######################################################################
#                                                                     #
# Creates a base CentOS image with JBoss Data Virtualization 6.0.0.GA #
#                                                                     #
#######################################################################

# Use the centos base image
FROM jboss/base-jdk:7

MAINTAINER kpeeples <kpeeples@redhat.com>

ENV WORKING_DIR /opt/jboss
ENV JBOSS_HOME /opt/jboss/dv/jboss-eap-6.1
ENV INSTALLER jboss-dv-installer-6.0.0.GA-redhat-4.jar

ADD software/$INSTALLER $WORKING_DIR/$INSTALLER
ADD support/InstallationScript.xml $WORKING_DIR/InstallationScript.xml
USER root
RUN chown -R jboss $WORKING_DIR/*
USER jboss
RUN java -jar $WORKING_DIR/$INSTALLER $WORKING_DIR/InstallationScript.xml
ADD support/teiid-security-users.properties $JBOSS_HOME/standalone/configuration/teiid-security-users.properties
ADD support/teiid-security-roles.properties $JBOSS_HOME/standalone/configuration/teiid-security-roles.properties
ADD support/standalone.dv.xml $JBOSS_HOME/standalone/configuration/standalone.xml
ADD support/data/Customer.txt $JBOSS_HOME/standalone/data/Customer.txt
ADD support/data/CustomerHistory.xml $JBOSS_HOME/standalone/data/CustomerHistory.xml
ADD support/vdb/CustomerContextVDB.vdb $JBOSS_HOME/standalone/deployments/CustomerContextVDB.vdb
ADD support/vdb/CustomerContextVDB.vdb.dodeploy $JBOSS_HOME/standalone/deployments/CustomerContextVDB.vdb.dodeploy
USER root
RUN chown -R jboss $WORKING_DIR/*
RUN chown -R jboss $JBOSS_HOME/*
# Clean up
RUN rm -f $WORKING_DIR/$INSTALLER
USER jboss

EXPOSE 8080 9990 31000

CMD $JBOSS_HOME/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0

#######################################################################
#                                                                     #
# Creates a base CentOS image with JBoss Data Virtualization 6.0.0.GA #
#                                                                     #
#######################################################################

# Use the centos base image
FROM centos

MAINTAINER kpeeples <kpeeples@redhat.com>

# enabling sudo group for jboss
RUN echo '%jboss ALL=(ALL) ALL' >> /etc/sudoers

# Create jboss user
RUN useradd -m -d /home/jboss -p jboss jboss

##########################################################
# Install Java JDK, SSH and other useful cmdline utilities
##########################################################
RUN yum -y install java-1.7.0-openjdk which sudo;yum clean all
ENV JAVA_HOME /usr/lib/jvm/jre

#############################################
# Install JBoss Data Virtualization 6.0.0.GA
############################################
USER jboss
ENV INSTALLDIR /home/jboss/dv
ENV HOME /home/jboss
RUN mkdir $INSTALLDIR && \
   mkdir $INSTALLDIR/software && \
   mkdir $INSTALLDIR/support && \
   mkdir $INSTALLDIR/support/data && \
   mkdir $INSTALLDIR/support/vdb
ADD software/jboss-dv-installer-6.0.0.GA-redhat-4.jar $INSTALLDIR/software/jboss-dv-installer-6.0.0.GA-redhat-4.jar 
ADD support/teiid-security-users.properties $INSTALLDIR/support/teiid-security-users.properties
ADD support/teiid-security-roles.properties $INSTALLDIR/support/teiid-security-roles.properties
ADD support/InstallationScript.xml $INSTALLDIR/support/InstallationScript.xml
ADD support/standalone.dv.xml $INSTALLDIR/support/standalone.dv.xml
ADD support/data/Customer.txt $INSTALLDIR/support/data/Customer.txt
ADD support/data/CustomerHistory.xml $INSTALLDIR/support/data/CustomerHistory.xml
ADD support/vdb/CustomerContextVDB.vdb $INSTALLDIR/support/vdb/CustomerContextVDB.vdb
ADD support/vdb/CustomerContextVDB.vdb.dodeploy $INSTALLDIR/support/vdb/CustomerContextVDB.vdb.dodeploy
RUN java -jar $INSTALLDIR/software/jboss-dv-installer-6.0.0.GA-redhat-4.jar $INSTALLDIR/support/InstallationScript.xml
RUN mv $INSTALLDIR/support/teiid* $INSTALLDIR/jboss-eap-6.1/standalone/configuration
RUN mv $INSTALLDIR/support/data/* $INSTALLDIR/jboss-eap-6.1/standalone/data
RUN mv $INSTALLDIR/support/vdb $INSTALLDIR/jboss-eap-6.1/standalone/deployments
RUN mv $INSTALLDIR/support/standalone.dv.xml $INSTALLDIR/jboss-eap-6.1/standalone/configuration/standalone.xml
RUN rm -rf $INSTALLDIR/jboss-eap-6.1/standalone/configuration/standalone_xml_history/current

# start.sh
#USER root
#RUN chown -R jboss:jboss $INSTALLDIR/jboss-eap-6.1/standalone/data
#RUN chown -R jboss:jboss $INSTALLDIR/jboss-eap-6.1/standalone/deployments
#RUN chown -R jboss:jboss $INSTALLDIR/jboss-eap-6.1/standalone/configuration/standalone.xml

# Clean up
RUN rm -rf $INSTALLDIR/support
RUN rm -rf $INSTALLDIR/software

EXPOSE 22 5432 8080 9990 27017 31000

CMD runuser -l jboss -c '$HOME/dv/jboss-eap-6.1/bin/standalone.sh -c standalone.xml -b 0.0.0.0 -bmanagement 0.0.0.0'

# Finished

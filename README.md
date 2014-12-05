 
## dv-odata-docker
This project builds a [docker](http://www.docker.io) container for running [JBoss Data Virtualization](http://http://www.redhat.com/products/jbossenterprisemiddleware/data-virtualization/) 6.0.0.GA with a OData Multisource Virtual Database.  

## Prerequisites
1. Install [Docker](https://www.docker.io/gettingstarted/#1)
2. Download JBoss Data Virtualization from [jboss.org.](http://jboss.org/products/#IBP)
2. Put the downloaded file: jboss-dv-installer-6.0.0.GA-redhat-4.jar into dv-odata-docker/software

## Steps to Run Demo

Management Credentials:  
admin/redhat1!  
Datavirtualization Credentials:  
user/user  
  
STEP 1: Clone the Repository and Download Data Virtualization  
-git clone of the repository  
-Put the Data Virutalization Download, jboss-dv-installer-6.0.0.GA-redhat-4.jar, into the software folder  
  
STEP 2: Build, start the container and grab the IP which is returned from startng the container  
-Build Image  
		$ docker build -t jbossdv600 .  
-Start Container
		$ docker run -P -d -t jbossdv600  
-Get the Container IP  
		$ docker inspect <$containerID>   
  
STEP 3: Browse the Data Virtualization and the Data  
-All Data  
		http://CONTAINER-IP:8080/odata/CustomerContextVDB/CustomerContextView.CustomerContext?$format=json  
-Specific Entity  
		http://CONTAINER-IP:8080/odata/CustomerContextVDB/CustomerContext('123')?$format=json  
-Metadata  
		http://CONTAINER-IP:8080/odata/CustomerContextVDB/$metadata  
-Management Console to view Virtual Database  
		http://CONTAINER-IP:8080  
-Dashboard  
		http://CONTAINER-IP:8080/dashboard/  
  
As Easy as 1,2,3....

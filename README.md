 
## OData with Data Virtualization and Docker

![alt text](https://raw.githubusercontent.com/kpeeples/dv-odata-docker-integration-demo/master/images/dvodatadockeroverview.jpg "Teiid VDBs")  

This project builds a [docker](http://www.docker.io) container for running [JBoss Data Virtualization](http://http://www.redhat.com/products/jbossenterprisemiddleware/data-virtualization/) 6.0.0.GA with a OData Multisource Virtual Database.  

This project was tested on Fedora 21 with Docker version:  
[root@localhost ~]# docker version  
Client version: 1.6.0  
Client API version: 1.18  
Go version (client): go1.4.2  
Git commit (client): 350a636/1.6.0  
OS/Arch (client): linux/amd64  
Server version: 1.6.0  
Server API version: 1.18  
Go version (server): go1.4.2  
Git commit (server): 350a636/1.6.0  
OS/Arch (server): linux/amd64  
  
## Steps to Run the Demo

**Management Credentials:**  
admin/redhat1!  
**Datavirtualization Credentials:**  
user/user  
  
**STEP 1:** Clone the Repository and Download Data Virtualization  
-git clone of the repository  
-Put the Data Virutalization Download, jboss-dv-installer-6.0.0.GA-redhat-4.jar, into the software folder  
  
**STEP 2:** Build, start the container and grab the IP which is returned from startng the container  
-Build Image  
		$ docker build -t jbossdv600 .  
-Start Container  
		$ docker run -P -d -t jbossdv600  
-Get the Container IP  
		$ docker inspect <$containerID>   
  
**STEP 3:** Browse the Data Virtualization and the Data  
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
  
**As Easy as 1,2,3....**

![alt text](https://raw.githubusercontent.com/kpeeples/dv-odata-docker-integration-demo/master/images/dvodatadocker.jpeg "Teiid VDBs")

# Angular and TypeScript Hello World CI/CD Project

The Hello World project is an Angular 2+ starter project that has the npm modules, 
configuration, scripts and folders and routing in place to make getting started 
with an Angular project easy!

Here's what is in the project:

* Angular scripts and TypeScript configuration are ready to go ,a simple app component and Bootstrap for CSS
* Make use of CI to build the project using Jenkins open source tool
* The pipeline consists of 4 stage: build , tag and push and transfer files and deploy
* The pipeline uses docker container technology in order to build the image and push it to the remote repo (docker hub)
* The final sep of the pipeline is to deploy the built image using Kubernetes (GKE) on Google Cloud Platform (GCP) after connecting to the created cluster
* Using jenkins, we can rollback to any previous built
* The created pod is deployed then exposed as load balancer and it is always having a high availability since the deployment YAML file ensure this property "strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate"
    

This is a very simple "Hello World" project to help get you started.


## Running the Application

1. You can access the service using the below IP address
http://34.133.31.106/

pipeline {
    agent any
    stages {
      stage('Preparation') { // for display purposes
                      steps {
         // Get some code from a GitHub repository
          git branch: 'master',
         url: 'https://github.com/yara-shehab/Angular-HelloWorld.git'
         // Get the Maven tool.
         // ** NOTE: This 'M3' Maven tool must be configured
         // **       in the global configuration.                      }
 
      }
      stage('Build') {
          steps{
          sh("docker build -t yarashehab/angularapp:v1.0 .")
          }
     }
      stage('tag and push')
      {
          steps{
              
                 withCredentials([usernamePassword(credentialsId:"docker",usernameVariable:"USERNAME",passwordVariable:"PASSWORD")])
         {
                 sh("docker login --username $USERNAME --password $PASSWORD")
                 sh("docker push yarashehab/angularapp:v1.0")
         }
          }
      }
      stage('Transfer files and deploy'){
          steps{
      //   sh("gcloud container clusters get-credentials cluster-1 --zone us-central1-c --project coffee-fpal")
        // sh("kubectl apply -f deployment.yaml")
         sh("docker run -d -p 7070:7070 yarashehab/angularapp:v1.0")
      }
      }
           }
    }

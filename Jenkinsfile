node {
   def GIT_REG = "github.com/yara-shehab/Angular-HelloWorld"
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
       git branch: 'master',
    url: 'https://github.com/yara-shehab/Angular-HelloWorld.git'
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
   }
   stage('Build') {
       sh("docker build -t yarashehab/angularapp:v1.0 .")
  }
   stage('tag and push')
   {
              withCredentials([usernamePassword(credentialsId:"docker",usernameVariable:"USERNAME",passwordVariable:"PASSWORD")])
      {
              sh("docker login --username $USERNAME --password $PASSWORD")
              sh("docker push yarashehab/angularapp:v1.0")
      }
   }
   stage('Transfer files and deploy'){
   //   sh("gcloud container clusters get-credentials cluster-1 --zone us-central1-c --project coffee-fpal")
     // sh("kubectl apply -f deployment.yaml")
      sh("docker run -d -p 8000:8000 yarashehab/angularapp:v1.0")
   }
}

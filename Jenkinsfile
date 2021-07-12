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
       sh("docker login --username yarashehab --password yara71997")  
       sh("docker push yarashehab/angularapp:v1.0")
   }
   stage('Transfer files and deploy'){
       sh("gcloud container clusters get-credentials cluster-1 --zone us-central1-c --project coffee-fpal")
       sh("kubectl apply -f deployment.yaml")
       sh("kubectl set image deployment/angularapp angularapp=$REG:$BUILD_NUMBER")
   }
}

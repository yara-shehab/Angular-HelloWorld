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
   stage('Deploy'){
    steps{

        //Deploy to GCP
        sh """
            #!/bin/bash 
            echo "deploy stage";
            curl -o /tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-225.0.0-linux-x86_64.tar.gz;
            tar -xvf /tmp/google-cloud-sdk.tar.gz -C /tmp/;
            /tmp/google-cloud-sdk/install.sh -q;

                        source /tmp/google-cloud-sdk/path.bash.inc;


             gcloud config set project ${coffee-fpal};
             gcloud components install app-engine-java;
             gcloud components install app-engine-python;

             gcloud config list;
             gcloud app deploy --version=v01;
                         echo "Deployed to GCP"
        """
        }   
   stage('Transfer files and deploy'){
      sh("gcloud container clusters get-credentials cluster-1 --zone us-central1-c --project coffee-fpal")
      sh("kubectl apply -f deployment.yaml")
      sh("kubectl set image deployment/angularapp")
   }
}

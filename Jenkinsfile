pipeline {
    agent any
    stages {
        stage("Checkout LDP code") {
            steps {
                sh("git clone https://github.com/yara-shehab/Angular-HelloWorld")
                sh("cd Angular-HelloWorld")
                
            }
        }
        stage("Buildimage") {
           steps {
                   docker.build("yarashehab/angularapp:v1.0","-f ./Dockerfile .")

           }
        }

        stage("push and tag") {
            steps {
              withCredentials([usernamePassword(credentialsId:"docker",usernameVariable:"USERNAME",passwordVariable:"PASSWORD")])
      {
              sh("docker login --username $USERNAME --password $PASSWORD")
              sh("docker push yarashehab/angularapp:v1.0")
      }
            }
        }
    }
        
}

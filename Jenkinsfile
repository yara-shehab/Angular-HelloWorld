pipeline {
    agent any
    stages {
        stage("Checkout LDP code") {
            steps {
                checkout scm
            }
        }
        stage("Buildimage") {
           steps {
               script {
                   frontend = docker.build("yarashehab/angularapp:v1.0","-f ./Dockerfile .")
                }
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

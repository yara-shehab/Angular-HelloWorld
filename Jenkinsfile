pipeline {
    agent any
    stages {
        stage("Checkout LDP code") {
            steps {
                checkout scm
            }
        }
        stage("prepare the FE confing and build it") {
            steps {
          sh("docker build -t yarashehab/angularapp:v1.0 .")

            }
        }
        stage("Build backend image") {
           steps {
                 withCredentials([usernamePassword(credentialsId:"docker",usernameVariable:"USERNAME",passwordVariable:"PASSWORD")])
         {
                 sh("docker login --username $USERNAME --password $PASSWORD")
                 sh("docker push yarashehab/angularapp:v1.0")
         }
           }
        }
    
}



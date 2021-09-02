pipeline {
    agent any
    environment {
        PROJECT_ID = 'lxt-ldp-dev'
        CLUSTER_NAME = 'ldp-dev-cluster'
        LOCATION = 'us-east1-b'
        CREDENTIALS_ID = 'ldp-dev'
        REACT_APP_GOOGLE_AUTH_DOMAIN= 'lxt-ldp-dev.firebaseapp.com'
        REACT_APP_GOOGLE_API_KEY= 'AIzaSyA6hJiue5S1MtFhIfQr0899NhktW5b9XhE'
    }
    stages {
        stage("Checkout LDP code") {
            steps {
                checkout scm
            }
        }
        stage("prepare the FE confing and build it") {
            steps {
                sh '''
                    cd frontend
                    cp src/configuration/config.production.js src/configuration/config.js
                    npm install --only=prod
                    CI=false REACT_APP_GOOGLE_AUTH_DOMAIN=lxt-ldp-dev.firebaseapp.com REACT_APP_GOOGLE_API_KEY=AIzaSyA6hJiue5S1MtFhIfQr0899NhktW5b9XhE npm run build-bundle
                    cp -a build ../
                   cd ..
                '''
            }
        }
        stage("Build backend image") {
           steps {
               script {
                   backend = docker.build("gcr.io/lxt-ldp-dev/backend:${env.BUILD_ID}","-f ./Dockerfile-be-dev-gke .")
                }
           }
        }
        stage("Push backend image") {
            steps {
                script {
                    docker.withRegistry('https://gcr.io', 'gcr:ldp-dev') {
                            backend.push("latest")
                            backend.push("${env.BUILD_ID}")
                    }
                }
            }
        }
        stage("Build frontend image") {
           steps {
               script {
                   frontend = docker.build("gcr.io/lxt-ldp-dev/frontend:${env.BUILD_ID}","-f ./Dockerfile-fe-dev-gke .")
                }
           }
        }
        stage("Push frontend image") {
            steps {
                script {
                    docker.withRegistry('https://gcr.io', 'gcr:ldp-dev') {
                            frontend.push("latest")
                            frontend.push("${env.BUILD_ID}")
                    }
                }
            }
        }
        stage("prepare the deployments Number for GKE") {
            steps {
		    sh "sed -i 's/latest/${env.BUILD_ID}/g' gke-files-dev/backend-deployment.yml"
		    sh "sed -i 's/latest/${env.BUILD_ID}/g' gke-files-dev/frontend-deployment.yml"
                    sh "sed -i 's/latest/${env.BUILD_ID}/g' gke-files-dev/celery-deployment.yml"
                    sh "sed -i 's/latest/${env.BUILD_ID}/g' gke-files-dev/client-api-deployment.yml"
            }
        }
        stage('Deploy client-api to GKE') {
            steps{
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'gke-files-dev/client-api-deployment.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
        stage('Deploy celery to GKE') {
            steps{
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'gke-files-dev/celery-deployment.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
        stage('Deploy backend to GKE') {
            steps{
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'gke-files-dev/backend-deployment.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
        stage('Deploy frontend to GKE') {
            steps{
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'gke-files-dev/frontend-deployment.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }
        stage("Doing the migrate command") {
            steps {
		sleep(time: 60, unit: "SECONDS")
                sh '''
                    #Connect to GKE
                    gcloud container clusters get-credentials ldp-dev-cluster --region us-east1-b --project lxt-ldp-dev
                    #Migration
                    kubectl exec `kubectl get pods | grep backend | grep Running | awk '{print $1}' | head -n1` -- /bin/bash -c 'cd lxt_app && alembic upgrade head'
                '''
            }
        }
    }
        post {
            always {
                echo 'sending email status!'
                emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
        }
    }
}

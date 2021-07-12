node {
   def label = "gcloud-command-${UUID.randomUUID().toString()}"
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

deploymentTemplate(label: label, yaml: """
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    run: myapp
  name: myapp
  namespace: frontend
spec:
  replicas: 2
  selector:
    matchLabels:
      run: myapp
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      labels:
        run: myapp
    spec:
      containers:
      - env:
        image: yarashehab/angularapp:v1.0
        imagePullPolicy: Always
        name: myapp
      imagePullSecrets:
        - name: dockerhubreg
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
"""
  ) {
    stage('Test -  Execution of gcloud command') {
      container('gcloud') {
        sh "gcloud compute zones --help"
      }
    }

  }

   stage('Transfer files and deploy'){
      sh("gcloud container clusters get-credentials cluster-1 --zone us-central1-c --project coffee-fpal")
      sh("kubectl apply -f deployment.yaml")
      sh("kubectl set image deployment/angularapp angularapp=$REG:$BUILD_NUMBER")
   }
}

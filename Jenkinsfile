pipeline {
    agent any

    environment {
        IMAGE_NAME = "springbootapi"
        CONTAINER_NAME = "springbootapi"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/saikauthale/sprigboot22.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t springbootapi:latest .'
            }
        }

        stage('Deploy Docker') {
            steps {
                sh '''
                docker stop springbootapi || true
                docker rm springbootapi || true

                docker run -d \
                  --name springbootapi \
                  -p 8080:8080 \
                  springbootapi:latest
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

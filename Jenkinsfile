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
stage('Verify Jar') {
    steps {
        sh '''
        pwd
        ls -lh target
        '''
    }
}
        stage('Build Docker Image') {
    steps {
        sh '''
        ls -lh target
        docker build -t springbootapi:latest .
        '''
    }
}
        stage('Deploy Docker') {
    steps {
        sh '''
        docker stop springbootapi || true
        docker rm springbootapi || true

        # Kill any process using port 8080
        sudo fuser -k 8080/tcp || true

        docker run -d \
          --name springbootapi \
          -p 8081:8080 \
          springbootapi:latest
        '''
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

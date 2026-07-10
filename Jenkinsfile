pipeline {
    agent any

    tools {
    jdk 'JDK17'
    maven 'Maven'
}
    environment {
        SCANNER_HOME = tool 'SonarScanner'
        IMAGE_NAME = "springboot-app"
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

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                    ${SCANNER_HOME}/bin/sonar-scanner
                    """
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t springboot-app .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                docker stop springboot-app || true
                docker rm springboot-app || true

                docker run -d \
                --name springboot-app \
                -p 8080:8080 \
                springboot-app
                '''
            }
        }

    }

    post {

        success {
            echo 'Pipeline executed successfully'
        }

        failure {
            echo 'Pipeline failed'
        }
    }
}

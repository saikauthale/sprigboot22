pipeline {
    agent any

    stage('SonarQube Analysis') {
    steps {
        withSonarQubeEnv('SonarQube') {
            sh """
            ${SCANNER_HOME}/bin/sonar-scanner
            """
        }
    }
}
    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/saikauthale/sprigboot22.git'
            }
        }

        stage('Clean Workspace') {
            steps {
                sh '''
                rm -rf target || true
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                java -version
                javac -version
                mvn -version
                docker --version
                '''
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
                    ${SCANNER_HOME}/bin/sonar-scanner \
                    -Dsonar.projectKey=springbootapi \
                    -Dsonar.projectName=springbootapi \
                    -Dsonar.sources=src/main/java \
                    -Dsonar.java.binaries=target/classes
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t springbootapi:latest .
                '''
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
            echo "Pipeline completed successfully."
        }

        failure {
            echo "Pipeline failed."
        }
    }
}

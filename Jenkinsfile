pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/saikauthale/sprigboot22.git'
            }
        }

        stage('Check Java Compiler') {
    steps {
        sh '''
        java -version
        javac -version
        mvn -version
        which java
        which javac
        echo $JAVA_HOME
        '''
    }
}

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
    }
}

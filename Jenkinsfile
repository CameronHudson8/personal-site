pipeline {
    agent {
        label 'docker'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                docker-compose -f docker-compose.prod.yml build
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying..'
                docker-compose -f docker-compose.prod.yml up
            }
        }
    }
}
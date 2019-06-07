pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'echo "Building..."'
                sh 'docker-compose -f docker-compose.prod.yml build'
            }
        }
        stage('Test') {
            steps {
                sh 'echo "Testing..."'
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo "Deploying..."'
                sh 'docker-compose -f docker-compose.prod.yml up'
            }
        }
    }
}
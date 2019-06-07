def withColor = [$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                wrap(withColor) {
                    sh 'echo "Building..."'
                    sh 'docker-compose -f docker-compose.prod.yml build'
                }   
            }
        }
        stage('Test') {
            steps {
                wrap(withColor) {
                    sh 'echo "Testing..."'
                }
            }
        }
        stage('Deploy') {
            steps {
                wrap(withColor) {
                    sh 'echo "Deploying..."'
                    sh 'docker-compose -f docker-compose.prod.yml up'
                }
            }
        }
    }
}
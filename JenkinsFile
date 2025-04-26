pipeline {
    agent any
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t art-gallery .'
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker stop gallery-container || true'
                sh 'docker rm gallery-container || true'
                sh 'docker run -d --name gallery-container -p 80:80 art-gallery'
            }
        }
    }
}

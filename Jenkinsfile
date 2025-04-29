pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "darell240/artgallery"
        DOCKER_CREDENTIALS = "docker-hub-credentials"
        // Generate a timestamp tag (optional)
        TIMESTAMP = sh(script: 'date +%Y%m%d-%H%M%S', returnStdout: true).trim()
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', 
                url: 'https://github.com/Darell240/DarelllewisComp314Ass2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build with both 'latest' and timestamp tags
                    docker.build("${DOCKER_IMAGE}:latest")
                    docker.build("${DOCKER_IMAGE}:${TIMESTAMP}")
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry-1.docker.io/v2/', DOCKER_CREDENTIALS) {
                        echo "Successfully logged in to Docker Hub"
                    }
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS) {
                        // Push both tags
                        docker.image("${DOCKER_IMAGE}:latest").push()
                        docker.image("${DOCKER_IMAGE}:${TIMESTAMP}").push()
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh "docker image prune -f"
                    sh "docker stop artgallery-container || true"
                    sh "docker rm artgallery-container || true"
                    // Deploy with the 'latest' tag
                    sh "docker run -d --name artgallery-container -p 80:80 ${DOCKER_IMAGE}:latest"
                }
            }
        }
    }

    post {
        success {
            echo "Art Gallery deployed! Access: http://<YOUR_EC2_IP>"
            echo "Docker Images Pushed:"
            echo "- ${DOCKER_IMAGE}:latest"
            echo "- ${DOCKER_IMAGE}:${TIMESTAMP}"
        }
        failure {
            echo 'Deployment failed. Check logs above.'
        }
    }
}

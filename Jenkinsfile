pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'rohith0702/app1'
    }

    stages {
        stage('Build Jar') {
            steps {
                script {
                    sh 'mvn clean install -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $DOCKER_IMAGE:latest ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push $DOCKER_IMAGE:latest"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh """
                        docker network ls | grep my-network || docker network create my-network
                        docker ps -a -q --filter 'name=springboot-container' | grep . && docker rm -f springboot-container || echo No container to stop
                        docker run -d -p 8082:8082 --name springboot-container --network my-network $DOCKER_IMAGE:latest
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ App is live on Docker container!'
        }
        failure {
            echo '❌ Something went wrong. Check logs!'
        }
    }
}

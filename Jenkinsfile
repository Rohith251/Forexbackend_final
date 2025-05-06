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
                    
                        sh "docker build -t %DOCKER_IMAGE:latest ."
                    
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                        sh "docker push %DOCKER_IMAGE:latest"
                    }
                }
            }
        

        stage('Run Docker Container') {
            steps {
                script {
                    sh """
                        docker ps -a -q --filter "name=springboot-container" | findstr . && docker rm -f springboot-container || echo No container to stop
                        docker run -d -p 8081:8081 --name springboot-container --network my-network %DOCKER_IMAGE%:latest
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'App is live on Docker container '
        }
        failure {
            echo 'Something went wrong '
          }
}
}

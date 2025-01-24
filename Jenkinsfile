pipeline {
    agent {label 'slave1'}

    environment {
        IMAGE_NAME = 'abdelaziz20598/nodejs-app-depi'
        IMAGE_TAG = "v1.0-${BUILD_NUMBER}"  // Use BUILD_NUMBER or any dynamic value
    }

    stages {
        stage('Preparation') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'myuser', passwordVariable: 'mypass')]) {
                    git url: 'https://github.com/Abdelaziz20598/nodjs-container-app', credentialsId: 'github'
                }
            }
        }


        stage('CI - Build and Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'mypass', usernameVariable: 'myuser')]) {
                    script {
                        // Build Docker image
                        sh """
                            docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                        """
                        
                        // Docker login
                        sh """
                            docker login -u ${myuser} -p ${mypass}
                        """
                        
                        // Push Docker image
                        sh """
                            docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }

        stage('CD - Deploy Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'mypass', usernameVariable: 'myuser')]) {
                    script {
                        // Docker login
                        sh """
                            docker login -u ${myuser} -p ${mypass}
                        """
                        
                        // Optionally stop and remove any existing container
                        sh """
                            docker stop nodejs || true
                            docker rm nodejs || true
                        """
                        
                        // Run the new container
                        sh """
                            docker run -d -p 3000:3000 --name nodejs ${IMAGE_NAME}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }
    }
}

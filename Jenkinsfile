pipeline {
    agent any 
    stages {
        stage('SCM Checkout') {
            steps {
                script {
                git credentialsId: 'git-credit', url: 'https://github.com/akas194-git/CI-CD'   
                }
            }
         
        }
        stage('Build image') {
            steps {
                echo 'Starting to build docker image'

                script {
                sh 'docker build -t akas/my-web:v1 .'
                
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'DockerHubPass', variable: 'DockerHubPWD')]){    
                        sh "docker login -u akas194 -p ${DockerHubPWD}"
                
                    } 
                sh 'docker tag akas/my-web:v1 akas194/jenkins-web:v1'
                sh 'docker push akas194/jenkins-web:v1'
                }    
            }
            
        }
        stage('push to production') {
            steps {
                script {
                    def doccmd = 'sudo docker run -d -p 80:80 akas194/jenkins-web:v1'
                    sshagent(['my-key']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.16.6 ${doccmd}"
                    }
                }
            }
        }
    }
    
}




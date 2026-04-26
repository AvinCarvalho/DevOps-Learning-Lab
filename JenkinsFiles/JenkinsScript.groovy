pipeline {
    agent any

    stages {

        stage('Clone Code') {
            steps {
                git branch: 'dev', url: 'https://github.com/AvinCarvalho/DevOps-Learning-Lab.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-app -f docker/Dockerfile .'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh 'docker rm -f devops-container || true'
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d -p 80:80 --name devops-container devops-app'
            }
        }
    }
}
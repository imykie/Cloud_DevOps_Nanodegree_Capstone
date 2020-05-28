pipeline {
    environment {
        dockerCredentials = 'docker-cred'
    }
    agent any 
    stages {
        stage('Setup Environment') {
            steps {
                sh '''
                    sudo apt-get install -y python3-venv
                    python3 -m venv venv
                    . venv/bin/activate
                '''
            }
        }
        stage('Install Dependencies'){
            steps {
                sh '''
                    . venv/bin/activate
                    make install
                    sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
                    sudo chmod +x /bin/hadolint
                '''

            }
        }
        stage('Lint Dockerfile and app.py') {
            steps {
                sh '''
                    . venv/bin/activate
                    make lint
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                
                sh 'make build'
            }
        }
        stage('Push Image to DockerHub Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub-cred', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh '''
                        docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                        make push
                     '''
                }
            }
        }
    }
}
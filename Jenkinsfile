pipeline {
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
                    make install
                    sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
                    sudo chmod +x /bin/hadolint
                '''

            }
        }
        stage('Lint App') {
            steps {
                sh '''
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
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub-cred', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]) {
                    sh '''
                        docker login -u $DOCKER_NAME -p $DOCKER_PASSWORD
                        make push
                    '''        
                }
            }
        }
    }
}
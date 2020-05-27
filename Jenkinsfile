pipeline {
    agent any 
    stages {
        stage('Lint App') {
            steps {
                sh '''
                
                #install hadolint
                sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
                sudo chmod +x /bin/hadolint 
                make lint
                
                '''
            }
        }

        stage('Build Docker image') {
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
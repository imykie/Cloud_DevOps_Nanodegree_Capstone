pipeline {
    environment {
        USER_CREDENTIALS = credentials('dockerhub-cred')
        REGISTRY = 'imykel/devops-capstone'
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

                sh '''
                    sudo chmod +x upload_docker.sh
                    ./upload_docker.sh $USER_CREDENTIALS_USR $USER_CREDENTIALS_PSW 
                '''
            }
        }

        stage('Update kubectl config') {
            steps {
                withAWS(credentials: 'aws-cred', region: 'us-west-2') {
                    sh '''
                        aws eks --region us-west-2 update-kubeconfig --name CapstoneEKS-15iqwZ42Gu0e
                        kubectl get svc
                        '''
                }
            }
        }

        stage('Authenticate kubectl') {
            steps {
                withAWS(credentials: 'aws-cred', region: 'us-west-2') {
                    sh '''
                        kubectl apply -f ./kubernetes/aws-auth.yml
                        '''
                }
            }
        }

        stage ('Deployment') {
            steps {
                withAWS(credentials: 'aws-cred', region: 'us-west-2') {
                    sh '''
                        kubectl apply -f ./kubernetes/deployment.yml
                        kubectl get nodes
                        kubectl describe nodes
                        kubectl get pods
                        kubectl describe pods
                        ./infrastructures/update-stack.sh capstone-nodes nodes.yml nodes-params.json
                        kubectl get deployments
                        kubectl describe deployments
                    '''
                }
            }
        }

        stage( 'Clean Docker') {
            steps {
                sh '''
                    echo "Cleaning Docker"
                    docker system prune
                '''
            }
        }
    }
}
node {
    
    def dockerCredentials = 'dockerhub-cred'    
     
    stage('Setup Environment') {
            sh '''
                sudo apt-get install -y python3-venv
                python3 -m venv venv
                . venv/bin/activate
            '''
    }
    stage('Install Dependencies'){
            sh '''
                . venv/bin/activate
                make install
                sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
                sudo chmod +x /bin/hadolint
            '''
    }
    stage('Lint Dockerfile and app.py') {
            sh '''
                . venv/bin/activate
                make lint
            '''
    }

    stage('Build Docker Image') {

            sh 'make build'

    }
    stage('Push Image to DockerHub Registry') {
            withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                sh '''
                    docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}
                    make push
                    '''
            }
    }
}
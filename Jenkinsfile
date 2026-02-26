pipeline {
    agent any

    environment {
        DOCKER_CREDS = credentials('dockerhub-credentials')
        DOCKER_USERNAME = "${DOCKER_CREDS_USR}"
        DOCKER_PASSWORD = "${DOCKER_CREDS_PSW}"
    }

    stages {

        stage('Clone Application Repo') {
            steps {
                sh '''
                rm -rf app
                git clone https://github.com/sriram-R-krishnan/devops-build.git app
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                cd app
                docker build -t devops-build-app:${BUILD_NUMBER} .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

                if [ "$BRANCH_NAME" = "dev" ]; then
                    REPO="devops-build-app-dev"
                else
                    REPO="devops-build-app-prod"
                fi

                docker tag devops-build-app:${BUILD_NUMBER} $DOCKER_USERNAME/$REPO:${BUILD_NUMBER}
                docker push $DOCKER_USERNAME/$REPO:${BUILD_NUMBER}
                '''
            }
        }
    }
}

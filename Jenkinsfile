pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '516027198936'
        AWS_REGION = 'us-east-1'
        API_ECR_REPO = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/safemeet-api"
        WEB_ECR_REPO = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/safemeet-web"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 516027198936.dkr.ecr.us-east-1.amazonaws.com
                '''
            }
        }

        stage('Build API Image') {
            steps {
                sh 'docker build --target api -t $API_ECR_REPO:$BUILD_NUMBER -t $API_ECR_REPO:latest .'
            }
        }

        stage('Build Web Image') {
            steps {
                sh 'docker build --target web -t $WEB_ECR_REPO:$BUILD_NUMBER -t $WEB_ECR_REPO:latest .'
            }
        }

        stage('Push Images to ECR') {
            steps {
                sh '''
                    docker push $API_ECR_REPO:$BUILD_NUMBER
                    docker push $API_ECR_REPO:latest
                    docker push $WEB_ECR_REPO:$BUILD_NUMBER
                    docker push $WEB_ECR_REPO:latest
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    docker stop safemeet-api safemeet-web 2>/dev/null || true
                    docker rm safemeet-api safemeet-web 2>/dev/null || true
                    docker run -d --name safemeet-api --restart always -p 4000:4000 --env-file /home/ubuntu/Nodejsproject/.env -e NODE_ENV=development -e LOG_FILE_PATH=/dev/stdout $API_ECR_REPO:latest
                    docker run -d --name safemeet-web --restart always -p 3000:3000 -e NODE_ENV=production -e NEXT_PUBLIC_API_URL=http://35.171.102.214:4000 $WEB_ECR_REPO:latest
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed! App is deployed.'
        }
        failure {
            echo 'Pipeline failed! Check the logs.'
        }
    }
}

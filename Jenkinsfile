pipeline {
    agent any

    environment {
        IMAGE_NAME = 'devops-ci-demo'
        IMAGE_TAG  = "${env.BUILD_NUMBER}"
        CONTAINER  = 'devops-ci-demo'
        HOST_PORT  = '8081'   // 8080 is used by Jenkins itself
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Test') {
            steps {
                echo 'Running smoke tests...'
                sh 'chmod +x test.sh && ./test.sh'
            }
        }

        stage('Build Image') {
            steps {
                echo "Building Docker image ${IMAGE_NAME}:${IMAGE_TAG}..."
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG -t $IMAGE_NAME:latest .'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying container...'
                // Stop any previous container, then run the new one
                sh '''
                    docker rm -f $CONTAINER || true
                    docker run -d --name $CONTAINER -p $HOST_PORT:80 $IMAGE_NAME:latest
                '''
            }
        }

        stage('Verify') {
            steps {
                echo 'Verifying the site responds...'
                sh 'sleep 3 && curl -f http://localhost:$HOST_PORT > /dev/null && echo "Site is up ✅"'
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline succeeded — site running on port ${HOST_PORT}"
        }
        failure {
            echo '❌ Pipeline failed — check the stage logs above.'
        }
        always {
            echo 'Pipeline finished.'
        }
    }
}

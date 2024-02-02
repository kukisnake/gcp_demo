pipeline {
    agent any

     environment {
            GOOGLE_APPLICATION_CREDENTIALS = credentials('your-service-account-key-id')
            SECRET_CONTENT = sh(returnStdout: true, script: "gcloud secrets versions access latest --secret=your-secret-name")
        }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your/repo.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh 'npm install && npm test'
            }
        }

        stage('Terraform Apply') {
            steps {
            withCredentials([file(credentialsId: 'your-service-account-key-id', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        sh 'export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS && terraform init'
                        sh 'export GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS && terraform apply -auto-approve'
                    }
            }
        }

        stage('Deployment') {
            steps {
                // Deploy application code to GCP services
                // (e.g., upload frontend to GCS, deploy backend function)
            }
        }

        stage('Cleanup') {
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}

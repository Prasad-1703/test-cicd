pipeline {
    agent any

    environment {
        // Jenkins credentials ID to access Tomcat
        TOMCAT_CREDENTIALS = credentials('tomcat-credentials')
        
        // Path to the WAR file after build
        WAR_FILE = 'target/myapp.war'  
        
        // Tomcat Manager URL and context path for the deployment
        TOMCAT_URL = 'http://<your_vm_ip>:8081/manager/text'
        CONTEXT_PATH = '/myapp'        
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                // Pulls the latest code from your GitHub repository
                git branch: 'main', url: 'https://github.com/your-username/your-github-repo.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                // Building the WAR file using Maven
                sh 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                echo 'Deploying the WAR file to Tomcat...'
                script {
                    def deployUrl = "${TOMCAT_URL}/deploy?path=${CONTEXT_PATH}&update=true"

                    // Using curl to upload the WAR file to Tomcat
                    sh """
                        curl -u ${TOMCAT_CREDENTIALS_USR}:${TOMCAT_CREDENTIALS_PSW} \
                        --upload-file ${WAR_FILE} \
                        ${deployUrl}
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment succeeded!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}

pipeline {
    agent {
        docker {
            image 'gradle:7.6-jdk17'
        }
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Test') {
            steps {

                    sh './gradlew clean build'

                script {
                    def jacocoTool = jacoco(execPattern: 'build/jacoco/test.exec')
                    if (jacocoTool != null) {
                        recordCoverage tools: [jacocoTool]
                    } else {
                        echo "Jacoco tool configuration is null. Skipping coverage recording."
                    }
                }
            }
        }

        stage('Archive Results') {
            when {
                branch 'master'
            }
            steps {
                archiveArtifacts 'build/libs/*.jar'
            }
        }
    }
}

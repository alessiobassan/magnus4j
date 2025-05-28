pipeline {
    agent any
    tools {
        jdk 'openjdk-8-jdk'
        gradle 'Gradle 9.0-milestone-6'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Preparation') {
            steps {
                echo 'Preparing..'
                checkout scm
            }
        }

        stage('Build and Testing') {
            steps {
                echo 'Building..'
                sh './gradlew clean build'
                
                sh 'ls build/reports/tests'
                
                echo 'Testing..'


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
            
        stage('Results') {
           when{
                branch "master"
            }
            steps {
                echo 'Archiving..'
                archiveArtifacts 'build/libs/*.jar'
            }
        }   
    }
}

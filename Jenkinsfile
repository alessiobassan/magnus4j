pipeline {
    agent any
    
    stages {
        stage('Clean Workspace') {
            agent {
                docker {
                    image 'gradle:7.6-jdk17'
                }
            }
            steps {
                cleanWs()
            }
        }

        stage('Preparation') {
            steps {
                echo 'Preparing..'
                script {
                    checkout scm
                }
            }
        }

        stage('Build and Testing') {
            agent {
                docker {
                    image 'gradle:7.6-jdk17'
                }
            }
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
            agent {
                docker {
                    image 'gradle:7.6-jdk17'
                }
            }
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

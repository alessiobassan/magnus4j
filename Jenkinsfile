pipeline {
    agent any
    
    stages {
        stage('Clean Workspace') {
            agent {
                dockerfile {
                    filename 'Dockerfile'
                    dir '.'
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
                dockerfile {
                    filename 'Dockerfile'
                    dir '.'
                }
            }
            steps {
                echo 'Building..'
                
                sh 'chmod +x ./gradlew'
                
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
                dockerfile {
                    filename 'Dockerfile'
                    dir '.'
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

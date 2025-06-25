pipeline {
    agent {
        dockerfile {
            filename 'Dockerfile'
            dir '.'
            args "--mount source=jenkins_workspace_volume,target=/workspace"
        }
    }
    
    environment {
        DOCKER_VOLUME = 'jenkins_workspace_volume'
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
                script {
                    checkout scm
                }
            }
        }

        stage('Build and Testing') {
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

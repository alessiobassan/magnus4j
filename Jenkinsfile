pipeline {
    environment {
	DOCKER_VOLUME = 'jenkins_workspace_volume'
    }

    agent {
        dockerfile {
            filename 'Dockerfile'
            dir '.'
            args "--mount source=jenkins_workspace_volume,target=/workspace"
            additionalBuildArgs """
                --build-arg UID=${JENKINS_UID} \
                --build-arg GID=${JENKINS_GID} \
                --build-arg UNAME=${JENKINS_UNAME}
            """
        }
    }
    
    stages {
	
	stage('Init Environment') {
	     steps {
        	env.JENKINS_UID = sh(script: 'id -u', returnStdout: true).trim()
        	env.JENKINS_GID = sh(script: 'id -g', returnStdout: true).trim()
        	env.JENKINS_UNAME = sh(script: 'id -un', returnStdout: true).trim()
	     }
	}

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

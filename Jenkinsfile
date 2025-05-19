pipeline {
    agent any
    tools {
        jdk 'openjdk-8-jdk'
    }

    stages {
        stage('Preparation') {
            steps {
                echo 'Preparing..'
                git 'git@github.com:alessiobassan/magnus4j.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building..'
                sh './gradlew build'
            }
        }    
            
        stage('Results') {
            steps {
                //add an echo
                archiveArtifacts 'build/libs/*.jar'
            }
        }   
    }
}


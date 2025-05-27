pipeline {
    agent any
    tools {
        jdk 'openjdk-8-jdk'
    }

    stages {
        stage('Preparation') {
            steps {
                echo 'Preparing..'
                git 'https://github.com/alessiobassan/magnus4j.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building..'
                sh './gradlew build'
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


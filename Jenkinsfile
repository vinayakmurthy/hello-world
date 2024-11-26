pipeline{
    agent any
    tools{
        maven 'MVN3'
        jdk "JDK11"
    }

    stages{
        stage('fetch code'){
            steps{
                git branch: 'master', url: 'https://github.com/vinayakmurthy/hello-world.git'
            }
        }
        
        stage('Build'){
            steps{
                sh "mvn clean install"
            }
        }
    }
}
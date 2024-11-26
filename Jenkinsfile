pipeline{
    agent any
    tools{
        maven 'MVN3'
        jdk "JDK11"
    }
    environment{
        TOMCAT_URL = 'http://54.172.8.187:8080/'
    }

    stages{
        stage('fetch the code'){
            steps{
                git branch: 'master', url: 'https://github.com/vinayakmurthy/hello-world.git'
            }
        }
        
        stage('Build the code'){
            steps{
                sh "mvn clean install"
            }
        }
        stage('permission'){
            sh 'chmod 644 target/webapp/webapp.war'
        }

        stage('Deploy the artifact to tomcat'){
            steps{
               withCredentials([usernamePassword(credentialsId: 'tomcat-deployer', usernameVariable: 'DEPLOYER_USER', passwordVariable: 'DEPLOYER_PASS')]) {
                sh "curl --user $DEPLOYER_USER:$DEPLOYER_PASS --upload-file target/webapp/webapp.war $TOMCAT_URL/deploy?path=/myapp"
               }
            }
        }
    }
}

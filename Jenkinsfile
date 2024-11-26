pipeline{
    agent any
    tools{
        maven 'MVN3'
        jdk "JDK11"
    }
    environment{
        TOMCAT_URL = 'http://184.72.102.195:8080/'
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

        stage('Deploy the artifact'){
            steps{
               withCredentials([usernamePassword(credentialsId: 'tomcat-deployer', usernameVariable: 'DEPLOYER_USER', passwordVariable: 'DEPLOYER_PASS')])
               {
                sh "curl --user $DEPLOYER_USER:$DEPLOYER_PASS --upload-file target/webapp/webapp.war $TOMCAT_URL/deploy?path=/myapp"
               }
            }
        }
    }
}

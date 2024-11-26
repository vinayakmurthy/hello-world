pipeline{
    agent any
    tools{
        maven 'MVN3'
        jdk "JDK11"
    }
    environment{
        TOMCAT_URL = 'http://54.196.56.119:8080'
        artifact_path = '/var/lib/jenkins/workspace/FetchandBuild/webapp/target/webapp.war'
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

        stage('Deploy the artifact to tomcat'){
            steps{
               withCredentials([usernamePassword(credentialsId: 'tomcat-deployer', usernameVariable: 'DEPLOYER_USER', passwordVariable: 'DEPLOYER_PASS')]) {
                sh """
                curl -X POST --user \$DEPLOYER_USER:\$DEPLOYER_PASS --upload-file $artifact_path \$TOMCAT_URL/deploy?path=/myapp
                
                """
               }
            }
        }
    }
}

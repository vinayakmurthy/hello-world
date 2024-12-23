pipeline{
    agent any
    tools{
        maven 'MVN3'
        jdk "JDK11"
    }
    environment{
        TOMCAT_URL = 'http://172.31.89.202:8080'
        artifact_path = '/var/lib/jenkins/workspace/FetchandBuild/webapp/target/webapp.war'
        DOCKER_REGISTRY = "https://index.docker.io/v1/"
        DOCKER_IMAGE = "coderhub1/tomcat"
        DOCKER_HOST = "ssh://dockeradmin@172.31.83.7"

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

        // stage('Deploy the artifact to tomcat'){
        //     steps{
        //        withCredentials([usernamePassword(credentialsId: 'tomcat-deployer', usernameVariable: 'DEPLOYER_USER', passwordVariable: 'DEPLOYER_PASS')]) {
        //         sh """
        //         curl --user $DEPLOYER_USER:$DEPLOYER_PASS --upload-file $artifact_path $TOMCAT_URL/manager/text/deploy?path=/myapp.gcs.com
                
        //         """
        //        }
        //     }
        // }

        stage('build the tomcat image'){
            environment{
                DOCKER_HOST = "ssh://dockeradmin@172.31.83.7"
            }
            steps{
                script{
                    dockerimage = docker.build("${DOCKER_IMAGE}:$BUILD_NUMBER", ".")
                }
            }
        }

        stage('push the image'){
            steps{
                script{
                    docker.withRegistry(DOCKER_REGISTRY, 'dockercred' ){
                       dockerimage.push("$BUILD_NUMBER")
                       dockerimage.push("latest") 
                    }
                }
            }
        }

        stage('deploy to docker container'){
            steps{
                script{
                    sh """
                    docker rmi $DOCKER_IMAGE:{47..51}
                    docker pull $DOCKER_IMAGE:$BUILD_NUMBER
                    docker run -d --name tomcat-cont-$BUILD_NUMBER -p 8080:8080 $DOCKER_IMAGE:$BUILD_NUMBER
                    
                    """
                
                }
            }
        }
    }
}

pipeline {
    agent any
    tools{
        jdk 'java-11-openjdk'
        maven 'Maven 3.6.3'
    }

    stages{
        stage("Compile Project"){
            steps{
                sh "mvn clean compile"
            }
        }

         stage("Execute Test Cases"){
            steps{
                sh "mvn test"
            }
        }

         stage("Build Project"){
            steps{
                sh "mvn clean install"
            }
        }
        stage("Build Docker Image"){
            steps{
                sh "docker build -t benidocker95/the_cat_jenkins_hw:$env.BUILD_NUMBER ."
            }
        }
        stage("Push Docker Image"){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: "dockerCred", usernameVariable: "DOCKER_REPOSITORY_USER", passwordVariable: "DOCKER_REPOSITORY_PASSWORD")]){
                        sh "docker login -u $DOCKER_REPOSITORY_USER -p $DOCKER_REPOSITORY_PASSWORD"
                        sh "docker push benidocker95/the_cat_jenkins_hw:$env.BUILD_NUMBER"
                    }
                }
            }
        }
    }
}

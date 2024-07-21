pipeline {
    agent any
    tools{
        jdk 'java 8'
        maven 'Maven 3.8.7'
        dockerTool 'Docker 27.0.3'
    }
    environment {
            JAVA_URL = 'https://builds.openlogic.com/downloadJDK/openlogic-openjdk/8u412-b08/openlogic-openjdk-8u412-b08-linux-x64.tar.gz'
            JAVA_HOME_DIR = '/var/jenkins_home/tools/jdk8'
        }

    stages{
        stage('Download and Unpack JDK') {
            steps {
                script {
                    sh '''
                        # Download JDK tarball
                        curl -L -o /var/jenkins_home/tools/jdk.tar.gz ${JAVA_URL}

                        # Create directory for JDK if it doesn't exist
                        mkdir -p ${JAVA_HOME_DIR}

                        # Unpack the tarball into the directory
                        tar -xzf /var/jenkins_home/tools/jdk.tar.gz -C ${JAVA_HOME_DIR} --strip-components=1

                        # Clean up the tarball
                        rm /var/jenkins_home/tools/jdk.tar.gz
                    '''

                    // Set JAVA_HOME environment variable
                    env.JAVA_HOME = "${JAVA_HOME_DIR}"
                    echo "JAVA_HOME is set to: ${env.JAVA_HOME}"

                    // Add JAVA_HOME to the PATH
                    env.PATH = "${env.JAVA_HOME}/bin:${env.PATH}"
                }
            }
        }

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

//         stage('Add Jenkins User to Docker Group') {
//             steps {
//                     script {
//                         sh '''
//                            echo "BeniJenkins1!" | su - root -c groupadd docker
//                            echo "BeniJenkins1!" | su - root -c usermod -aG docker jenkins
//                            echo "BeniJenkins1!" | su - root -c systemctl restart docker
//                         '''
//                     }
//             }
//         }

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

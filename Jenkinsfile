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

        stage('Install buildx') {
            steps {
                script {
                    // Install buildx
                    sh '''
                        mkdir -p ~/.docker/cli-plugins/
                        curl -L https://github.com/docker/buildx/releases/latest/download/buildx-linux-amd64 > ~/.docker/cli-plugins/docker-buildx
                        chmod +x ~/.docker/cli-plugins/docker-buildx
                    '''

                    // Verify buildx installation
                    sh 'docker buildx version'
                }
            }
        }

        stage('Setup buildx Builder') {
            steps {
                script {
                    // Create a new builder instance
                    sh 'docker buildx create --use'

                    // Inspect the builder instance
                    sh 'docker buildx inspect --bootstrap'
                }
            }
        }

        stage("Build Docker Image"){
            steps{
                sh "docker buildx build -t benidocker95/the_cat_jenkins_hw:$env.BUILD_NUMBER ."
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

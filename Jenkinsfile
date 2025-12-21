pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    environment {
        PATH = "/opt/apache-maven-3.9.11/bin:$PATH"
        DOCKER_IMAGE_NAME = 'ttrend'
        DOCKER_TAG = '2.1.3'
    }

    stages {


        // stage('build') {
        //     steps {
        //         echo "build started"
        //         sh 'mvn clean deploy'
        //         echo "build completed"
        //     }
        // }

        stage('Build & Publish JAR') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'jfrog-cred',
                    usernameVariable: 'ART_USER',
                    passwordVariable: 'ART_PASS'
                )]) {
        
                    configFileProvider([
                        configFile(
                            fileId: 'ac71b67a-7116-4485-9327-7a3e77af1dc1',
                            variable: 'MAVEN_SETTINGS'
                        )
                    ]) {
                        sh '''
                        mvn -B clean deploy \
                            -DskipTests \
                            --settings $MAVEN_SETTINGS
                        '''
                    }
                }
            }
        }


        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'fqts-sonar-scanner'
            }
            steps {
                withSonarQubeEnv('fqts-sonar-server') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                    docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} .
                    """
                }
            }
        }

        stage('Verify AWS Auth') {
            steps {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                    credentialsId: 'aws-cred']]) {
                        sh 'aws sts get-caller-identity'
                }
            }
        }        
    }
}

pipeline {
    agent {
            node {
                label 'maven'
            }
    }

environment {
    PATH = "/opt/apache-maven-3.9.11/bin:$PATH"
}

    stages {
        stage('build') {
            steps {
                echo "build started"
                sh 'mvn clean deploy'
                echo "build completed"
            }             
        }

        stage('SonarQube analysis') {
				  environment {
				  scannerHome = tool 'fqts-sonar-scanner'
                }
                    steps{
                            withSonarQubeEnv('fqts-sonar-server') { 
                            sh "${scannerHome}/bin/sonar-scanner"
                            }
                    }
            }

        stage('Publish to Artifactory') {
            steps {
                script {
                    // Artifactory integration
                    def server = Artifactory.server 'jfrog-server-url' // Change to your Artifactory server ID
                    def uploadSpec = """{
                      "files": [
                        {
                          "pattern": "target/*.jar",
                          "target": "maven-libs-release-local/"
                        }
                      ]
                    }"""
                    // Upload JAR file(s)
                    server.upload(uploadSpec)
                }
            }
        }
    }
}

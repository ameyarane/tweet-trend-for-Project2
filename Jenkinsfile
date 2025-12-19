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
            steps {
                withSonarQubeEnv('fqts-sonar-server') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage('Publish to Artifactory') {
            steps {
                rtUpload (
                    serverId: 'jfrog-server-url', // Use your Jenkins Artifactory server ID
                    spec: """{
                      "files": [
                        {
                          "pattern": "target/*.jar",
                          "target": "maven-libs-release-local/"
                        }
                      ]
                    }"""
                )
            }
        }
    }
}

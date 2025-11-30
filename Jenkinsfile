pipeline {
    agent {
            node {
                label 'maven'
            }
    }

    stages {
        stage('cloneProjectCode') {
            steps {
                git branch: 'main', url: 'https://github.com/ameyarane/tweet-trend-for-Project2.git'
            }
        }
    }
}

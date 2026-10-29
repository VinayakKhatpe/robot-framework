pipeline {
    agent any

    stages {
        stage('Setup Environment') {
            steps {
                echo 'Dependencies already installed'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'robot -d results -i smoke .'
            }
        }
    }

    post {
        always {
            robot outputPath: 'results',
                  outputFileName: 'output.xml',
                  logFileName: 'log.html',
                  reportFileName: 'report.html',
                  passThreshold: 100.0,
                  unstableThreshold: 75.0
        }
    }
}

pipeline {
    agent { label 'local-windows' }

    stages {
        stage('Setup Environment') {
            steps {
                echo 'Dependencies already installed'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'python -m robot -d results -i smoke tests/'
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

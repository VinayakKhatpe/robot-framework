pipeline {
    agent any

    stages {
        stage('Install Dependencies') {
            steps {
                bat 'pip install robotframework robotframework-browser'
                bat 'python -m Browser.entry init'
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

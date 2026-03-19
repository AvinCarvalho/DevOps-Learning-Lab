pipeline {
  agent any
  stages {
    stage('Build') {
      parallel {
        stage('Build') {
          steps {
            sh 'echo "Building project..."'
          }
        }

        stage('Test stage') {
          steps {
            sh 'echo "Testing..."'
          }
        }

      }
    }

    stage('deploy') {
      steps {
        echo 'Deployed sucessfully'
      }
    }

  }
  environment {
    Build = ''
  }
}
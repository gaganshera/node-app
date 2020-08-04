pipeline {
  agent any
  
  tools {
        nodejs "node"
  }
  options {
    timestamps()

    timeout(time: 1, unit: 'HOURS')

    buildDiscarder(logRotator(daysToKeepStr: '10', numToKeepStr: '20'))
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
        sh 'npm i'
      }
    }
    stage('Tests') {
      steps {
        sh 'npm test'
      }
    }
  }
}
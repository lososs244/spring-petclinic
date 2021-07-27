pipeline {
    agent any
    
    stages {
        stage('CHECKOUT') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/lososs244/spring-petclinic.git']]])
            }
        }
        stage('BUILD') {
            steps {
                sh "docker build -t 3.68.185.180:5000/spring-petclinic:$BUILD_NUMBER ."
            }
        }
        stage('CREATE ARTIFACT') {
            steps {
                sh "docker push 3.68.185.180:5000/spring-petclinic:$BUILD_NUMBER"
                sh "docker tag 3.68.185.180:5000/spring-petclinic:$BUILD_NUMBER 3.68.185.180:5000/spring-petclinic:latest"
                sh "docker push 3.68.185.180:5000/spring-petclinic:latest"
            }
        }
        stage('CI DEPLOY') {
            steps {
                ansiblePlaybook become: true, credentialsId: 'ssh-key', installation: 'ansible', inventory: 'ansible/hosts', playbook: 'ansible/deploy-playbook.yml'
            }
        }
        stage('POSTBUILD') {
            steps {
                sh "docker image prune -a -f"
                cleanWs()
            }
        }
    }
}

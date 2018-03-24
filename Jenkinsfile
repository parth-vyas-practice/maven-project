pipeline{
    agent{
        node{
            label 'master'
        }
    }
    stages{
        stage('build'){
            steps{
              sh '''
              mvn clean package checkstyle:checkstyle
              '''  
            }
            post {
                success {
                    archiveArtifacts '**/*.war'
                    junit '**/target/surefire-reports/*.xml'
                    checkstyle canComputeNew: false, defaultEncoding: '', healthy: '', pattern: '', unHealthy: ''
                }
            }
        }
        stage('old-app-backup'){
            steps{
                sh '''
                    cp /home/ubuntu/staging/*.war /home/ubuntu/backup-stag/
                '''
            }
        }
        stage('create-image & Deploy'){
            steps{
                sh '''
                    cp /var/lib/jenkins/workspace/maven/pipeline/webapp/target/webapp.war /home/ubuntu/staging/
                    cd /home/ubuntu/scripts/
                    sh docker.sh
                '''
            }
            post{
                failure{
                    sh '''
                        cd /home/ubuntu/scripts/
                        sh rollback.sh
                    '''
                }
            }
        }
    }
}

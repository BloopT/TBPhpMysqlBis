pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']],
                userRemoteConfigs: [[url: 'https://github.com/BloopT/TBPhpMysqlBis.git']]])           
            }
        }
        stage('Build Docker Images') {
            steps {
                sh 'docker-compose build'
            }
        }

        stage('Start Docker Compose Environment') {
            steps {
                sh 'sudo docker-compose up -d'
                sleep 60 
            }
        }

        stage('Run PHP Unit Tests') {
            steps {
                sh 'docker-compose run --rm run --rm php vendor/bin/phpunit tests/ConnexionBddTest.php'
            }
        }

        stage('Run SonarQube Analysis') {
            steps {
                withSonarQubeEnv(installationName: 'sonarqube'){
                sh './mvn clean org.sonarsource.scanner.maven:sonar-maven-pugin:39.0.2155:sonar'
                }
            }
        }

        stage('Stop Docker Compose Environment') {
            steps {
                sh 'sudo docker-compose down'
            }
        }

        /*stage('Deploy') {
            steps {
                sshagent(['deploy']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no -i X ubuntu@X "cd /home/ubuntu/projectphp && git pull origin main  && docker-compose up -d"
                    '''
                }
            }
        }*/
        /*stage('Security Scan') {
            steps {
                script {
                    def zapHome = tool 'OWASP_ZAP_HOME'
                    sh "${zapHome}/zap.sh -cmd -quickurl http:// -quickprogress -outfile report.html"
                    archiveArtifacts 'report.html'
                }
            }
        }*/
    }
}    

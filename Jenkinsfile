pipeline{
    agent any
    stages{

        stage("SCM Checkout"){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout', deleteUntrackedNestedRepositories: true]], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'trivy-pipeline', url: 'https://github.com/pancaperkasa/presentasi-cd-fail.git']]])
            }
        }

        stage("Terraform Conf Scanner "){
            steps{
                sh '''
                mkdir /var/www/html/trivy-cd-fail/pipeline${BUILD_NUMBER}/
                touch /var/www/html/trivy-cd-fail/pipeline${BUILD_NUMBER}/reportterra.html
                trivy config terraform_test/module/aws-s3-static-website-bucket/ --format template --template "@html.tpl" -o /var/www/html/trivy-cd-fail/pipeline${BUILD_NUMBER}/reportterra.html --exit-code 1 --severity HIGH,CRITICAL
                trivy config terraform_test/module/aws-s3-static-website-bucket/ --format json -o /var/www/html/trivy-cd-fail/pipeline${BUILD_NUMBER}/reportterra.json --exit-code 1 --severity HIGH,CRITICAL
                '''
            }
        }

        stage('Kube-manifest Conf Scanner') {
            steps {
                sh """
                touch /var/www/html/trivy-cd-fail/pipeline${BUILD_NUMBER}/reportkube-deploy.html
                trivy config kubernetesManifest/ --format template --template "@html.tpl" -o /var/www/html/trivy-cd-fail/pipeline${BUILD_NUMBER}/reportkube-deploy.html --exit-code 1 --severity HIGH,CRITICAL
                trivy config kubernetesManifest/ --format json -o /var/www/html/trivy-cd-fail/pipeline${BUILD_NUMBER}/reportkube-deploy.json --exit-code 1 --severity HIGH,CRITICAL
                """
            }
        }

      
    }
}

pipeline {
    agent any

    environment {
        AZURE_DEFAULT_REGION = "westeurope"
        //PATH = "/usr/local/bin/terraform"
        
    }

    stages {
        stage('Terraform Init') {
            steps {
                dir('terraform'){
                    sh "pwd"
                    sh "terraform init"
                }
            }
        }
        stage('Validazione configurazione') {
            steps {
                 dir('terraform'){
                    sh "terraform validate"
                }
            }
        }
        stage('Piano esecuzione Terraform') {
            steps {
                dir('terraform'){
                    //sh "terraform plan -var-file='terraform.tfvars'"
                    sh terraform plan -var="appId=2685d5c7-d3dc-4393-bc3c-2fc56fc19067" -var="password=Rwq8Q~dvNS6Ve5IDJfTc44z0Y0QbPl0L3W~tDdjn"
                }
            }
        }
        stage('Approvazione Piano Infrastruttura') {
            steps {
                input "Approvazione piano infrastruttura?"
            }
        }
        stage('Creazione Infrastruttura') {
            steps {
                dir('terraform'){
                    sh "terraform apply -auto-approve"
                }
            }
        }
        /*
        stage('Configurazione kubectl') {
            steps {
                sh 'aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)'
            }
        }
        stage('Verifica cluster') {
            steps {
                sh "kubectl cluster-info"
            }
        }
        
        */
        
        stage('Piano distruzione Terraform') {
            steps {
                dir('terraform'){
                    sh "terraform plan -destroy"
                }
            }
        }
        stage('Approvazione destroy Infrastruttura') {
            steps {
                input "Approvazione destroy infrastruttura?"
            }
        }
        stage('Destroy Infrastruttura') {
            steps {
                dir('terraform'){
                    sh "terraform destroy -auto-approve"
                }
            }
        }
    }
}

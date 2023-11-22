pipeline {
    agent any

    environment {
        AZURE_DEFAULT_REGION = "westeurope"
        ARM_SUBSCRIPTION_ID = credentials('System/AZURE/ARM_SUBSCRIPTION_ID')
        ARM_TENANT_ID = credentials('System/AZURE/ARM_TENANT_ID')
        ARM_CLIENT_ID = credentials('System/AZURE/ARM_CLIENT_ID')
        ARM_CLIENT_SECRET = credentials('System/AZURE/ARM_CLIENT_SECRET')
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
                    sh "terraform plan -var='appId=ARM_CLIENT_ID' -var='password=$ARM_CLIENT_SECRET'"
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

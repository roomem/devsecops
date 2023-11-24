pipeline {
    agent any

    environment {
        AZURE_DEFAULT_REGION = "westeurope"
        ARM_SUBSCRIPTION_ID = credentials('ARM_SUBSCRIPTION_ID')
        ARM_TENANT_ID = credentials('ARM_TENANT_ID')
        ARM_CLIENT_ID = credentials('ARM_CLIENT_ID')
        ARM_CLIENT_SECRET = credentials('ARM_CLIENT_SECRET')
        //PATH = "/usr/local/bin/terraform"

        AZURE_CREDENTIALS = credentials('certimetergroup_creds')
        AZURE_USERNAME = sh(script: "echo '\${AZURE_CREDENTIALS_USR}'", returnStdout: true).trim()
        AZURE_PASSWORD = sh(script: "echo '\${AZURE_CREDENTIALS_PSW}'", returnStdout: true).trim()

    }

    stages {
        stage('Azure Login') {
            steps {
                script {
                    sh "az login --username ${AZURE_USERNAME} --password ${AZURE_PASSWORD}"
                }
            }
        }

        stage('Terraform Import') {
            steps {
                //withCredentials([azureServicePrincipal('marco-azure-cred')]) {

                
                //}
                dir('terraform'){
                    sh "terraform import -var 'appId=${ARM_CLIENT_ID}' -var 'password=${ARM_CLIENT_SECRET}' 'azurerm_resource_group.default' '/subscriptions/f89882ab-4505-45fb-b088-f9c3f90f834e/resourceGroups/BU-MT'" 

                }
            }
        }


        stage('Terraform Init') {
            steps {
                dir('terraform'){
                    //sh "az login --username $ --password ${ARM_CLIENT_SECRET} --tenant ${ARM_TENANT_ID}"
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
                    //withCredentials([azureServicePrincipal('marco-azure-cred')]) {
                        //sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                        sh "terraform plan -var='appId=${ARM_CLIENT_ID}' -var='password=${ARM_CLIENT_SECRET}'"
                    //}
                   // sh "terraform plan -var='appId=$ARM_CLIENT_ID' -var='password=$ARM_CLIENT_SECRET'"
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
                    //withCredentials([azureServicePrincipal('marco-azure-cred')]) {
                        sh "terraform apply -var='appId=${ARM_CLIENT_ID}' -var='password=${ARM_CLIENT_SECRET}' -auto-approve"
                    //}
                    //sh "terraform apply -var='appId=$ARM_CLIENT_ID' -var='password=$ARM_CLIENT_SECRET' -auto-approve"
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

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
                    echo "${env.WORKSPACE}"
                    sh "az provider list --output table"
                }
            }
        }
/*
        stage('Terraform Remove State') {
            steps {
                dir('terraform'){
                    sh "rm terraform.tfstate"
                    sh "rm terraform.tfstate.backup"
                }
            }
        }

        stage('Terraform Import Existing Resources') {
            steps {
                dir('terraform'){
                    sh "terraform import azurerm_resource_group.BU-MT '/subscriptions/${ARM_SUBSCRIPTION_ID}/resourceGroups/BU-MT'" 
                    sh "terraform import azurerm_kubernetes_cluster.sweeping-leopard-cluster '/subscriptions/${ARM_SUBSCRIPTION_ID}/resourcegroups/BU-MT/providers/Microsoft.ContainerService/managedClusters/sweeping-leopard-aks'"
                }
            }
        }
*/
        
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
        stage('Plan') {
            steps {
                //withCredentials([usernamePassword(credentialsId: 'certimetergroup_cred', usernameVariable: 'AZURE_USERNAME', passwordVariable: 'AZURE_PASSWORD')]) {
                    dir('terraform'){
                    withCredentials([usernamePassword(credentialsId: 'AppIdPassword', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                        sh 'echo $USERNAME'
                        sh 'echo $PASSWORD'
                        sh "terraform plan"
                    }
                   // sh "terraform plan -var='appId=$ARM_CLIENT_ID' -var='password=$ARM_CLIENT_SECRET'"
                //}
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
                        sh "terraform apply -target=resou.resource_name"

                    //}
                    //sh "terraform apply -var='appId=$ARM_CLIENT_ID' -var='password=$ARM_CLIENT_SECRET' -auto-approve"
                }
            }
        }
        
        stage('Configurazione kubectl') {
            steps {
                //sh 'aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)'
                sh 'az aks get-credentials --name sweeping-leopard-aks --resource-group BU-MT'
            }
        }
        stage('Verifica cluster') {
            steps {
                sh "kubectl cluster-info"
            }
        }
        
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

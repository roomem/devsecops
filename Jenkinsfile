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
        stage("copy tfstate"){
            steps {
                    dir('terraform'){
                        my_string='{
  "version": 4,
  "terraform_version": "1.6.4",
  "serial": 7,
  "lineage": "4c13add9-7923-4d9d-4295-e0c4851a54ba",
  "outputs": {
    "kubernetes_cluster_name": {
      "value": "sweeping-leopard-aks",
      "type": "string"
    },
    "resource_group_name": {
      "value": "BU-MT",
      "type": "string"
    }
  },
  "resources": [
    {
      "mode": "managed",
      "type": "azurerm_kubernetes_cluster",
      "name": "default",
      "provider": "provider[\"registry.terraform.io/hashicorp/azurerm\"]",
      "instances": [
        {
          "schema_version": 2,
          "attributes": {
            "aci_connector_linux": [],
            "api_server_access_profile": [],
            "api_server_authorized_ip_ranges": [],
            "auto_scaler_profile": [],
            "automatic_channel_upgrade": "",
            "azure_active_directory_role_based_access_control": [],
            "azure_policy_enabled": null,
            "confidential_computing": [],
            "custom_ca_trust_certificates_base64": null,
            "default_node_pool": [
              {
                "capacity_reservation_group_id": "",
                "custom_ca_trust_enabled": false,
                "enable_auto_scaling": false,
                "enable_host_encryption": false,
                "enable_node_public_ip": false,
                "fips_enabled": false,
                "host_group_id": "",
                "kubelet_config": [],
                "kubelet_disk_type": "OS",
                "linux_os_config": [],
                "max_count": 0,
                "max_pods": 110,
                "message_of_the_day": "",
                "min_count": 0,
                "name": "default",
                "node_count": 2,
                "node_labels": {},
                "node_network_profile": [],
                "node_public_ip_prefix_id": "",
                "node_taints": null,
                "only_critical_addons_enabled": false,
                "orchestrator_version": "1.26.3",
                "os_disk_size_gb": 30,
                "os_disk_type": "Managed",
                "os_sku": "Ubuntu",
                "pod_subnet_id": "",
                "proximity_placement_group_id": "",
                "scale_down_mode": "Delete",
                "tags": null,
                "temporary_name_for_rotation": "",
                "type": "VirtualMachineScaleSets",
                "ultra_ssd_enabled": false,
                "upgrade_settings": [],
                "vm_size": "Standard_D2_v2",
                "vnet_subnet_id": "",
                "workload_runtime": "",
                "zones": null
              }
            ],
            "disk_encryption_set_id": "",
            "dns_prefix": "sweeping-leopard-k8s",
            "dns_prefix_private_cluster": "",
            "edge_zone": "",
            "enable_pod_security_policy": false,
            "fqdn": "sweeping-leopard-k8s-na7oxjtf.hcp.westeurope.azmk8s.io",
            "http_application_routing_enabled": null,
            "http_application_routing_zone_name": null,
            "http_proxy_config": [],
            "id": "/subscriptions/f89882ab-4505-45fb-b088-f9c3f90f834e/resourceGroups/BU-MT/providers/Microsoft.ContainerService/managedClusters/sweeping-leopard-aks",
            "identity": [
              {
                "identity_ids": [
                  "/subscriptions/f89882ab-4505-45fb-b088-f9c3f90f834e/resourceGroups/BU-MT/providers/Microsoft.ManagedIdentity/userAssignedIdentities/romegioli"
                ],
                "principal_id": "",
                "tenant_id": "",
                "type": "UserAssigned"
              }
            ],
            "image_cleaner_enabled": false,
            "image_cleaner_interval_hours": 48,
            "ingress_application_gateway": [],
            "key_management_service": [],
            "key_vault_secrets_provider": [],
            "kube_admin_config": [],
            "kube_admin_config_raw": "",
            "kube_config": [
              {
                "client_certificate": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZIVENDQXdXZ0F3SUJBZ0lRUHo1bzhlWmRGdXZYRW1uTHZ4UzFSekFOQmdrcWhraUc5dzBCQVFzRkFEQU4KTVFzd0NRWURWUVFERXdKallUQWVGdzB5TXpFeE1qY3hNalV5TXpOYUZ3MHlOVEV4TWpjeE16QXlNek5hTURBeApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1SVXdFd1lEVlFRREV3eHRZWE4wWlhKamJHbGxiblF3CmdnSWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUNEd0F3Z2dJS0FvSUNBUURYeDFHRGNJeU4wS05yVWY1VGQvL0EKSkg0K1gxYXpTbStYeWdSNnJGR1RSYkhMdmI4Z3BsNXI1TWNZay9saGc1d2FGRklGQ3BYMVlTa0g1aXlxNzE3MApXNDhtSFlOWkxrUkd1MHJIbnBkOGEvKzcvUDFWdlY0Q2hIVzRibTc5c1NiVlJMeEN2c2JRZXlLbC9SOVBodmZTCkVKRkxlNEU0cVhVTVgvRlF0dlZuemhPMU5OUTc4WEQyZnNUU2hBMzhaQ1ZoS2JONE81a3ZweFZoSzhQYmV3OGsKaGFNbWFrekVZUjYvK0J3WmMyRlJiMkhGNEtRRnZCTklOUUlJSytWcGFHaE1zVDk3S1l2SWVHMWZ5OFBZQ0drRQprejdvWTJyVyt2L3FUVEV2RjNSM2RVV0d5WTJ2ZlBmYTZDYmVXbCt1QWJBL3lXOGhpN0VsU0RlLzBicUQyM3BlCmVmQWswTGRPMzBQT3NXdEFYVW8xd3JQa2ZOS0dFMEZqTmNNTDJqZ0JBRXhsVXlzR1FCVXVQNzRBb1hRM0FHS2wKY1IwcVNXQzVhc3VWWlVmUEFJNFdhM0JsZ3MrVEt1K2loQTJhQkpRd2JuV2JBbnRCS0kzVVd0VjJCbHg0Y2orcwoycE5uZnMzeTFQc3ZRSHhCS3hjYlB2M1FCVUhQNjhNeHRyaTVXZ0xyWVJac3dwL29xdThmeWI5eTJtejZ1clg4CnlzaUtxMGlvcE9xbnNwVlBiZjE5alRHWWVUZlBvT2tZTXVBeThCclU0UDNjaHNSQURLRDdxMHJqMW5kZ3lnYmUKRWJpa29zbDJNcytCQnUzdHZTWXdGR2NZeUNzVnV4V1lETFlBeHl3VHRZcTJWV1NpOWJlSlRWZ01UYlQ2c0d1SAppVFJUYkYrRWo2dlFYV05wQW9FK25RSURBUUFCbzFZd1ZEQU9CZ05WSFE4QkFmOEVCQU1DQmFBd0V3WURWUjBsCkJBd3dDZ1lJS3dZQkJRVUhBd0l3REFZRFZSMFRBUUgvQkFJd0FEQWZCZ05WSFNNRUdEQVdnQlNrQ3ZRdzlXM0oKczZnZUZFL0o2a0F4SXRrUFh6QU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FnRUFoaFY0L3BGUUZPa0s2c2dBOUFWWApNMlFDT0xnME9HVFNSV2NsR0R6ck5pekVKcWg4M3hhd1l1RjByVXNGVW9NUGJkSWJFaTRoK1lDVGlOdnpQQS9kCjNFenVZYkorVUs0bWU5S2J4VEdyQ3doL1BJQ3JwTHVuV2NqZDhza0NKM3BpT3Jtak5CcEhobjdkcTQ2alNvWU8KWDNZWkVZc2ZqcGJDd2RXeU5ZRExZYkpSZk5ZQWF5RVRzamlZWE01LytRa1cyK2dFTmRsYU1LTWJQLzh3YXVPNApNWm9WTFdubnVhY2YxNnFPVFJ5VzJzQjNjUDhDeGdsNlVHM1JhUEFwL0o2clE0am5BWkk3WDNSYm9sdG1La2RMClB5Z1A0VUdqZ3VrdEk1dnBLc1FWMTlIcUREc1lwMzhFYXE1K2pxZUs5U3FuL1VORHVBa3NPblRXbVdndUtuVU8KNGcwSWk0RzRLMXhHUG9abTRaVEFITVBOd1R6ZS8xWGt2NnVzTjYvTzZSK1BPTmFhWkNFZ0dUNlBJWHRBTTZCTwpBeklZc1RyMFgvK3ZKYXdpb0s0R1E4aFM4TzRuOStyVURTUElHcmZacmZEdkh3WDZJMFBXU3h2MitxNXFxUmhWCjBSZk5FWERKV05XK05WNUlqdTUzWnorcDNmRG5IdmNsbS9UajVNVmlLL1JaWHJadEZCcDJpRHBoODlkQnJWTmsKRVo2TlRWN25vNTc4Q05GTmRXOXlnTzZSdmV6NTl6WlU4cmlvUlJOTm5ENkJzQ3VCZG12ZXZSVW5FQ2QvQ1p5eQpvOG85cXVRSCtzNmF1NzVrdmJRSERiKzJWQVNhS09KMExOeCtJL1doZWxTc1BMNmFnUGl3SFFzcFROREkyNlVqCjBkdzkyRjFnNFd2V1BrbmpCL3l2NEFJPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==",
                "client_key": "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlKS1FJQkFBS0NBZ0VBMThkUmczQ01qZENqYTFIK1UzZi93Q1IrUGw5V3MwcHZsOG9FZXF4UmswV3h5NzIvCklLWmVhK1RIR0pQNVlZT2NHaFJTQlFxVjlXRXBCK1lzcXU5ZTlGdVBKaDJEV1M1RVJydEt4NTZYZkd2L3UvejkKVmIxZUFvUjF1RzV1L2JFbTFVUzhRcjdHMEhzaXBmMGZUNGIzMGhDUlMzdUJPS2wxREYveFVMYjFaODRUdFRUVQpPL0Z3OW43RTBvUU4vR1FsWVNtemVEdVpMNmNWWVN2RDIzc1BKSVdqSm1wTXhHRWV2L2djR1hOaFVXOWh4ZUNrCkJid1RTRFVDQ0N2bGFXaG9UTEUvZXltTHlIaHRYOHZEMkFocEJKTSs2R05xMXZyLzZrMHhMeGQwZDNWRmhzbU4KcjN6MzJ1Z20zbHBmcmdHd1A4bHZJWXV4SlVnM3Y5RzZnOXQ2WG5ud0pOQzNUdDlEenJGclFGMUtOY0t6NUh6UwpoaE5CWXpYREM5bzRBUUJNWlZNckJrQVZMaisrQUtGME53QmlwWEVkS2tsZ3VXckxsV1ZIendDT0ZtdHdaWUxQCmt5cnZvb1FObWdTVU1HNTFtd0o3UVNpTjFGclZkZ1pjZUhJL3JOcVRaMzdOOHRUN0wwQjhRU3NYR3o3OTBBVkIKeit2RE1iYTR1Vm9DNjJFV2JNS2Y2S3J2SDhtL2N0cHMrcnExL01ySWlxdElxS1RxcDdLVlQyMzlmWTB4bUhrMwp6NkRwR0RMZ012QWExT0Q5M0liRVFBeWcrNnRLNDlaM1lNb0czaEc0cEtMSmRqTFBnUWJ0N2IwbU1CUm5HTWdyCkZic1ZtQXkyQU1jc0U3V0t0bFZrb3ZXM2lVMVlERTIwK3JCcmg0azBVMnhmaEkrcjBGMWphUUtCUHAwQ0F3RUEKQVFLQ0FnRUFnOTY0SGxBR1ZoVVFDbUtOdjQweXE4YWhzSlNyYzk4bDIrb0dXc0k5Q0hncmRJeDk1Z0pHNmtGaQp1ODZUTmRrczZYTkp2UEwvT25zcWpEMUxSeHdMTitOTTFNcHNuMi83SWc4TVlIcTNzYjUvQi9CUkVya3NYdlY4CnpENFJidEY1SGhWbnlKSzNCbXA2Zmw3M1o2N2dmV3pLbndyWHFqMUYzMDR6T0ZUWUhaeC94dHFHYWl2Z0VZVGYKM0pmL3hDT2dCSVZydlNzUEwyUTVXSzFhZ1NQdjJTNGl5ek5qdnhCcnJuNS9EYjdKMXU3dkhmTnZ5bUZxbDFKdAo3M2lFTjZzck10T1FMRUR6d0l4NHEzYm9OWHJPVTVGNWZLUmxnd1RhcWVLTEVIQ1JLUUJ1Z1RWa2RiODE2bjYrCllsMXc0L0w4Tjc5dlAxMFQ0ZWtFeVNIdmp1M3ZGZlpxMmJ6SFVMUTR2NWFoZm9wTnh0U002bUtNaGQ3RXpMaG8KQWFMZ3BNSVlSMXF1UU1wSUIxVG9PbjJGOE1EM3JhaDFnSTdyeEVmb2lrOUw5enlQRzZhTmxPTTN6S1VEd2JkTgpzM0t4b3pLOUFHRzNtczY4R3NjWTFxSFNLR0Y2WUlXTTdFZEp6MlNTWGFtZTF4TW50RDQxK00zakhLd0RKQ0FpCm1LS0xVNGdRUU5FTjlUcitSTWk2aXViVEUxdmlOdkJtOFg5N3VBQzZXa2tRaWwxUnFNSlN0ZXhVNEpkMTZZSEEKMTN4WS9LbExMTStNTUtGdXp3ZHFrd284a0RuRmxHWVM2aWtFL0VlYXpIdzJTbmdsaWdNcFNtQUFWdkkwZWptRwpwS1RDSWpzMDlRQjIyVzR1ZjFoQmNNdnZGN1NQVTFmV1QxRHluaEtyRjVrd2ZZOG16TEVDZ2dFQkFOL3JFeWh1CmNSS0FOelZXSFA2MytyOVd3Tk9Xbjhab3EwRXI3elZEOVBmaHZCdFJZTWNFWFp2Z0x6QXRDUVIreDFOWnMwUkwKZ1d2S2M5Snpvd21KWlBsUCsveW5ab1h0WEQ0enVqVy8zREtHSFRBZk1rVVlvL1NIdFE1NVZSSkszdmpNcU1iVgp4LzAxMkQvdnFxV1V6Tm82Z2JRRTR0Z2pBQ2tyR2NSZmsxKzlDa0t0c3ZpblNKcjBvK243dW9JQ2hsK1A1aFVrCm9DS0tqQzN4aU9hM3F0ekpnT3ErQ3l6QUdGazJrMTllV1M1WWptQ0hua1Y1ckxaV3cyNmVyYVNiMXBwWk05RmsKbEZYa21uMWErQTRBSFBSUExNRmlaaW5WTHREVGFtMXhESGFpaEFXMnl2aEJtRUJodWJGNG43K0crLzcxZWNTTApqK1dpWmZraXhtYmlwdGNDZ2dFQkFQYXhzZHh2SVdBeXdkcFFrc3BvNkVvdmRWTWgwWjhHMFpkWCtYaTcyb1NqCmtEaDBHVHhkYmFPOXovbFhjM3M4UXI4RXV2aytUME9SdVBzZ2E5UE1SQllOaFozbmNMSzF5VysxSkkzdkhHVFgKVDVydVVuOWxlejBYc2REWGZjRnpSUzFLbE1NZzlHdnJSRU1GQU1PazRGZU9haUtITG1FNDJoRnZTOWlaQUdSUgp5U3Jrc2lZNnBrZXNTTFI1eHJXVnFNVEZCSkw4L3Y3ZTJTYUpOeHpRQmcyR0xybmxTNWoxMVlvVmRMdkRHVG5FCllZbUJsWmtJNFlyZDZ6OUdTZXlMeXJqTmMvYU1URVNmVEk0YmNZb2d4TUkrQ0Q1emMvUjYycHdXV0p4UWNtbTgKalgreHhOV0FGUFJQa2MxejFtRXBvSWtpdE9VempsMEZzYVQySGJiUis2c0NnZ0VBVDFGbkhPaGFWM0pobkJ3Zgo4ejdhck5LZlJaUlNqcWJmR3h2a0JWdElPRktYSHBvcURQV0g3MEp2bE1Jdk1vOXlMaDFWT2prQTVGejN3REhFCkxBbW1ZZ1lxUGVwU2o5aHYxM3pkVmxMYlBtNXhnbTFha2sxVExyaXZzeXZacmJ3bDFiNHhmeFdWWFNXb3I2VkgKTHBaU0ptK1pLRnFldkc5UmpFTy9RZWVWUGRHcUE4cWgzaURyd0RBdXJDREdoVzA5aWpaZ0MxZEkvbE5UcXFhbgpsd3F5bExrd1dIYnZZRysvY0VLNzI0bUJUOENBMXNMVGxzcXVHbjBMaDNEZ0U3SThSN3FYZDNJSWRaQ2dCUTJuClZ0WkZhMmxzY2loWUJqT0UvT1lYQ2lPRWhiVzF6SXhldzZnQXRiV29ZS3hZOGpCdnJYWHBKMjFFa05TQkNNcC8KdTB4SVN3S0NBUUE2K3k4d0tlM0w1emJMOEptNEJTOE1sWjR5ZXhKNE9CUWlZQ2xJUVhtMFhycmJsSDU0SFVwYQpiTVp0c2dmdFBmSWpZNGtra0U0NU5IMEtwYXpDSGNObGxtUU01Y25mSUhHQjRNaFZtd2FwNFlTcDRUTWVQSEFqCm9pZWthL0VvTUZ3b3dQMGlUaDNDTTZURmRVdkNld2djUnZOL1A5eko1K0xUYWsyekFwbkNZbjk3WHVSdEdYYXEKQ2puejFHMjYrb1k0VFhhVGdpT2hZangrNXkyakdPVnBsRnhWbThuZ1QxNTN2anVEck5pNkpBYkI3cGFLMlVHNwpodVY0NG1CSVN2LzBBVU1wZmsrNTFIQmtSWkYyMmZEUkZDMjZhTFlmak1QNXI2b043WG45WjlSWTVITFFMT2hWCnBUU1I3NUVnOStmbkFjSklUblJLTDFOU3dubEdQWnd6QW9JQkFRQ3FxTTFqWUpGWms3RXpyMGFsakJKaHAxNEoKMDU1U3BqdGZKSXNrQmdneG1FUVFpVm9SYlhCeFNJVGpQM0kzajdvYnVpQUt1QmZwWFpaQjczTEVacHNud2QxKwpiUjBvU1JYSXZNNlpSQk1md1dZN0Y0QjV3QnBVaTVRcW9iaW5zVkJMd0dLV0tvS2xNVXdUYUdFekhsSDJYS0JrCmFPdUpQcmMrcFVGK0VGVEEvUTVJSTVHSXRvcXNHendNWGEyaFY4UFhIN095SkF1OW1taXcwOEhoN0UvVDhOM1YKaGQ1Wk9SRVZyWnE4eGpEelJPV3c1cjdzQXZZcFE4SFZjMkJCa1BENEplY3o2QzlHSGFsdEpFNXhXZ2tQVXJCNAowb09zcm4vMEYzNEZEL24zRExIbDluREd1Z3RuenlKWTZTT1pkVTFGMngvMC9aZWFlZC9GdFk2b0Y1Y2gKLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0K",
                "cluster_ca_certificate": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUU2RENDQXRDZ0F3SUJBZ0lRVEsvQTI1RVR3SlhFSHBobmJ4ZXJKakFOQmdrcWhraUc5dzBCQVFzRkFEQU4KTVFzd0NRWURWUVFERXdKallUQWdGdzB5TXpFeE1qY3hNalV5TXpOYUdBOHlNRFV6TVRFeU56RXpNREl6TTFvdwpEVEVMTUFrR0ExVUVBeE1DWTJFd2dnSWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUNEd0F3Z2dJS0FvSUNBUUM1ClM5Z0NYWVBjM0xzUFEyRE11ZGJ0R2paY0NkRHoydFo1Y0VudTZ0aDZSR2NQRVh1OWVJVjZZK3F0SWVzYmcwc2QKNEFoUkZXZ3U1cFVRVUFHWWRHenBsekdpTVYvcTd4SEx1MTUveE9RaDRYMGVRbDJWTi8yK2ttbHFuSnY2MytIawo5aWJIcXh6UnFNRTZzM3AzNEtJeWNZM3Z5ZUxxYWRGc1VRWkZTR09FNi85Mk53MUlyOFVGS2cyMitpUk10aS9LCkNOV1F2d250RTFoVEhSeEhZS1lWQjRNa3k0a1NZRmVJWUl0TDlYa2UvSGlYdjltaWp1bDhaTjdxZ0VyYjlhU2gKV2JpaUZ1NnN0RGtIT0R6SEhxRzFTVVFSSXdnWGhQWEp0Wllmc1Y1ZWFWSnl5eCtib1Qybm1WT0k3bXFNdjhnQwoyUGxCZ0lFSStML2piSXFLcHNHZ3Y2eG5mazNrbk1Kald0aWNQYTRKKzloTGRlMVRXS2dOSzYxd2NQaTdhelNiCjVUZ2VjS0E2TUNtdExlOGZWWmxFeEs2T0JsRk9VNE0raGN1cXUyN2FwVWZPdjU3WVY4SFUwNC92OHpQcHQ5d2sKclRMMGwwdW1OelJ0T1N1bkpDempQcmFFNGZwTmE2MXRkOUF3VzdrSkFhSkpMMGowcDNvc3YySlM2U0VoVTZabQpwaVJBaC9BaDg3Zi8xZFJ2Nk95QWNBVzZYQ1B1STcwU2xxYzZnRFJsTWtjUUdUSzJWUHN6eVFmQVgzd21QL2hHCndodzNiSGFSMCszUWpHWExHNEUvUm1ob3ZsdUt1UitOMU1mekZkTW9Bc2Qvb1NEYU53MmtNOGkvS3NFYTk2WDIKNGtZbWdSKzVIdC92Tnp1MjdFNjl3RTE4bldoK3VXL3h6UVlvS1hYYW13SURBUUFCbzBJd1FEQU9CZ05WSFE4QgpBZjhFQkFNQ0FxUXdEd1lEVlIwVEFRSC9CQVV3QXdFQi96QWRCZ05WSFE0RUZnUVVwQXIwTVBWdHliT29IaFJQCnllcEFNU0xaRDE4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dJQkFCZk1uTEhiUS8yckVtWVpSdHZQdEVBNmVCRnIKbmRQblB0ZVNwSmUrdnBqN2FPWXpnRUlaZGZFSU84ZGRMQXF0Q2ZOQmViTTF5Q2JyRlBtcnA5NzhCc0hDSmE4ZQpJaXBpVGNIQ3dXdXM3L3hkazRJRDVQanppeEpySTR2MzV2djQ0RUpIYVpxakZ4SS9ZeHMyK1RiMlI3dUUwNU1rClViZGNwNkJEbGdlMFNuY3Nlem53VEhJOE1DeVNZcVZ6WVpxNUQ0VDRQeG0zOHJZaTlVZ292UHBFaEVDN0RGT2EKTGI3ZHNDSUhhR0grdFFJN2E2MmlkaGUzT25TVUI0SXV1SUI4b0NUbEwvRWVOelJyRUNyckp0R3ZiYWtjZEF0dwpzejFpL0xkcmlJRFF2eFIxckJMZ1FsNnRNSVV6OFY2a0dkeDRGMWd4c0Jxa1pOejRlYUlrbjFqYzNDK24yeXVsCnFPcGl1eEZhNEcxd0lpaDF1UnRMSGRZYnBEeGZFVlBCSk5Mc1BYWkFuTmtPTzJEbmlERmNha1Z4SDF5NEtFMk4KVzZvUzZsNDhZS3hiQzJKb0Vpc01LQnNsOTUvN1orRnBucFZpS1VxeGRUVmVmb1BJR20vVThFNXVUQ3F6NDBDQwpkeEU4WXVXRjk2cTkzMDZ5T2ljdGlNTURzTDhmOHVVaHo2Y0RLd3pMMXljT0hDd1lXZVBFWHJjNk1MZW9SNXlyCnJIVXRleXVRY2tONk9kc0JBK1JPRURoTWtXYTlCbnJLYzBud3JLdFdCS3BIVGVMNlBDdXJIY0cwUlcyQkxhM2IKUFIzSlcrM2UxWGNjWkg2VmFSYkRWWG8yMEJBMjBPamZ1emxUOXBGUWRBOEZJY1haZXEyejVJRDJ1bTFWMTVBTApzQXRxV24ranpMZ0tTN216Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K",
                "host": "https://sweeping-leopard-k8s-na7oxjtf.hcp.westeurope.azmk8s.io:443",
                "password": "fkzjjo4hwp5yn8fe1v9hzl9iinfqv17bljq4sh2s3ug03bk225od2l51d14sov1k0d37zho7dzdeztocbfmxct8z11kli3rp8rhvmrhz52knp4hsu3wokp1pndcwyuhh",
                "username": "clusterUser_BU-MT_sweeping-leopard-aks"
              }
            ],
            "kube_config_raw": "apiVersion: v1\nclusters:\n- cluster:\n    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUU2RENDQXRDZ0F3SUJBZ0lRVEsvQTI1RVR3SlhFSHBobmJ4ZXJKakFOQmdrcWhraUc5dzBCQVFzRkFEQU4KTVFzd0NRWURWUVFERXdKallUQWdGdzB5TXpFeE1qY3hNalV5TXpOYUdBOHlNRFV6TVRFeU56RXpNREl6TTFvdwpEVEVMTUFrR0ExVUVBeE1DWTJFd2dnSWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUNEd0F3Z2dJS0FvSUNBUUM1ClM5Z0NYWVBjM0xzUFEyRE11ZGJ0R2paY0NkRHoydFo1Y0VudTZ0aDZSR2NQRVh1OWVJVjZZK3F0SWVzYmcwc2QKNEFoUkZXZ3U1cFVRVUFHWWRHenBsekdpTVYvcTd4SEx1MTUveE9RaDRYMGVRbDJWTi8yK2ttbHFuSnY2MytIawo5aWJIcXh6UnFNRTZzM3AzNEtJeWNZM3Z5ZUxxYWRGc1VRWkZTR09FNi85Mk53MUlyOFVGS2cyMitpUk10aS9LCkNOV1F2d250RTFoVEhSeEhZS1lWQjRNa3k0a1NZRmVJWUl0TDlYa2UvSGlYdjltaWp1bDhaTjdxZ0VyYjlhU2gKV2JpaUZ1NnN0RGtIT0R6SEhxRzFTVVFSSXdnWGhQWEp0Wllmc1Y1ZWFWSnl5eCtib1Qybm1WT0k3bXFNdjhnQwoyUGxCZ0lFSStML2piSXFLcHNHZ3Y2eG5mazNrbk1Kald0aWNQYTRKKzloTGRlMVRXS2dOSzYxd2NQaTdhelNiCjVUZ2VjS0E2TUNtdExlOGZWWmxFeEs2T0JsRk9VNE0raGN1cXUyN2FwVWZPdjU3WVY4SFUwNC92OHpQcHQ5d2sKclRMMGwwdW1OelJ0T1N1bkpDempQcmFFNGZwTmE2MXRkOUF3VzdrSkFhSkpMMGowcDNvc3YySlM2U0VoVTZabQpwaVJBaC9BaDg3Zi8xZFJ2Nk95QWNBVzZYQ1B1STcwU2xxYzZnRFJsTWtjUUdUSzJWUHN6eVFmQVgzd21QL2hHCndodzNiSGFSMCszUWpHWExHNEUvUm1ob3ZsdUt1UitOMU1mekZkTW9Bc2Qvb1NEYU53MmtNOGkvS3NFYTk2WDIKNGtZbWdSKzVIdC92Tnp1MjdFNjl3RTE4bldoK3VXL3h6UVlvS1hYYW13SURBUUFCbzBJd1FEQU9CZ05WSFE4QgpBZjhFQkFNQ0FxUXdEd1lEVlIwVEFRSC9CQVV3QXdFQi96QWRCZ05WSFE0RUZnUVVwQXIwTVBWdHliT29IaFJQCnllcEFNU0xaRDE4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dJQkFCZk1uTEhiUS8yckVtWVpSdHZQdEVBNmVCRnIKbmRQblB0ZVNwSmUrdnBqN2FPWXpnRUlaZGZFSU84ZGRMQXF0Q2ZOQmViTTF5Q2JyRlBtcnA5NzhCc0hDSmE4ZQpJaXBpVGNIQ3dXdXM3L3hkazRJRDVQanppeEpySTR2MzV2djQ0RUpIYVpxakZ4SS9ZeHMyK1RiMlI3dUUwNU1rClViZGNwNkJEbGdlMFNuY3Nlem53VEhJOE1DeVNZcVZ6WVpxNUQ0VDRQeG0zOHJZaTlVZ292UHBFaEVDN0RGT2EKTGI3ZHNDSUhhR0grdFFJN2E2MmlkaGUzT25TVUI0SXV1SUI4b0NUbEwvRWVOelJyRUNyckp0R3ZiYWtjZEF0dwpzejFpL0xkcmlJRFF2eFIxckJMZ1FsNnRNSVV6OFY2a0dkeDRGMWd4c0Jxa1pOejRlYUlrbjFqYzNDK24yeXVsCnFPcGl1eEZhNEcxd0lpaDF1UnRMSGRZYnBEeGZFVlBCSk5Mc1BYWkFuTmtPTzJEbmlERmNha1Z4SDF5NEtFMk4KVzZvUzZsNDhZS3hiQzJKb0Vpc01LQnNsOTUvN1orRnBucFZpS1VxeGRUVmVmb1BJR20vVThFNXVUQ3F6NDBDQwpkeEU4WXVXRjk2cTkzMDZ5T2ljdGlNTURzTDhmOHVVaHo2Y0RLd3pMMXljT0hDd1lXZVBFWHJjNk1MZW9SNXlyCnJIVXRleXVRY2tONk9kc0JBK1JPRURoTWtXYTlCbnJLYzBud3JLdFdCS3BIVGVMNlBDdXJIY0cwUlcyQkxhM2IKUFIzSlcrM2UxWGNjWkg2VmFSYkRWWG8yMEJBMjBPamZ1emxUOXBGUWRBOEZJY1haZXEyejVJRDJ1bTFWMTVBTApzQXRxV24ranpMZ0tTN216Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K\n    server: https://sweeping-leopard-k8s-na7oxjtf.hcp.westeurope.azmk8s.io:443\n  name: sweeping-leopard-aks\ncontexts:\n- context:\n    cluster: sweeping-leopard-aks\n    user: clusterUser_BU-MT_sweeping-leopard-aks\n  name: sweeping-leopard-aks\ncurrent-context: sweeping-leopard-aks\nkind: Config\npreferences: {}\nusers:\n- name: clusterUser_BU-MT_sweeping-leopard-aks\n  user:\n    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZIVENDQXdXZ0F3SUJBZ0lRUHo1bzhlWmRGdXZYRW1uTHZ4UzFSekFOQmdrcWhraUc5dzBCQVFzRkFEQU4KTVFzd0NRWURWUVFERXdKallUQWVGdzB5TXpFeE1qY3hNalV5TXpOYUZ3MHlOVEV4TWpjeE16QXlNek5hTURBeApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1SVXdFd1lEVlFRREV3eHRZWE4wWlhKamJHbGxiblF3CmdnSWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUNEd0F3Z2dJS0FvSUNBUURYeDFHRGNJeU4wS05yVWY1VGQvL0EKSkg0K1gxYXpTbStYeWdSNnJGR1RSYkhMdmI4Z3BsNXI1TWNZay9saGc1d2FGRklGQ3BYMVlTa0g1aXlxNzE3MApXNDhtSFlOWkxrUkd1MHJIbnBkOGEvKzcvUDFWdlY0Q2hIVzRibTc5c1NiVlJMeEN2c2JRZXlLbC9SOVBodmZTCkVKRkxlNEU0cVhVTVgvRlF0dlZuemhPMU5OUTc4WEQyZnNUU2hBMzhaQ1ZoS2JONE81a3ZweFZoSzhQYmV3OGsKaGFNbWFrekVZUjYvK0J3WmMyRlJiMkhGNEtRRnZCTklOUUlJSytWcGFHaE1zVDk3S1l2SWVHMWZ5OFBZQ0drRQprejdvWTJyVyt2L3FUVEV2RjNSM2RVV0d5WTJ2ZlBmYTZDYmVXbCt1QWJBL3lXOGhpN0VsU0RlLzBicUQyM3BlCmVmQWswTGRPMzBQT3NXdEFYVW8xd3JQa2ZOS0dFMEZqTmNNTDJqZ0JBRXhsVXlzR1FCVXVQNzRBb1hRM0FHS2wKY1IwcVNXQzVhc3VWWlVmUEFJNFdhM0JsZ3MrVEt1K2loQTJhQkpRd2JuV2JBbnRCS0kzVVd0VjJCbHg0Y2orcwoycE5uZnMzeTFQc3ZRSHhCS3hjYlB2M1FCVUhQNjhNeHRyaTVXZ0xyWVJac3dwL29xdThmeWI5eTJtejZ1clg4CnlzaUtxMGlvcE9xbnNwVlBiZjE5alRHWWVUZlBvT2tZTXVBeThCclU0UDNjaHNSQURLRDdxMHJqMW5kZ3lnYmUKRWJpa29zbDJNcytCQnUzdHZTWXdGR2NZeUNzVnV4V1lETFlBeHl3VHRZcTJWV1NpOWJlSlRWZ01UYlQ2c0d1SAppVFJUYkYrRWo2dlFYV05wQW9FK25RSURBUUFCbzFZd1ZEQU9CZ05WSFE4QkFmOEVCQU1DQmFBd0V3WURWUjBsCkJBd3dDZ1lJS3dZQkJRVUhBd0l3REFZRFZSMFRBUUgvQkFJd0FEQWZCZ05WSFNNRUdEQVdnQlNrQ3ZRdzlXM0oKczZnZUZFL0o2a0F4SXRrUFh6QU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FnRUFoaFY0L3BGUUZPa0s2c2dBOUFWWApNMlFDT0xnME9HVFNSV2NsR0R6ck5pekVKcWg4M3hhd1l1RjByVXNGVW9NUGJkSWJFaTRoK1lDVGlOdnpQQS9kCjNFenVZYkorVUs0bWU5S2J4VEdyQ3doL1BJQ3JwTHVuV2NqZDhza0NKM3BpT3Jtak5CcEhobjdkcTQ2alNvWU8KWDNZWkVZc2ZqcGJDd2RXeU5ZRExZYkpSZk5ZQWF5RVRzamlZWE01LytRa1cyK2dFTmRsYU1LTWJQLzh3YXVPNApNWm9WTFdubnVhY2YxNnFPVFJ5VzJzQjNjUDhDeGdsNlVHM1JhUEFwL0o2clE0am5BWkk3WDNSYm9sdG1La2RMClB5Z1A0VUdqZ3VrdEk1dnBLc1FWMTlIcUREc1lwMzhFYXE1K2pxZUs5U3FuL1VORHVBa3NPblRXbVdndUtuVU8KNGcwSWk0RzRLMXhHUG9abTRaVEFITVBOd1R6ZS8xWGt2NnVzTjYvTzZSK1BPTmFhWkNFZ0dUNlBJWHRBTTZCTwpBeklZc1RyMFgvK3ZKYXdpb0s0R1E4aFM4TzRuOStyVURTUElHcmZacmZEdkh3WDZJMFBXU3h2MitxNXFxUmhWCjBSZk5FWERKV05XK05WNUlqdTUzWnorcDNmRG5IdmNsbS9UajVNVmlLL1JaWHJadEZCcDJpRHBoODlkQnJWTmsKRVo2TlRWN25vNTc4Q05GTmRXOXlnTzZSdmV6NTl6WlU4cmlvUlJOTm5ENkJzQ3VCZG12ZXZSVW5FQ2QvQ1p5eQpvOG85cXVRSCtzNmF1NzVrdmJRSERiKzJWQVNhS09KMExOeCtJL1doZWxTc1BMNmFnUGl3SFFzcFROREkyNlVqCjBkdzkyRjFnNFd2V1BrbmpCL3l2NEFJPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==\n    client-key-data: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlKS1FJQkFBS0NBZ0VBMThkUmczQ01qZENqYTFIK1UzZi93Q1IrUGw5V3MwcHZsOG9FZXF4UmswV3h5NzIvCklLWmVhK1RIR0pQNVlZT2NHaFJTQlFxVjlXRXBCK1lzcXU5ZTlGdVBKaDJEV1M1RVJydEt4NTZYZkd2L3UvejkKVmIxZUFvUjF1RzV1L2JFbTFVUzhRcjdHMEhzaXBmMGZUNGIzMGhDUlMzdUJPS2wxREYveFVMYjFaODRUdFRUVQpPL0Z3OW43RTBvUU4vR1FsWVNtemVEdVpMNmNWWVN2RDIzc1BKSVdqSm1wTXhHRWV2L2djR1hOaFVXOWh4ZUNrCkJid1RTRFVDQ0N2bGFXaG9UTEUvZXltTHlIaHRYOHZEMkFocEJKTSs2R05xMXZyLzZrMHhMeGQwZDNWRmhzbU4KcjN6MzJ1Z20zbHBmcmdHd1A4bHZJWXV4SlVnM3Y5RzZnOXQ2WG5ud0pOQzNUdDlEenJGclFGMUtOY0t6NUh6UwpoaE5CWXpYREM5bzRBUUJNWlZNckJrQVZMaisrQUtGME53QmlwWEVkS2tsZ3VXckxsV1ZIendDT0ZtdHdaWUxQCmt5cnZvb1FObWdTVU1HNTFtd0o3UVNpTjFGclZkZ1pjZUhJL3JOcVRaMzdOOHRUN0wwQjhRU3NYR3o3OTBBVkIKeit2RE1iYTR1Vm9DNjJFV2JNS2Y2S3J2SDhtL2N0cHMrcnExL01ySWlxdElxS1RxcDdLVlQyMzlmWTB4bUhrMwp6NkRwR0RMZ012QWExT0Q5M0liRVFBeWcrNnRLNDlaM1lNb0czaEc0cEtMSmRqTFBnUWJ0N2IwbU1CUm5HTWdyCkZic1ZtQXkyQU1jc0U3V0t0bFZrb3ZXM2lVMVlERTIwK3JCcmg0azBVMnhmaEkrcjBGMWphUUtCUHAwQ0F3RUEKQVFLQ0FnRUFnOTY0SGxBR1ZoVVFDbUtOdjQweXE4YWhzSlNyYzk4bDIrb0dXc0k5Q0hncmRJeDk1Z0pHNmtGaQp1ODZUTmRrczZYTkp2UEwvT25zcWpEMUxSeHdMTitOTTFNcHNuMi83SWc4TVlIcTNzYjUvQi9CUkVya3NYdlY4CnpENFJidEY1SGhWbnlKSzNCbXA2Zmw3M1o2N2dmV3pLbndyWHFqMUYzMDR6T0ZUWUhaeC94dHFHYWl2Z0VZVGYKM0pmL3hDT2dCSVZydlNzUEwyUTVXSzFhZ1NQdjJTNGl5ek5qdnhCcnJuNS9EYjdKMXU3dkhmTnZ5bUZxbDFKdAo3M2lFTjZzck10T1FMRUR6d0l4NHEzYm9OWHJPVTVGNWZLUmxnd1RhcWVLTEVIQ1JLUUJ1Z1RWa2RiODE2bjYrCllsMXc0L0w4Tjc5dlAxMFQ0ZWtFeVNIdmp1M3ZGZlpxMmJ6SFVMUTR2NWFoZm9wTnh0U002bUtNaGQ3RXpMaG8KQWFMZ3BNSVlSMXF1UU1wSUIxVG9PbjJGOE1EM3JhaDFnSTdyeEVmb2lrOUw5enlQRzZhTmxPTTN6S1VEd2JkTgpzM0t4b3pLOUFHRzNtczY4R3NjWTFxSFNLR0Y2WUlXTTdFZEp6MlNTWGFtZTF4TW50RDQxK00zakhLd0RKQ0FpCm1LS0xVNGdRUU5FTjlUcitSTWk2aXViVEUxdmlOdkJtOFg5N3VBQzZXa2tRaWwxUnFNSlN0ZXhVNEpkMTZZSEEKMTN4WS9LbExMTStNTUtGdXp3ZHFrd284a0RuRmxHWVM2aWtFL0VlYXpIdzJTbmdsaWdNcFNtQUFWdkkwZWptRwpwS1RDSWpzMDlRQjIyVzR1ZjFoQmNNdnZGN1NQVTFmV1QxRHluaEtyRjVrd2ZZOG16TEVDZ2dFQkFOL3JFeWh1CmNSS0FOelZXSFA2MytyOVd3Tk9Xbjhab3EwRXI3elZEOVBmaHZCdFJZTWNFWFp2Z0x6QXRDUVIreDFOWnMwUkwKZ1d2S2M5Snpvd21KWlBsUCsveW5ab1h0WEQ0enVqVy8zREtHSFRBZk1rVVlvL1NIdFE1NVZSSkszdmpNcU1iVgp4LzAxMkQvdnFxV1V6Tm82Z2JRRTR0Z2pBQ2tyR2NSZmsxKzlDa0t0c3ZpblNKcjBvK243dW9JQ2hsK1A1aFVrCm9DS0tqQzN4aU9hM3F0ekpnT3ErQ3l6QUdGazJrMTllV1M1WWptQ0hua1Y1ckxaV3cyNmVyYVNiMXBwWk05RmsKbEZYa21uMWErQTRBSFBSUExNRmlaaW5WTHREVGFtMXhESGFpaEFXMnl2aEJtRUJodWJGNG43K0crLzcxZWNTTApqK1dpWmZraXhtYmlwdGNDZ2dFQkFQYXhzZHh2SVdBeXdkcFFrc3BvNkVvdmRWTWgwWjhHMFpkWCtYaTcyb1NqCmtEaDBHVHhkYmFPOXovbFhjM3M4UXI4RXV2aytUME9SdVBzZ2E5UE1SQllOaFozbmNMSzF5VysxSkkzdkhHVFgKVDVydVVuOWxlejBYc2REWGZjRnpSUzFLbE1NZzlHdnJSRU1GQU1PazRGZU9haUtITG1FNDJoRnZTOWlaQUdSUgp5U3Jrc2lZNnBrZXNTTFI1eHJXVnFNVEZCSkw4L3Y3ZTJTYUpOeHpRQmcyR0xybmxTNWoxMVlvVmRMdkRHVG5FCllZbUJsWmtJNFlyZDZ6OUdTZXlMeXJqTmMvYU1URVNmVEk0YmNZb2d4TUkrQ0Q1emMvUjYycHdXV0p4UWNtbTgKalgreHhOV0FGUFJQa2MxejFtRXBvSWtpdE9VempsMEZzYVQySGJiUis2c0NnZ0VBVDFGbkhPaGFWM0pobkJ3Zgo4ejdhck5LZlJaUlNqcWJmR3h2a0JWdElPRktYSHBvcURQV0g3MEp2bE1Jdk1vOXlMaDFWT2prQTVGejN3REhFCkxBbW1ZZ1lxUGVwU2o5aHYxM3pkVmxMYlBtNXhnbTFha2sxVExyaXZzeXZacmJ3bDFiNHhmeFdWWFNXb3I2VkgKTHBaU0ptK1pLRnFldkc5UmpFTy9RZWVWUGRHcUE4cWgzaURyd0RBdXJDREdoVzA5aWpaZ0MxZEkvbE5UcXFhbgpsd3F5bExrd1dIYnZZRysvY0VLNzI0bUJUOENBMXNMVGxzcXVHbjBMaDNEZ0U3SThSN3FYZDNJSWRaQ2dCUTJuClZ0WkZhMmxzY2loWUJqT0UvT1lYQ2lPRWhiVzF6SXhldzZnQXRiV29ZS3hZOGpCdnJYWHBKMjFFa05TQkNNcC8KdTB4SVN3S0NBUUE2K3k4d0tlM0w1emJMOEptNEJTOE1sWjR5ZXhKNE9CUWlZQ2xJUVhtMFhycmJsSDU0SFVwYQpiTVp0c2dmdFBmSWpZNGtra0U0NU5IMEtwYXpDSGNObGxtUU01Y25mSUhHQjRNaFZtd2FwNFlTcDRUTWVQSEFqCm9pZWthL0VvTUZ3b3dQMGlUaDNDTTZURmRVdkNld2djUnZOL1A5eko1K0xUYWsyekFwbkNZbjk3WHVSdEdYYXEKQ2puejFHMjYrb1k0VFhhVGdpT2hZangrNXkyakdPVnBsRnhWbThuZ1QxNTN2anVEck5pNkpBYkI3cGFLMlVHNwpodVY0NG1CSVN2LzBBVU1wZmsrNTFIQmtSWkYyMmZEUkZDMjZhTFlmak1QNXI2b043WG45WjlSWTVITFFMT2hWCnBUU1I3NUVnOStmbkFjSklUblJLTDFOU3dubEdQWnd6QW9JQkFRQ3FxTTFqWUpGWms3RXpyMGFsakJKaHAxNEoKMDU1U3BqdGZKSXNrQmdneG1FUVFpVm9SYlhCeFNJVGpQM0kzajdvYnVpQUt1QmZwWFpaQjczTEVacHNud2QxKwpiUjBvU1JYSXZNNlpSQk1md1dZN0Y0QjV3QnBVaTVRcW9iaW5zVkJMd0dLV0tvS2xNVXdUYUdFekhsSDJYS0JrCmFPdUpQcmMrcFVGK0VGVEEvUTVJSTVHSXRvcXNHendNWGEyaFY4UFhIN095SkF1OW1taXcwOEhoN0UvVDhOM1YKaGQ1Wk9SRVZyWnE4eGpEelJPV3c1cjdzQXZZcFE4SFZjMkJCa1BENEplY3o2QzlHSGFsdEpFNXhXZ2tQVXJCNAowb09zcm4vMEYzNEZEL24zRExIbDluREd1Z3RuenlKWTZTT1pkVTFGMngvMC9aZWFlZC9GdFk2b0Y1Y2gKLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0K\n    token: fkzjjo4hwp5yn8fe1v9hzl9iinfqv17bljq4sh2s3ug03bk225od2l51d14sov1k0d37zho7dzdeztocbfmxct8z11kli3rp8rhvmrhz52knp4hsu3wokp1pndcwyuhh\n",
            "kubelet_identity": [
              {
                "client_id": "a64b705a-5552-46f8-8b00-1a3dcdc6e630",
                "object_id": "2591b1e5-0e12-4abe-a734-e7e6bc5a928c",
                "user_assigned_identity_id": "/subscriptions/f89882ab-4505-45fb-b088-f9c3f90f834e/resourceGroups/MC_BU-MT_sweeping-leopard-aks_westeurope/providers/Microsoft.ManagedIdentity/userAssignedIdentities/sweeping-leopard-aks-agentpool"
              }
            ],
            "kubernetes_version": "1.26.3",
            "linux_profile": [],
            "local_account_disabled": false,
            "location": "westeurope",
            "maintenance_window": [],
            "maintenance_window_auto_upgrade": [],
            "maintenance_window_node_os": [],
            "microsoft_defender": [],
            "monitor_metrics": [],
            "name": "sweeping-leopard-aks",
            "network_profile": [
              {
                "dns_service_ip": "10.0.0.10",
                "docker_bridge_cidr": "",
                "ebpf_data_plane": "",
                "ip_versions": [
                  "IPv4"
                ],
                "load_balancer_profile": [
                  {
                    "effective_outbound_ips": [
                      "/subscriptions/f89882ab-4505-45fb-b088-f9c3f90f834e/resourceGroups/MC_BU-MT_sweeping-leopard-aks_westeurope/providers/Microsoft.Network/publicIPAddresses/82d30a23-6d0c-423f-8f74-2abdf4260a72"
                    ],
                    "idle_timeout_in_minutes": 0,
                    "managed_outbound_ip_count": 1,
                    "managed_outbound_ipv6_count": 0,
                    "outbound_ip_address_ids": [],
                    "outbound_ip_prefix_ids": [],
                    "outbound_ports_allocated": 0
                  }
                ],
                "load_balancer_sku": "standard",
                "nat_gateway_profile": [],
                "network_mode": "",
                "network_plugin": "kubenet",
                "network_plugin_mode": "",
                "network_policy": "",
                "outbound_type": "loadBalancer",
                "pod_cidr": "10.244.0.0/16",
                "pod_cidrs": [
                  "10.244.0.0/16"
                ],
                "service_cidr": "10.0.0.0/16",
                "service_cidrs": [
                  "10.0.0.0/16"
                ]
              }
            ],
            "node_os_channel_upgrade": null,
            "node_resource_group": "MC_BU-MT_sweeping-leopard-aks_westeurope",
            "node_resource_group_id": "/subscriptions/f89882ab-4505-45fb-b088-f9c3f90f834e/resourceGroups/MC_BU-MT_sweeping-leopard-aks_westeurope",
            "oidc_issuer_enabled": false,
            "oidc_issuer_url": "",
            "oms_agent": [],
            "open_service_mesh_enabled": null,
            "portal_fqdn": "sweeping-leopard-k8s-na7oxjtf.portal.hcp.westeurope.azmk8s.io",
            "private_cluster_enabled": false,
            "private_cluster_public_fqdn_enabled": false,
            "private_dns_zone_id": null,
            "private_fqdn": "",
            "public_network_access_enabled": true,
            "resource_group_name": "BU-MT",
            "role_based_access_control_enabled": true,
            "run_command_enabled": true,
            "service_mesh_profile": [],
            "service_principal": [],
            "sku_tier": "Free",
            "storage_profile": [],
            "tags": {
              "environment": "Demo"
            },
            "timeouts": null,
            "web_app_routing": [],
            "windows_profile": [],
            "workload_autoscaler_profile": [],
            "workload_identity_enabled": false
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo1NDAwMDAwMDAwMDAwLCJkZWxldGUiOjU0MDAwMDAwMDAwMDAsInJlYWQiOjMwMDAwMDAwMDAwMCwidXBkYXRlIjo1NDAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIyIn0=",
          "dependencies": [
            "random_pet.prefix"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "azurerm_resource_group",
      "name": "default",
      "provider": "provider[\"registry.terraform.io/hashicorp/azurerm\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "/subscriptions/f89882ab-4505-45fb-b088-f9c3f90f834e/resourceGroups/BU-MT",
            "location": "westeurope",
            "managed_by": "",
            "name": "BU-MT",
            "tags": {},
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo1NDAwMDAwMDAwMDAwLCJkZWxldGUiOjU0MDAwMDAwMDAwMDAsInJlYWQiOjMwMDAwMDAwMDAwMCwidXBkYXRlIjo1NDAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIwIn0="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "random_pet",
      "name": "prefix",
      "provider": "provider[\"registry.terraform.io/hashicorp/random\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "sweeping-leopard",
            "keepers": null,
            "length": 2,
            "prefix": null,
            "separator": "-"
          },
          "sensitive_attributes": []
        }
      ]
    }
  ],
  "check_results": null
}'
                        echo "$my_string" > terraform.tfstate
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
                        sh "az login --username ${AZURE_USERNAME} --password ${AZURE_PASSWORD}"
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
                        sh "terraform apply -target=resou.resource_name"

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

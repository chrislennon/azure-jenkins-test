# Azure hosted Jenkins Master on Ubuntu

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fchrislennon%2Fazure-jenkins-test%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fchrislennon%2Fazure-jenkins-test%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows you to host an instance of Jenkins on a DS1_v2 size Linux Ubuntu 16.04 LTS VM in Azure.

An example of this project has already been deployed [here]().

## Deploy Azure Jenkins VM
1. Click "Deploy to Azure" button.
2. Enter a the required fields
 - valid name for the VM
 - user name 
 - password
3. The credentials set above will be your connection information over SSH.

OR

Run the following commands
1. Create a resource group
```
az group create --name Vandebron-Jenkins-Test --location "West Europe"
```
2. Create the deployment
```
az group deployment create \
    --name Vandebron-Jenkins-Test-Instance \
    --resource-group Vandebron-Jenkins-Test \
    --template-file azuredeploy.json \
    --parameters "{\"adminUsername\":{\"value\":\"adminuser\"}, \"adminPassword\":{\"value\":\"Adm1nP@ssw0rd\"}, \"jenkinsDnsPrefix\":{\"value\":\"vandebron-jenkins-test\"}}"

```

## Setup SSH port forwarding
**By default the Jenkins instance is using the http protocol and listens on port 8080. Users shouldn't authenticate over unsecured protocols!**

You need to setup port forwarding to view the Jenkins UI on your local machine. If you do not know the full DNS name of your instance, go to the Portal and find it in the deployment outputs here: `Resource Groups > {Resource Group Name} > Deployments > {Deployment Name, usually 'Microsoft.Template'} > Outputs`

### If you are using Windows:
Install Putty or use any bash shell for Windows (if using a bash shell, follow the instructions for Linux or Mac).

Run this command:
```
putty.exe -ssh -L 8080:localhost:8080 <User name>@<Public DNS name of instance you just created>
```

Or follow these manual steps:
1. Launch Putty and navigate to 'Connection > SSH > Tunnels'
2. In the Options controlling SSH port forwarding window, enter 8080 for Source port. Then enter 127.0.0.1:8080 for the Destination. Click Add.
3. Click Open to establish the connection.

### If you are using Linux or Mac:
Run this command:
```bash
ssh -L 8080:localhost:8080 <User name>@<Public DNS name of instance you just created>
```

## Connect to Jenkins

1. After you have started your tunnel, navigate to http://localhost:8080/ on your local machine.
2. Unlock the Jenkins dashboard for the first time with the initial admin password. To get this token, SSH into the VM and run `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
3. Your Jenkins instance is now ready to use! You can access a read-only view by going to http://< Public DNS name of instance you just created >.

## Construction

Adapted and extended from the following resources:
- [Azure Jenkins quick-start template](https://github.com/Azure/azure-quickstart-templates/tree/master/101-jenkins)
- [Azure Devops Utils - Jenkins Install Script](https://github.com/Azure/azure-devops-utils/blob/master/jenkins/install_jenkins.sh)
- [Dependancies & Installation of prudentia](https://github.com/StarterSquad/prudentia)
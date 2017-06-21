#!/bin/bash

# Having to work around the fact that you can only have one extension script in Linux on Azure https://stackoverflow.com/a/42965789

while [[ $# > 0 ]]
do
  key="$1"
  shift
  case $key in
    --jenkins_fqdn|-jf)
      jenkins_fqdn="$1"
      shift
      ;;
    --vm_private_ip|-pi)
      vm_private_ip="$1"
      shift
      ;;
    --repository_location|-rp)
      repository_location="$1"
      shift
      ;;
    *)
      echo "ERROR: Unknown argument '$key' to script '$0'" 1>&2
      exit -1
  esac
done

curl -O https://raw.githubusercontent.com/chrislennon/azure-jenkins-test/master/install_jenkins.sh
curl -O https://raw.githubusercontent.com/chrislennon/azure-jenkins-test/master/install_prudentia.sh

chmod +x install_jenkins.sh
chmod +x install_prudentia.sh

./install_jenkins.sh -jf $jenkins_fqdn -pi $vm_private_ip

./install_prudentia.sh
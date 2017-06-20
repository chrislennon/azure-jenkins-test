#!/bin/bash

# Having o work around the fact that you can only have one extension script in Linux on Azure https://stackoverflow.com/a/42965789

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
    --jenkins_release_type|-jrt)
      jenkins_release_type="$1"
      shift
      ;;
    --jenkins_version_location|-jvl)
      jenkins_version_location="$1"
      shift
      ;;
    --artifacts_location|-al)
      artifacts_location="$1"
      shift
      ;;
    --sas_token|-st)
      artifacts_location_sas_token="$1"
      shift
      ;;
    --help|-help|-h)
      print_usage
      exit 13
      ;;
    *)
      echo "ERROR: Unknown argument '$key' to script '$0'" 1>&2
      exit -1
  esac
done

./jenkins.sh -jf $jenkins_fqdn -pi $vm_private_ip -al $artifacts_location -st $artifacts_location_sas_token

./install_prudentia.sh
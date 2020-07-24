#!/bin/bash
# This script assumes you will generate your RSA keys in the same directory as this script
# This script also assumes you have a service account available in the current directory with the `_sa.json` suffix
echo '<<<<<<    Starting script      >>>>>>'
serviceAccountFile=$(ls | grep .*_sa.json)

if [[ "$serviceAccountFile" == "" ]]
then
  echo "Service account file not found"
fi
echo "====================================="

read -p "generate ssh keys [yes, no] " toGenerate

if [ $toGenerate == "yes" ] 
then 
 echo "<<<<<<   Generating ssh keys >>>>>"
 ssh-keygen -t rsa
 echo "====================================="
fi

echo '<<<<<<   Generating GCP  metada  >>>>>>'
read -p "SSH user: " user
pkey=$(cat *.pub)
echo "$user:$pkey ansible" > gcloud_metadata_file
echo "====================================="

echo "<<<<<<   Preparing GCLOUD >>>>>>"
gcloud auth activate-service-account --key-file="./$serviceAccountFile"
echo "====================================="

echo "<<<<<<   Adding metadata to project ssh    >>>>>>"
gcloud compute project-info add-metadata --metadata-from-file ssh-keys=gcloud_metadata_file
echo "====================================="


# GCP project wide ssh setup 
project-wide public SSH keys script. 

A simple sctipt to setup the user ssh keys for your GCP project. You can integrate it with HashiCorp Vault, so that vault manages the generation, storation and versioning of your rsa-keys. 

This script depends on:

 1- ssh-keygen
 
 2- gcloud sdk

## Asumptions

1- This script assumes you will generate/cp your RSA keys in the same directory as this script

2- This script also assumes you have a service account available in the current directory with the `_sa.json` suffix

3- This script assumes you have already setup which project you would like to operate on using `gcloud config set project <project-id>`

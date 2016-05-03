# Introduction
Customized interactive ansible shell scripts for Cloudera Manager/Ambari installation with Pre-requisite Check and  Enforcement

## Pre-requisites

* Ansible - latest

## List of Scripts

* initialiseAnsibleHosts.sh 
* prerequisiteCheck.sh
* prerequisiteEnabler.sh
* installClouderaManager.sh
* installAmbari.sh
* cleanAnsibleHosts.sh
* verify.sh

## Usage 

* initialiseAnsibleHosts.sh - To initialize Ansible inventory file
* prerequisiteCheck.sh - After initializing Ansible inventory, this script is used to do Pre-requisite Check on  hosts.
* prerequisiteEnabler.sh - Enforcing Hadoop Pre-requisites
* installClouderaManager.sh - Installing Cloudera Manager
* installAmbari.sh - Instllaing Ambari
* cleanAnsibleHosts.sh - Cleaning up Ansible inventory

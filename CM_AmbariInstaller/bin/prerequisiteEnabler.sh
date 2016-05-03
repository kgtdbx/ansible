#########################################################
# Hadoop pre-requisite Enabler Script using Ansible
# Author Suraj Kumar J
#########################################################


echo "Enter the name of the Initialized Cluster"
read name
cat ../conf/hosts | grep -w "$name" 1>/dev/null
result=$?
      if [ $result -ne 0 ] ; then
         echo "Cluster not found on Ansible Host file. Please Add it."
         exit 1
      else
         echo "Cluster Found. Starting Prerequisite Enabler"
         sleep 1
         f=`awk  '/'"$name"'/{f=1;next} /\[*\]/{f=0} f' ../conf/hosts | wc -l`
         ansible-playbook -i ../conf/hosts --extra-vars="nodes=$name" ../conf/prereq.yml -f $f -vv
      fi

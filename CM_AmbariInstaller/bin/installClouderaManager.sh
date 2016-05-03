#############################################################
# Installing Cloudera Manager
# Author Suraj Kumar J
#############################################################


echo "Enter the name of the cluster."
read name
cat ../conf/hosts | grep -w "$name" > /dev/null

result=$?
     if [ $result -ne 0 ] ; then
        echo "Cluster not found"
        exit 1
     else
       echo "Validating Cluster prerequisites."
       sleep 1
       fi
       f=`awk  '/'"$name"'/{f=1;next} /\[*\]/{f=0} f' ../conf/hosts | wc -l`
ansible-playbook -i ../conf/hosts --extra-vars="nodes=$name" ../conf/verify.yml -f $f -vv | sed 's/\\t/\t/g' | sed 's/\\r/\r/g' | sed 's/\\n/\n/g' | grep -vE "(debug|stderr|stdout_lines)" | grep -iw "on"
result=$?
     if [ $result -ne 0 ] ; then
        echo "Validation successfully completed."
     else
        echo "Cluster prerequisites are not properly set."
        exit 1
     fi

echo "Enter IP address of Cloudera Management server"
read sv
ssh root@$sv "yum install -y cloudera-manager-server*" 

#################################################
#Ansible Custom Inventory Initialization Script
#Author : Suraj Kumar J  
#################################################


  error="../logs/error-$(date +%F).log"
  cp -rp ../conf/hosts ../conf/hosts.back

#IP address validation 
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] ; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

#Interactive inputs for hosts file
count=`cat ../conf/hosts | wc -l`
echo -e "Enter a name to Cluster"
read name
cat ../conf/hosts | grep -w "$name"
result=$?

           if [ $result -ne 0 ] ; then
              echo "Adding Cluster"
              sleep 1
           else
              echo "Cluster already exists"
              mv ../conf/hosts.back ../conf/hosts
              exit 1
           fi

echo "[$name]" | cat >> ../conf/hosts
echo -e "For keyboard entry press 1\nFor file input press 2"
read option
           if [ $option -eq 1 ] ; then
              echo -e "How many nodes to be Clusterize"
              read a
              c=$(($count + $a + 1))
              echo -e "Enter IP address of nodes seperated by new line"
            while [ $a -gt 0 ] ; 
                  do
                  function inputIp()
                  { 
                     read b
                     valid_ip $b
                     if [[ $? -eq 0 ]]; then 
                         echo $b | cat >> ../conf/hosts 
                     else 
                         echo "Bad IP address. Please Enter the IP again"
                         inputIp
                     fi

                   }
             inputIp
             a=`expr $a - 1`
             done
            elif [ $option -eq 2 ] ; then
                 echo "Enter the path"
                 read path
                 ls $path 2>>${error} 1>/dev/null
                 result=$?
                 if [ $result -ne 0 ]; then
                    echo "Invalid path. For details refer log under logs directory"
                    mv ../conf/hosts.back ../conf/hosts
                    exit 1
                 else 
                    echo "" > /dev/null
                 fi
                 for i in `cat $path`
                 do
                    valid_ip $i
                    if [[ $? -eq 0 ]]; then
                        echo $i "Good"
                    else
                        echo "Bad IP address. Please correct"
                        mv ../conf/hosts.back ../conf/hosts
                        exit 1
                    fi
                 done
                    d=`cat $path | wc -l`
                    c=$(($count + $d + 1))
                    cat $path >> ../conf/hosts
            else
                    echo "Invalid option"
                    mv ../conf/hosts.back ../conf/hosts
                    exit 1;
            fi
count=`cat ../conf/hosts | wc -l`
result=$count
if [ ${result} -ne $c ]; then
                                                                          
         printf "The operation failed                        [FAILED]\n" 
         mv ../conf/hosts.back ../conf/hosts
         exit 1
         else
         printf "Initialization Completed                    [ SUCCESS ]\n"
         rm -rf ../conf/hosts.back
fi

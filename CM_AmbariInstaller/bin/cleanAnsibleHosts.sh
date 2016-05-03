#################################################
# Ansible Custom Inventory Clean-up Script
# Author Suraj Kumar J
#################################################




echo "Are you sure? Hit [enter] to continue"
read foo
cat /dev/null > ../conf/hosts 
result=$?
         if [ ${result} -ne 0 ]; then
         printf "                                     [ FAILED  ]" 
                printf "The operation failed.\n" 
                exit 1
         else
         printf "Cleanup Completed                    [ SUCCESS ]\n"                        
         fi


#!/bin/bash
echo "Creating Ec2 Instances"
IMAGE_ID=ami-0f3c7d07486cad139
SG_ID=sg-05f9f061d6e0805f8
INSTANCE=("mongodb" "mysql" "redis" "rabbitmq" "frontend" "catalogue" "cart" "user" "shipping" "payment" "dispatch")
ZONE_ID=Z051889327O7Z1ITOEICM
DOMAIN_NAME=dineshdevops.online

for i in "${INSTANCE[@]}"
do 
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ] 
        then 
            INST_TYPE="t3.small"
        else 
            INST_TYPE="t2.micro"
    fi
  IP_ADDR=$(aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INST_TYPE --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)
  echo $IP_ADDR

  aws route53 change-resource-record-sets \
  --hosted-zone-id $ZONE_ID \
  --change-batch '
  {
     "Comment": "Creating a record set for cognito endpoint"
     ,"Changes": [{
     "Action"              : "UPSERT"
     ,"ResourceRecordSet"  : {
        "Name"              : "'$i'.'$DOMAIN_NAME'"
        ,"Type"             : "A"
        ,"TTL"              : 1
        ,"ResourceRecords"  : [{
            "Value"         : "'$IP_ADDR'"
        }]
     }
     }]
 }
    '  
done




    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
    {
        "Comment": "Creating a record set for cognito endpoint"
        ,"Changes": [{
        "Action"              : "UPSERT"
        ,"ResourceRecordSet"  : {
            "Name"              : "'$i'.'$DOMAIN_NAME'"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "'$IP_ADDR'"
            }]
        }
        }]
    }
        '
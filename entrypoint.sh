#!/bin/sh -l

export ACCOUNT_NAME=$INPUT_ACCOUNT_NAME
export RESOURCE_GROUP_NAME=$INPUT_RESOURCE_GROUP_NAME
export ARM_SUBSCRIPTION_ID=$INPUT_ARM_SUBSCRIPTION_ID
export TF_VAR_resource_group_name=$INPUT_RESOURCE_GROUP_NAME

echo "*******************"
echo "Running entrypoint"
echo "*******************"


az cosmosdb create --name $ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME --subscription ARM_SUBSCRIPTION_ID

#!/bin/sh -l

export ARM_CLIENT_ID=$INPUT_ARM_CLIENT_ID

export ACCOUNT_NAME=$INPUT_ACCOUNT_NAME
export RESOURCE_GROUP_NAME=$INPUT_RESOURCE_GROUP_NAME
export TF_VAR_resource_group_name=$INPUT_RESOURCE_GROUP_NAME

echo "*******************"
echo "Running entrypoint"
echo "*******************"

# Create a Cosmos DB account with default values and service endpoints
# Use appropriate values for --kind or --capabilities for other APIs
az cosmosdb create \
    -n $ACCOUNT_NAME \
    -g $RESOURCE_GROUP_NAME \
    --enable-virtual-network true
#!/bin/sh -l

export ACCOUNT_NAME=$INPUT_ACCOUNT_NAME
export RESOURCE_GROUP_NAME=$INPUT_RESOURCE_GROUP_NAME
export ARM_SUBSCRIPTION_ID=$INPUT_ARM_SUBSCRIPTION_ID
export ARM_TENANT_ID=$INPUT_ARM_TENANT_ID
export SP_USERNAME=$INPUT_SP_USERNAME
export SP_SECRET=$INPUT_SP_SECRET
export MSI_OBJECT_ID=$INPUT_MSI_OBJECT_ID
export MSI_NAME=$INPUT_MSI_NAME


export TF_VAR_resource_group_name=$INPUT_RESOURCE_GROUP_NAME

echo "*******************"
echo "Running entrypoint"
echo "*******************"

az login --service-principal -u $SP_USERNAME -p $SP_SECRET --tenant $ARM_TENANT_ID

echo "*******************"
echo "Init variables"
echo "*******************"

export REGION=$(az aks list --resource-group $RESOURCE_GROUP_NAME --query '[].location' -o tsv)
export CLUSTER_NAME=$(az aks list --resource-group $RESOURCE_GROUP_NAME --query '[].name' -o tsv)
export VMSS_NAME=$(az vmss list --resource-group MC_${RESOURCE_GROUP_NAME}_${CLUSTER_NAME}_${REGION} --query '[].name' -o tsv)

echo "*******************"
echo "Assign role for cosmosdb"
echo "******************* "

az cosmosdb create --name $ACCOUNT_NAME --resource-group ${RESOURCE_GROUP_NAME} --subscription $ARM_SUBSCRIPTION_ID
az cosmosdb sql role assignment create --account-name $ACCOUNT_NAME --resource-group ${RESOURCE_GROUP_NAME} --scope "/" --principal-id $MSI_OBJECT_ID --role-definition-id 00000000-0000-0000-0000-000000000001

echo "*******************"
echo "Assign MSI to VMSS "
echo "*******************"

az vmss identity assign --identities $MSI_NAME --name $VMSS_NAME --resource-group MC_${RESOURCE_GROUP_NAME}_${CLUSTER_NAME}_${REGION}

echo "*******************"
echo "Completed entrypoint"
echo "*******************"

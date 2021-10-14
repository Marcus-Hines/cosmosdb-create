# cosmosdb-create

This action can be used by apps that will be using a managed cosmodb instance on AKS, and want this app to communicate with cosmosdb using MSI (Managed Service Identity)

# Before using this action:
You will need to create an MSI in aks that will be assigned to the nodes on your AKS cluster. This MSI will be automatically granted the permissions required to access the cosmosdb instance that is created by this action.
The following inputs are required:

`ACCOUNT_NAME:` (_required_) This is whatever you would like for you cosmosdb account in AKS to be named
. __Example:__. `mycosmosdb`

`RESOURCE_GROUP_NAME:` (_required_) This is the resource group that you want your cosmosdb account to be created in.
. __Example:__. `cosmosrg`

`SUBSCRIPTION_ID:` (_required_) This is the subscription id that your resource group belongs to
. __Example:__. `00000000-0000-0000-0000-000000000000`


`OBJECT_ID:` (_required_) This is the object id or principle id associated with the MSI that you will be using to communicate with CosmosDB
. __Example:__. `00000000-0000-0000-0000-000000000000` **To create the required MSI, run the below command. Replace everything inside < > with the correct details 

    az identity create -g MC_<resource-group-name>_<cluster-name>_region -n <whatever-you-want-to-name-your-msi>
    echo $(az identity show -n <whatever-you-want-to-name-your-msi> -g MC_<resource-group-name>_<cluster-name>_region --query principalId --out tsv)

Example:

    az identity create -g MC_myResourceGroup_myCluster_eastus -n cosmosmsi
    echo $(az identity show -g MC_<resource-group-name>_<cluster-name>_region -n cosmosmsi --query principalId --out tsv)


This will create the MSI and output the object id (principle id) of the MSI. You can then copy the object id and pass that as an arg to this action, and also reference it in your application code when attempting to access
CosmosDB with MSI.

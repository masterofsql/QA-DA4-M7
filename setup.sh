#! /usr/bin/sh

#
# This script creates compute instance,
# assuming that workspace already exists
# (--idle-time-before-shutdown 65 : DOES NOT WORK!)
#


echo "Detecting the current Azure ML environment..."
WORKSPACE_INFO=$(az ml workspace list --query '[0]' -o json)
RESOURCE_GROUP=$(echo "${WORKSPACE_INFO}" | jq -r '.resourceGroup')
WORKSPACE_NAME=$(echo "${WORKSPACE_INFO}" | jq -r '.name')

if [ -z "$RESOURCE_GROUP" ] || [ -z "$WORKSPACE_NAME" ]; then
  echo "Error: Could not detect workspace. Make sure at least one Azure ML workspace exists."
  exit 1
fi

echo "Resource Group    : ${RESOURCE_GROUP}"
echo "AzureML Workspace : ${WORKSPACE_NAME}"

echo "Creating compute instance..."
COMPUTE_INSTANCE_NAME="qa-ci-${RESOURCE_GROUP}"
az ml compute create \
   --name ${COMPUTE_INSTANCE_NAME} \
   --type ComputeInstance \
   --size Standard_DS11_v2 \
   --resource-group ${RESOURCE_GROUP} \
   --workspace-name ${WORKSPACE_NAME}
echo "${COMPUTE_INSTANCE_NAME}"
echo "Done!"
echo

echo "Listing all the available compute instances:"
COMPUTE_NAMES=$(az ml compute list \
  --resource-group "$RESOURCE_GROUP" \
  --workspace-name "$WORKSPACE_NAME" \
  --query "[?type=='computeinstance'].name" -o tsv)
echo "$COMPUTE_NAMES"

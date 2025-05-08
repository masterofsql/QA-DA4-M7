#! /usr/bin/sh

#
# This script assumes we are already signed into Azure,
# so we don't check for this
#

echo "Getting details of the current subscription..."
SUBSCRIPTION_ID=$(  az account show --query id        -o tsv)
SUBSCRIPTION_NAME=$(az account show --query name      -o tsv)
USERNAME=$(         az account show --query user.name -o tsv)
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Azure Environment Details"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Subscription ID   : $SUBSCRIPTION_ID"
echo "Subscription Name : $SUBSCRIPTION_NAME"
echo "Username          : $USERNAME"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

echo "Getting Resource Groups..."
RESOURCE_GROUPS=$(az group list --query "[].name" -o tsv)
if [ -z "$RESOURCE_GROUPS" ]; then
  echo "No Resource Groups found in this subscription"
  break
fi
echo "Resource Groups:"

for RG in $RESOURCE_GROUPS; do
  echo "------------------------------"
  echo "Resource Group: $RG"
done

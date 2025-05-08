#!/usr/bin/sh

#
# This script assumes we are already signed into Azure,
# so we don't check for this
#

echo "Getting details of the current subscription..."
SUBSCRIPTION_ID=$(  az account show --query id        -o tsv)
SUBSCRIPTION_NAME=$(az account show --query name      -o tsv)
USERNAME=$(         az account show --query user.name -o tsv)
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Azure Environment Details"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

echo "Subscription ID   : $SUBSCRIPTION_ID"
echo "Subscription Name : $SUBSCRIPTION_NAME"
echo "Username          : $USERNAME"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo

echo "Getting Resource Groups..."
RESOURCE_GROUPS=$(az group list --query "[].name" -o tsv)
if [ -z "$RESOURCE_GROUPS" ]; then
  echo "No Resource Groups found in this subscription"
  break
fi
echo $RESOURCE_GROUPS
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

for RG in $RESOURCE_GROUPS; do
  echo
  echo "RESOURCE GROUP : $RG"
  # List workspaces in the resource group
  WORKSPACES=$(az ml workspace list --resource-group "$RG" --query "[].name" -o tsv 2>/dev/null)

  if [ -z "$WORKSPACES" ]; then
    echo "     --- no workspaces found in this resource group"
  else
    for WS in $WORKSPACES; do
      echo "     WORKSPACE : $WS"
      # List computes in the workspace
      COMPUTES=$(az ml compute list --workspace-name "$WS" --resource-group "$RG" --query "[].name" -o tsv 2>/dev/null)

      if [ -z "$COMPUTES" ]; then
        echo "                 --- no compute targets found in this workspace"
      else
        echo "                 COMPUTES:"
        for COMP in $COMPUTES; do
          echo "                           - $COMP"
        done
      fi
    done
  fi
  echo "-------------------------------------------------------"
done

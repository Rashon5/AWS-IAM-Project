#!/bin/bash

# Define the group names and corresponding policies
declare -A groups_policies=(
  ["CloudAdmin"]="arn:aws:iam::aws:policy/AdministratorAccess"
  ["DBA"]="arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  ["LinuxAdmin"]="arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ["NetworkAdmin"]="arn:aws:iam::aws:policy/AmazonVPCFullAccess"
)

# Iterate over the associative array and create groups and attach policies
for group in "${!groups_policies[@]}"; do
  echo "Creating group: $group"
  aws iam create-group --group-name "$group"
  
  echo "Attaching policy to group: $group"
  aws iam attach-group-policy --group-name "$group" --policy-arn "${groups_policies[$group]}"
  
  if [ $? -eq 0 ]; then
    echo "Successfully attached policy to $group"
  else
    echo "Failed to attach policy to $group"
  fi
done

echo "Script execution completed."

# Make executable
# chmod +x Create-Groups-with-Policy.sh

# Run the script
# ./Create-Groups-with-Policy.sh

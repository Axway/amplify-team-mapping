#!/bin/bash

APIMANAGER_API_VERSION=v1.4
CREATE_TEAM_FROM_DISBALED_ORG=false
TEMP_FILE=objectListTemp.json

###############################
# Input parameters:
# 1- API Manager host
# 2- API Manager port
# 3- API Manager username
# 4- API Manager password
# 5- Platform Oragnization ID
###############################
create_team() {

# map parameters
HOST=$1
PORT=$2
USERNAME=$3
PASSWORD=$4
PLATFORM_ORGID=$5

# encode user/password
AUTH=$(echo -ne "$USERNAME:$PASSWORD" | base64 --wrap 0)

# create the orgList
if [[ $CREATE_TEAM_FROM_DISBALED_ORG == false ]]; then
	echo "Removing dissabled organizations from the organization list"
	curl -k -H "Authorization: Basic $AUTH" https://$HOST:$PORT/api/portal/$APIMANAGER_API_VERSION/organizations | jq -c '[ .[] | select(.enabled == true) ]' > $TEMP_FILE
else
    echo "Reading all organizations"
    curl -k -H "Authorization: Basic $AUTH" https://$HOST:$PORT/api/portal/$APIMANAGER_API_VERSION/organizations > $TEMP_FILE
fi

# loop over the result and keep interesting data (name / description)
cat $TEMP_FILE | jq -rc ".[] | {name: .name, desc: .description}" | while IFS= read -r line ; do
   # read organizationId
   ORG_ID=$(echo $line | jq -r '.id')
   # read organization name for creating the corresponding team name
   TEAM_NAME=$(echo $line | jq -r '.name')
   # read organization description if exist
   TEAM_DESCRIPTION=$(echo $line | jq -r '.desc')
   
   if [[ "$TEAM_DESCRIPTION" == "null" ]]; then
      echo "Creating team without description."
	  echo axway team create $PLATFORM_ORGID "$TEAM_NAME"
	  axway team create $PLATFORM_ORGID "$TEAM_NAME"
	  
   else
      echo "Creating team with description."
      echo axway team create $PLATFORM_ORGID "$TEAM_NAME" --desc "$TEAM_DESCRIPTION"
      axway team create $PLATFORM_ORGID "$TEAM_NAME" --desc "$TEAM_DESCRIPTION"
   fi
   
done


}

###############################
# Input parameters:
# 1- API Manager host
# 2- API Manager port
# 3- API Manager username
# 4- API Manager password
# 5- Platform Oragnization ID
###############################
create_user()
{
# map parameters
HOST=$1
PORT=$2
USERNAME=$3
PASSWORD=$4
PLATFORM_ORGID=$5

# encode user/password
AUTH=$(echo -ne "$USERNAME:$PASSWORD" | base64 --wrap 0)


# create user?
curl -k -H "Authorization: Basic $AUTH" https://$HOST:$PORT/api/portal/$APIMANAGER_API_VERSION/users > $TEMP_FILE
# loop over the result and keep interesting data (login / email / organizationId / role / orgs2Role )
cat $TEMP_FILE | jq -rc ".[] | {name: .loginName, email: .email, organizationId: .organizationId, role: .role, orgs2Role: .orgs2Role}" | while IFS= read -r line ; do
   # read organizationId
   ORG_ID=$(echo $line | jq -r '.organizationId')
   # read login
   LOGIN=$(echo $line | jq -r '.loginName')
   # read email
   EMAIL=$(echo $line | jq -r '.email')
   # read role
   ROLE=$(echo $line | jq -r '.role')
   # read extra org role
   EXTRA_ORG_ROLE=$(echo $line | jq -r '.orgs2Role')
   
   ORG_NAME=$(getOrganizationName $1 $2 $3 $4 $ORG_ID)
   echo "Organization found: $ORG_NAME"

   echo "User found: $EMAIL, $ORG_ID, $ROLE, $EXTRA_ORG_ROLE - $ORG_NAME"
   
   
    #axway org user add <org> <email> --role <role>
	
	#axway team user add <org> <team> <user> --role <role>
   
done

}

getOrganizationName()
{
# map parameters
HOST=$1
PORT=$2
USERNAME=$3
PASSWORD=$4
V7_ORGID=$5

# encode user/password
AUTH=$(echo -ne "$USERNAME:$PASSWORD" | base64 --wrap 0)

# create the orgList
retVal=$(curl -k -H "Authorization: Basic $AUTH" https://$HOST:$PORT/api/portal/$APIMANAGER_API_VERSION/organizations/$V7_ORGID | jq -rc ".name")

echo "$retVal"
}

#########
# Main
#########

echo ""
echo "==============================================================================" 
echo "== Creating Amplify platform team from the organization name in API Manager ==" 
echo "== API Manager access and Amplify Platform access are required              =="
echo "== curl and jq programs are required                                        =="
echo "==============================================================================" 
echo ""

echo "Checking pre-requisites (axway CLI, curl and jq)"
# check that axway CLI is installed
if ! command -v axway &> /dev/null
then
    echo "axway CLI could not be found. Please be sure you can run axway CLI on this machine"
    exit 1
fi

#check that curl is installed
if ! command -v curl &> /dev/null
then
    echo "curl could not be found. Please be sure you can run curl command on this machine"
    exit 1
fi

#check that jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found. Please be sure you can run jq command on this machine"
    exit 1
fi
echo "All pre-requisites are available" 

#login to the platform
echo ""
echo "Connecting to Amplify platform with Axway CLI"
axway auth login

# manage error while login


# retrieve the organizationId of the connected user
echo ""
echo "Retrieving the organization ID..."
PLATFORM_ORGID=$(axway auth list --json | jq -r '.[0] .org .id')
echo "Done"

echo ""
echo "Getting API Manager host and port..."
read -p "API Manager host name: " HOST
read -p "API Manager port number: " PORT
echo "Getting API Manager credentials (ie a user that have API Manager administrator rights)..."
read -p "Username: " USER
read -s -p "Password: " PASSWORD
echo "***************"

echo ""
read -p "Do you want to create team from disabled organization? [y|N]" answer
if [[ $answer == "y" || $answer == "Y" ]]; then
    CREATE_TEAM_FROM_DISBALED_ORG=true
fi

echo ""
echo "Creating the teams"
create_team $HOST $PORT $USER $PASSWORD $PLATFORM_ORGID
echo "Done."


rm $TEMP_FILE

exit 0
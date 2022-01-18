# Mapping v7 organizations to an Amplify teams

This tools will help you to create teams from the v7 API Manager organizations

## Pre-requisite

* Axway CLI and Axway Central CLI
* jq
* curl
* A platform user having the administration rights to create team
* An API Manager access.

## How it works ?

The program will first start to login with the Axway CLI to the platform. You need to enter your username and password to be connected.

Then you will be asked to enter the API Manager configuration (host / port) and the user name and password to connect to API Manager.

The program will list all organizations the user is able to see and for each of them will create a corresponding Amplify team. The name of the team is the organization name and the description of the team is the organization description.

Then each team will be tagged either with `API development` or `Consumer` based on the corresponding organization attribute: development (true|false).

**Note**

In case you don't have a machine where the Axway CLI can be run within a graphical environment as well as accessing to the APIM APIs, you can run the script in 2 steps:

* execute the script on the APIM machine after commenting the Axway CLI commands and the _createAmplifyTeam_ procedure. This will produce a file with the organization list inside (refer to `TEMP_FILE` for the file name).
* download the produced file on the machine having Axway CLI and the script.
* execute the script, by commenting the _listOrganization_ and uncommenting the _createAmplifyTeam_ procedure

## Let's try

The script can run either on a Linux machine or under windows Cygwin. In both cases, a browser windows will popup for the user to enter his credentials.

In the script directory you will find the script to run: `createPlatformTeamFromV7Org.sh`

Execution sample:

```bash
$ ./createPlatformTeamFromV7Org.sh

==============================================================================
== Creating Amplify platform team from the organization name in API Manager ==
== API Manager access and Amplify Platform access are required              ==
== curl and jq programs are required                                        ==
==============================================================================

Checking pre-requisites (axway CLI, curl and jq)
All pre-requisites are available

Connecting to Amplify platform with Axway CLI
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Launching web browser to login...
You are logged into a platform account in organization RnD-CB (a1d6e0a8***********) as cbo@XXXX.
The current region is set to US.

ORGANIZATION                                  GUID                                  ORG ID
RnD-CB                                        a1d6e0a8***********  88933*******

"RND-CB" ROLES          DESCRIPTION             TYPE
  administrator         Administrator           Platform
  ars_admin             Runtime Services Admin  Service
  api_central_admin     Central Admin           Service
  auditor               Auditor                 Service
  analytics_specialist  Analytics Specialist    Service

"RND-CB" TEAMS     GUID                                  ROLE
  Community        d2263946-aa35-4401-9f30-7b4218552560  administrator

This account has been set as the default.

Retrieving the organization ID...
Done

Getting API Manager host and port...
API Manager host name: lbean018.lab.phx.axway.int
API Manager port number: 8075
Getting API Manager credentials (ie a user that have API Manager administrator rights)...
Username: ApiAdmin
Password: ***************

Do you want to create team from disabled organization? [y|N]N

Creating the teams
Removing dissabled organizations from the organization list
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  3372    0  3372    0     0   8086      0 --:--:-- --:--:-- --:--:--  8086

Creating team with description.
axway team create 88933******* API Development --desc API Development project
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Account:      amplify-cli:cbo@XXXX
Organization: RnD-CB (a1d6e0a8***********)

Successfully created team API Development (1e706edc-1417-4d7d-ab54-455883e056a0)
Tagging the team based on the API Development toggle true
axway team update 88933******* API Development --tag API development
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Creating team without description.
axway team create 88933******* Healthcare
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Account:      amplify-cli:cbo@XXXX
Organization: RnD-CB (a1d6e0a8***********)

Successfully created team Healthcare (4ba30d10-403d-44bb-a12a-d9d94e60776f)
Tagging the team based on the API Development toggle true
axway team update 88933******* Healthcare --tag API development
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Creating team without description.
axway team create 88933******* Consumer1
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Account:      amplify-cli:cbo@XXXX
Organization: RnD-CB (a1d6e0a8***********)

Successfully created team Consumer1 (4253fe80-5be7-465f-909d-edb0e298a70e)
Tagging the team based on the API Development toggle false
axway team update 88933******* Consumer1 --tag Consumer
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Creating team without description.
axway team create 88933******* BPCE
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Account:      amplify-cli:cbo@XXXX
Organization: RnD-CB (a1d6e0a8***********)

Successfully created team BPCE (ec745a7c-d78e-4161-bd3c-6e29f717cbfd)
Tagging the team based on the API Development toggle true
axway team update 88933******* BPCE --tag API development
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Done.

```

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

The program will list all organizations the user is able to see and for each of them will create a corresponding Amplify team. The name of the team is the organization name and the description of the team is the organization description

## Let's try

The script can run either on a Linux machine or under windows cygwin. In both cases, a browser windows will popup for the user to enter hs credentials.

In the script directory you will find the script to run: `createPlatformTeamFromV7Org.sh`

Excecution sample:

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
You are logged into a platform account in organization RnD-CB (a1d6e0a8-131f-4c1c-9d47-b4b357d00294) as cbordier@axway.com.
The current region is set to US.

ORGANIZATION                                  GUID                                  ORG ID
ΓêÜ RnD-CB                                      a1d6e0a8-131f-4c1c-9d47-b4b357d00294  889336692462686
  Agent Blitz                                 cb44b368-6950-45c6-8115-1bf8420ff86d  351659748418642
  Axway                                       a2275336-f9b1-42a5-87a1-8908abf209fb  100094705
  BPCE_POC_PinkFloyd                          07232eec-9c9b-47c8-ad91-6bd267ca1b63  658444849066458
  EU org - RnD testing                        c296cce5-6409-4974-9c27-47b4668f32e9  247719145165135
  Griffin Corp.                               7b782b4c-62e9-4721-b881-b6a5e4610a6f  613867752138776
  Open Everything Corp                        6afd1b18-f20e-457a-8b04-ec5ba5db4c1e  163827132163160
  Vertex_Axway                                fc49439b-aa3f-4f77-97ae-6debcb229d57  694315275401389

"RND-CB" ROLES          DESCRIPTION             TYPE
  administrator         Administrator           Platform
  ars_admin             Runtime Services Admin  Service
  api_central_admin     Central Admin           Service
  auditor               Auditor                 Service
  analytics_specialist  Analytics Specialist    Service

"RND-CB" TEAMS     GUID                                  ROLE
  Community        d2263946-aa35-4401-9f30-7b4218552560  administrator
ΓêÜ API Development  d9120f39-88d1-4977-bc56-5dd7d7335a18  administrator
  External         68769167-ad1f-46ec-b902-0f52906cb1e6  administrator
  HealthCare       37cea73d-9d63-4a7b-ad69-4b79e8b4a2b7  administrator

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
axway team create 889336692462686 API Development --desc API Developement project
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Account:      amplify-cli:cbordier@axway.com
Organization: RnD-CB (a1d6e0a8-131f-4c1c-9d47-b4b357d00294)

Successfully created team API Development (1e706edc-1417-4d7d-ab54-455883e056a0)
Creating team without description.
axway team create 889336692462686 Healthcare
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Account:      amplify-cli:cbordier@axway.com
Organization: RnD-CB (a1d6e0a8-131f-4c1c-9d47-b4b357d00294)

Successfully created team Healthcare (4ba30d10-403d-44bb-a12a-d9d94e60776f)
Creating team without description.
axway team create 889336692462686 Conumer1
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Account:      amplify-cli:cbordier@axway.com
Organization: RnD-CB (a1d6e0a8-131f-4c1c-9d47-b4b357d00294)

Successfully created team Conumer1 (4253fe80-5be7-465f-909d-edb0e298a70e)
Creating team without description.
axway team create 889336692462686 BPCE
AXWAY CLI, version 3.1.0
Copyright (c) 2018-2021, Axway, Inc. All Rights Reserved.

Account:      amplify-cli:cbordier@axway.com
Organization: RnD-CB (a1d6e0a8-131f-4c1c-9d47-b4b357d00294)

Successfully created team BPCE (ec745a7c-d78e-4161-bd3c-6e29f717cbfd)
Done.

```

# MSMG Data - Platform Engineer Recruitment Test
Thank you for taking the time to apply to Moneysupermarket Group as a Platform Engineer!

## Process

The next stage of the interview process involves some live code pairing.
To prepare for this, you have 2 options, pick which ever option you are most comfortable with:

### Option 1. Prepare only
- Read and understand the [Problem Statement](#problem-statement)
- Set up your favourite IDE with Terraform and install relevant provider(s)
- Think about how you plan on implementing a solution to the problem

In the code pairing session, we will start coding the solution 

### Option 2. Spend an hour or two implementing a solution
- Complete all the above steps in 'Option 1. Prepare only'
- Start coding your solution 

In the code pairing session, we will talk about what you have done so far, then continue coding or add a new feature.



## Problem Statement

Your task is to deploy and publically expose a simple web frontend and api, backed by a postgres database.

Application to deploy: https://github.com/hay-kot/mealie


## Top tips

Your solution should:
* demonstrate networking and security best practices
* use GCP / AWS as the cloud infrastructure provider
* use the cloud services of your choice (serverless or otherwise)
* use Terraform for IAC
* use prebuilt container images


We value the following things in infrastructure code:
* readability
* well architected / separated
* maintainability, can it be extended
* portability

We prefer a minimal working solution that demonstates best practice over a bunch of bells and whistles held together with duct tape


## Bonus Points
* If you use a cloud secret manager for encrypting sensitive information.
* If you can generate the self signed cert/key.
* If there is a pathway to high availability



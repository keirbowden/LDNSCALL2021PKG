# London's Calling 21 - Packages for the Masses

Repository for the org-dependent package demonstrated in my London's Calling 2021 session.

## Installation

### Pre-requisites

Install the metadata from the "Happy Soup" repository for this session, which you can find at [bobbuzz.me.uk/LC2021MAIN](bobbuzz.me.uk/LC2021MAIN)

### Instructions

This package must be installed using the Salesforce CLI. Execute the following command to install it:

`sfdx force:package:install -w 30 -p 04t4L000000Y29XQAS -u <username>`

where `<username>` is the username for the org you want to install the package into, that you have previously authenticated using the CLI.

## Setup

Assign the `Bookstore with Readings` permission set group to your user.

Create the sample data using the following command:

`sfdx force:apex:execute -f ./scripts/apex/setup_data.apex -u <username>`

where `<username>` is the username for the org you want to create the sample data in, that you have previously authenticated using the CLI.

## Accessing

Open the `Bookstore with Readings` application 

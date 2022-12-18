
# Creating servers in Intersight using Terraform Cloud for Business

This module uses the "intersight_bulk_mo_cloner" to derive Server profiles by cloning the server template
# Primary problem with merger - Won't remove actual server profiles created, but will remove references in State
    This means if you create 2, then change to 1, then try to go back to 2 ... It will error out w/ duplicate object exists
    All servers created by cloner must be manually deleted to be removed (Maybe a good thing), could result in State Errors.
    Once the error has been created, deleting the conflicting server.profile is the easiest way to resolve.
# Primary Advantage of Merger is:
    The derived server.profile's have all Policies associated, as in Profile Template and has Identities assigned

Module Example Location:
https://github.com/bywhite/cen-iac-imm-dev-pod1-mods/imm-pod-servers-vmw-cloner-mod


Error: error occurred while creating BulkMoCloner: 409 Conflict Response from endpoint: {
│   "Responses": [
│     {
│       "ObjectType": "bulk.RestResult",
│       "ClassId": "bulk.RestResult",
│       "Status": 409,
│       "Body": "{\"code\":\"ValidationConflict\",\"message\":\"Cannot create or modify the object. A managed object with the same identifying criteria already exists.\",\"messageId\":\"barcelona_request_uniqueness_constraint_validation_conflict\",\"messageParams\":{},\"traceId\":\"wFJA-QgmYnwMWxDjFNy1mNfvO9mSDFyGVCKQ3waPKBwi0tmHCoOrtQ==\"}"
│     }
│   ],
│   "Sources": [
│     {
│       "ClassId": "",
│       "Moid": "639f44ec77696e2d31207bc7",
│       "ObjectType": "server.ProfileTemplate"
│     }
│   ],
│   "Targets": [
│     {
│       "ClassId": "",
│       "Moid": "",
│       "Name": "ofl-dev-pod1-vmw-cloner-server-2",
│       "ObjectType": "server.Profile"
│     }
│   ]
│ }
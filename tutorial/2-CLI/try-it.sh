#!/bin/sh

#
# Step 1: create the application
#

oc new-app https://github.com/rbrazioli/nodejs-ex --name nodejs-mongodb-ex-cli

#
# Step 2: create route
#  check service name by "oc get services"
#

oc expose service/nodejs-mongodb-ex-cli

# check result with oc get routes

#
# Step 3: add a persistency layer (MongoDB)
#

oc new-app mongodb-persistent \
-p MONGODB_USER=admin \
-p MONGODB_PASSWORD=secret \
-p MONGODB_ADMIN_PASSWORD=super-secret

#
# Step 4: bind persistency service to application services, by setting
# an environment variable
#

oc set env dc/nodejs-mongodb-ex-cli \
  MONGO_URL='mongodb://admin:secret@mongodb:27017/sampledb'

# for some reason, the deployment fails since the previous is not stopped
# it may be a limit of the base application#
#

#
# Step 4: Configura automated builds
#

# get Webhook url

oc describe buildConfig nodejs-mongodb-ex-cli

# https://api.starter-us-east-1.openshift.com:443/apis/build.openshift.io/v1/namespaces/reb-ex/buildconfigs/nodejs-mongodb-ex-cli/webhooks/8HrymPCP1uMf4WfGhNlM/github

# edit "index.htl" and push changes in github

# Success in the end, but needed to manually stop running services (pods)

#!/usr/bin/env bash

# Checks docker is running before cleaning the existing files
if ! docker info > /dev/null 2>&1; then
  echo "This script uses docker, and it isn't running - please start docker and try again!"
  exit 1
fi

# Cleans the existing files to avoid old/deleted models
rm -rf '.\App-api\'
rm -rf '.\App-api\apis\'
rm -rf '.\App-api\models\'
rm '.\App-api\index.ts'
rm '.\App-api\runtime.ts'

# Fetches and runs the container and generates all the models.
# Be aware that the "NoContent" ASP.Net Core ResponseType is not supported.
docker run \
--rm \
--network host \
-e JAVA_OPTS="-Dio.swagger.parser.util.RemoteUrl.trustAll=true -Dio.swagger.v3.parser.util.RemoteUrl.trustAll=true" \
-e TRUST_ALL=true \
-v  $(pwd):/local \
openapitools/openapi-generator-cli generate \
-i https://petstore.swagger.io/v2/swagger.yaml \
-g typescript-fetch \
-o /local/App-api \
--skip-validate-spec

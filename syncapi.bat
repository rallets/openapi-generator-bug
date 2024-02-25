@ECHO OFF
REM Checks docker is running before cleaning the existing files
docker container ls
IF %ERRORLEVEL% NEQ 0 (
  EXIT /B
)

REM Cleans the existing files to avoid old/deleted models
rmdir /s /q ".\App-api\.openapi-generator\"
rmdir /s /q ".\App-api\apis\"
rmdir /s /q ".\App-api\models\"
del ".\App-api\index.ts"
del ".\App-api\runtime.ts"

REM Fetches and runs the container and generates all the models.
REM Be aware that the "NoContent" ASP.Net Core ResponseType is not supported.
docker run ^
--rm ^
--network host ^
-e JAVA_OPTS="-Dio.swagger.parser.util.RemoteUrl.trustAll=true -Dio.swagger.v3.parser.util.RemoteUrl.trustAll=true" ^
-e TRUST_ALL=true ^
-v  %cd%:/local ^
openapitools/openapi-generator-cli:latest generate ^
-i https://petstore.swagger.io/v2/swagger.yaml ^
-g typescript-fetch ^
-o /local/App-api ^
--skip-validate-spec

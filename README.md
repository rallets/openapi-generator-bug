# openapi-generator-bug

Repro for the bug #[17958](https://github.com/OpenAPITools/openapi-generator/issues/17958) in `openapi-generator CLI` using the generator `typescript-fetch`.

## Bug description

I'm excluding some `apis` and `models` using `.openapi-generator-ignore`.

The apis and models are filtered correctly, but the `apis/index.ts` and `models/index.ts` files contain the import of ALL the possible files, filtered or not.

This is breaking the typescript build.

## Run in Windows

- Run `Docker Desktop` (or similar).

> syncapi.bat

## Run in MacOs/Linux

NB. I don't have a unix machine to test the script. So it could need some adjustements.

- Run `Docker Desktop` (or similar).

> syncapi.sh

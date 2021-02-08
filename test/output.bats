#!/usr/bin/env bats
load common

@test "template the app ingress in app-group network in the layer-base namespace and verify the output" {
  korgi apply -n layer-base -e migration-dev --app ingress network  --dry-run --output-dir /tmp/korgi
  run yq compare -j /korgi-test/resources/ingress-raw.yaml $(find /tmp/korgi  -path '*/layer-base/network/ingress/ingress-*-ingress-examples/raw/templates/resources.yaml')
  [ "$status" -eq 0 ]
}


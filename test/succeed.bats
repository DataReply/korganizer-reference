setup() {
  gpg --import /korgi/keys/public
  gpg --allow-secret-key-import --import  /korgi/keys/private.key
  }

@test "template the layer-infra namespace succeeds" {
  run korgi apply-namespace -e client-prod layer-infra --dry-run
  [ "$status" -eq 0 ]
}

@test "template the layer-base namespace succeeds" {
  run korgi apply-namespace -e migration-dev layer-base --dry-run
  [ "$status" -eq 0 ]
}

@test "template the app-group monitoring in the layer-base namespace succeeds" {
  run korgi apply -n layer-base -e migration-dev monitoring --dry-run
  [ "$status" -eq 0 ]
}

@test "template the app ingress in app-group network in the layer-base namespace succeeds" {
  run korgi apply -n layer-base -e migration-dev --app ingress network  --dry-run
  [ "$status" -eq 0 ]
}


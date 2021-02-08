setup() {
  gpg --import /korgi/keys/public
  gpg --allow-secret-key-import --import  /korgi/keys/private.key
  }

@test "template the layer-infra namespace" {
  run korgi apply-namespace -e client-prod layer-infra --dry-run
  [ "$status" -eq 0 ]
}
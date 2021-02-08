setup() {
  gpg --import /korgi/keys/public
  gpg --allow-secret-key-import --import  /korgi/keys/private.key
}

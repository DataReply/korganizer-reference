# Walkthrough


1. Install korgi and its dependencies:

- [Korgi](https://github.com/DataReply/korgi)
- [Helm](https://helm.sh/docs/intro/install/)
- [Helmfile](https://github.com/roboll/helmfile)
- [kapp](https://github.com/vmware-tanzu/carvel-kapp)
- [SOPS](https://github.com/mozilla/sops) (optional for secret management)
- [helm secrets](https://github.com/jkroepke/helm-secrets) (optional for secret management)

Alternatively, you can run the basic functionality inside a Docker container that can be run and tested through: 
```
make build
make shell
```

2. To template or apply releases that reference secrets, you will need to import the gpg key pair located in `doc/keys`.
```
gpg --import ./doc/keys/public
gpg --allow-secret-key-import --import  ./doc/keys/private.key
```

3. Before using korgi to actually deploy releases to a kubernetes cluster, we can use the `--dry-run` option that will template only.

```
korgi apply-namespace -e migration-dev layer-base --dry-run
korgi apply-namespace -e client-prod layer-infra --dry-run

```
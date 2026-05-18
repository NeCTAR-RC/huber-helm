# huber-helm

A Helm chart for [huber](https://github.com/NeCTAR-RC/huber), a Nectar
notification listener that consumes events from the OpenStack message
bus and dispatches them to configurable handlers.

## Installing

The chart depends on the `nectarlib` library chart hosted on the Nectar
OCI registry. Pull dependencies before installing:

```sh
helm dependency update
helm install huber . -n huber --create-namespace -f my-values.yaml
```

## Configuration

Values are grouped under `conf.*` and rendered into `huber.conf` via the
ConfigMap. Secrets (`transport_url`, keystone password) are injected at
runtime by the Vault agent — configure `vault.settings_secret` to point
at the secret path.

| Key | Default | Description |
| --- | --- | --- |
| `conf.debug` | `false` | Enable debug logging in the `[DEFAULT]` group |
| `conf.keystone.auth_url` | _(none)_ | Keystone auth URL |
| `conf.keystone.username` | `huber` | Service user |
| `conf.keystone.project_name` | `service` | Service project |
| `conf.keystone.memcached_servers` | `[]` | Memcached servers for token caching |
| `conf.notification.exchange` | `ceilometer` | RabbitMQ exchange to listen on |
| `conf.notification.topic` | `huber` | Notification topic |
| `conf.notification.pool` | `huber` | Listener pool name |
| `conf.handlers.enabled` | `[]` | Handler entry points to load (e.g. `logging`, `project_membership`) |
| `conf.project_membership.subject` | `Nectar project role change` | Email subject for the `project_membership` handler |
| `conf.project_membership.tenantmanager_role` | `tenantmanager` | Role name for project managers |
| `conf.project_membership.member_role` | `member` | Role name for project members |
| `vault.role` | `k8s` | Vault Kubernetes auth role |
| `vault.settings_secret` | `path/to/secret/in/vault` | Vault KV path for runtime secrets |
| `notification.replicaCount` | `1` | Number of notification listener replicas |
| `notification.image.repository` | `registry.rc.nectar.org.au/nectar/huber` | Image repository |

See `values.yaml` for the full list of tunables.

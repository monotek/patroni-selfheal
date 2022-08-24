# patroni self heal

Checks patroni status and if state is "start failed" deletes the pod so it can recover on restart. 

Needed as postgres-operator does no support liveness probe.

The sidecar needs the following additional rbac config (serviceaccount should already exist):

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: postgres-pod-delete
  namespace: your-namespace
subjects:
  - kind: ServiceAccount
    name: postgres-pod
roleRef:
  kind: Role
  name: postgres-pod-delete
  apiGroup: rbac.authorization.k8s.io
```

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: postgres-pod-delete
  namespace: your-namespace
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["delete"]
```

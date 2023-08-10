---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: apps
  namespace: flux-system
spec:
  dependsOn:
    - name: infra-configs
  interval: 1h
  retryInterval: 2m
  timeout: 5m
  prune: true
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: ./apps


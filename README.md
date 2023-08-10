# flux-workshop-2023

## Prerequisites

### Kubernetes

You will need a Kubernetes cluster version 1.24 or newer.
For a quick local test, you can use [Kubernetes kind](https://kind.sigs.k8s.io/docs/user/quick-start/).
Any other Kubernetes setup will work as well though.

Create a cluster called `staging` with the kind CLI:

```shell
kind create cluster --name staging
```

### Flux CLI

Install the Flux CLI on MacOS or Linux using Homebrew:

```sh
brew install fluxcd/tap/flux
```

For other installation methods please see [fluxcd.io/flux/installation](https://fluxcd.io/flux/installation/).

### GitHub Personal Access Token

In order to follow the workshop you'll need a GitHub account and a
[personal access token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)
that can create repositories (check all permissions under `repo`).

Add the GitHub PAT and username to your shell environment:

```sh
export GITHUB_TOKEN=<your-token>
export GITHUB_USER=<your-username>
```

### GitHub Repository

Fork the workshop repository on your personal account and clone it locally:

```shell
git clone https://github.com/${GITHUB_USER}/flux-workshop-2023.git
cd flux-workshop-2023
```

## Bootstrap

Install the Flux controllers on the staging cluster:

```shell
flux bootstrap github \
    --owner=${GITHUB_USER} \
    --repository=flux-workshop-2023 \
    --branch=main \
    --personal \
    --path=clusters/staging
```

Pull the changes locally:

```shell
git pull
```

Inspect the Flux manifests generated in the repo:

```shell
tree ./clusters
```

## Install the Flux UI

Rename the `infrastructure.yaml.x` to `infrastructure.yaml` in the `clusters/staging` directory,
then commit the changes and push them upstream.

Wait for Flux to reconcile the infra Kustomizations:

```shell
flux get kustomizations --watch
```

To access the Flux UI, first start port forwarding with:

```sh
kubectl -n flux-system port-forward svc/weave-gitops 9001:9001
```

Navigate to http://localhost:9001 and login using the username `admin` and the password `flux`.

## Install the demo app

Rename the `apps.yaml.x` to `apps.yaml` in the `clusters/staging` directory,
then commit the changes and push them upstream.

Wait for Flux to reconcile the apps Kustomizations:

```shell
flux get kustomizations --watch
```

## Enable continuous deployment

Edit the `podinfo.yaml` file from the `apps` directory, and change the `tag: 6.4.0` to `semver: 6.4.x`.
Commit the changes and push them upstream.

Navigate to `Applications > podinfo` in the Flux UI and watch the app being upgraded to the latest version.

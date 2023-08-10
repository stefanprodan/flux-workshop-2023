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

## Bootstrap

Install Flux on the staging cluster:

```sh
flux bootstrap github \
    --owner=${GITHUB_USER} \
    --repository=flux-workshop-2023 \
    --branch=staging \
    --personal \
    --path=clusters/staging
```


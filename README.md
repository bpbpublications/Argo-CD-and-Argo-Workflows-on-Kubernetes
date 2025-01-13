# argo

alias bashly='docker run --platform "linux/amd64" --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly'

bashly generate




# MiniArgo

MiniArgo is a comprehensive tool for managing Argo CD, Argo Workflows, Argo Events, and related Kubernetes clusters using Minikube. It simplifies the process of setting up and managing Argo projects in a local development environment.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Usage](#usage)
4. [Commands](#commands)
5. [Configuration](#configuration)
6. [Shell Completion](#shell-completion)
7. [Troubleshooting](#troubleshooting)
8. [Contributing](#contributing)
9. [License](#license)

## Prerequisites

Before using MiniArgo, ensure you have the following tools installed:

- Docker
- Minikube
- kubectl
- Helm (optional, for some features)

## Installation

1. Clone the MiniArgo repository:
   ```
   git clone https://github.com/<adjustit>/miniargo.git
   cd miniargo
   ```

2. Make the script executable:
   ```
   chmod +x miniargo
   ```

3. (Optional) Add MiniArgo to your PATH for easier access:
   ```
   export PATH=$PATH:/path/to/miniargo
   ```

## Usage

MiniArgo provides a set of commands to manage your Argo environment. Here's a basic usage example:

```
./miniargo start argocd-cluster
./miniargo install argocd
./miniargo expose argocd-server
```

## Commands

MiniArgo supports the following main commands:

- `start`: Start a specific cluster (e.g., argocd-cluster, apps-cluster)
- `install`: Install components (e.g., argocd, argo-workflow)
- `expose`: Expose services (e.g., argocd-server)
- `delete`: Delete clusters
- `configure`: Configure components (e.g., argocd-notifications)

For a full list of commands and their usage, run:

```
./miniargo --help
```

## Configuration

MiniArgo uses environment variables for configuration. Key variables include:

- `GITHUB_TOKEN`: Your GitHub personal access token
- `DOCKERHUB_USERNAME`: Your Docker Hub username
- `DOCKERHUB_TOKEN`: Your Docker Hub access token
- `SLACK_TOKEN`: Slack token for notifications
- `TELEGRAM_TOKEN`: Telegram token for notifications

Set these variables in your shell or in a `.env` file before running MiniArgo.

## Shell Completion

MiniArgo supports shell completions for Bash and Zsh. To set up completions:

1. Generate the completion script:
   ```
   make generate-completions
   ```

2. Install completions (for both Bash and Zsh):
   ```
   make install-completions
   ```

   Or, install for a specific shell:
   ```
   make install-bash-completion
   ```
   ```
   make install-zsh-completion
   ```

3. Restart your shell or source the completion file.


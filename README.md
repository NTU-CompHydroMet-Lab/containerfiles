# Development Container Environment

This repository provides containerized development environments using Podman with CUDA support, Python 3.13, and development tools.

## What's Included

- **Base Images**: CUDA-enabled containers with Python development tools
- **Development Environment**: Pre-configured with zsh, neovim, Claude Code CLI, and more
- **GPU Support**: NVIDIA GPU access for CUDA development
- **Package Management**: UV package manager for fast Python dependency installation

## Getting Started

See the [example](./example) directory for:
- Complete setup instructions
- How to open containers in VS Code
- Configuration examples
- Usage tips

## Directory Structure

```
.
├── compose.yml              # Container orchestration configuration
├── library/devel/           # Base container image
├── kilin/devel/             # Extended development image
└── example/                 # Setup guides and examples
```

## Requirements

- Remote machine with Podman installed
- SSH access to the remote machine

# Development Container Setup

This project uses Docker Compose to provide a consistent development environment with CUDA support, Python 3.13, and development tools.

## Prerequisites

- Docker or Podman with Docker Compose support
- NVIDIA GPU with drivers installed (for CUDA support)
- VS Code with the following extensions:
  - [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) (ms-vscode-remote.remote-containers)
  - [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) (optional, for managing containers)

## Quick Start

### 1. Set Environment Variables

Create a `.env` file in the project root:

```bash
# Required: Your Anthropic API key for Claude Code
ANTHRPOIC_API_KEY=your_api_key_here

# Optional: Will default to your current user if not set
USER=${USER}
```

### 2. Using with VS Code Dev Containers

#### Option A: Attach to Running Container (Recommended)

1. Start the container:
   ```bash
   docker compose up -d
   ```

2. In VS Code:
   - Press `F1` or `Ctrl+Shift+P` (Windows/Linux) / `Cmd+Shift+P` (Mac)
   - Type: `Dev Containers: Attach to Running Container...`
   - Select your container (e.g., `yourname-cont`)

3. VS Code will reload and connect to the container. Open `/workspace` as your working directory.

#### Option B: Use devcontainer.json (Alternative)

Create `.devcontainer/devcontainer.json`:

```json
{
  "name": "Development",
  "dockerComposeFile": "../compose.yml",
  "service": "dev",
  "workspaceFolder": "/workspace",
  "overrideCommand": false,
  "customizations": {
    "vscode": {
      "settings": {
        "terminal.integrated.defaultProfile.linux": "zsh"
      }
    }
  },
}
```

Then:
- Press `F1` → `Dev Containers: Reopen in Container`

### 3. Manual Container Usage

```bash
# Start the container
docker compose up -d

# Attach to the container
docker compose exec dev zsh

# Stop the container
docker compose down

# Rebuild after Containerfile changes
docker compose build --no-cache
```

## Container Features

### Installed Tools

- **Python 3.13** with UV package manager
- **CUDA 13.1** development toolkit
- **Development tools**: git, vim, tmux, neovim (0.11.5)
- **Shell**: zsh with Oh-My-Zsh and Powerlevel10k theme
- **AI tools**: Claude Code CLI
- **Monitoring**: htop, nvtop (GPU monitoring)
- **Search tools**: fzf, fd-find, ripgrep

### Environment Variables

- `VIRTUAL_ENV=/opt/venv` - Python virtual environment
- `UV_CACHE_DIR=/opt/uv-cache` - UV package cache (mounted for persistence)
- `SHELL=/usr/bin/zsh` - Default shell
- `ANTHROPIC_API_KEY` - Claude API key (from .env)

### Volume Mounts

| Host Path | Container Path | Purpose | Mode |
|-----------|----------------|---------|------|
| `${HOME}` | `${HOME}` | Your home directory (configs, ssh keys, etc.) | Read-Write |
| `.` (project root) | `/workspace` | Project files | Read-Write |
| `/home/NAS/data` | `/home/NAS/data` | NAS shared data | Read-Only |
| `/home/NAS/homes` | `/home/NAS/homes` | NAS home directories | Read-Write |
| `${HOME}/.cache/uv` | `/opt/uv-cache` | UV package cache | Read-Write |

## Python Development

### Using UV Package Manager

```bash
# Install packages
uv pip install package-name

# Install from requirements.txt
uv pip install -r requirements.txt

# Create a new project
uv init myproject

# Run Python scripts
python script.py
```

### Virtual Environment

The container comes with a pre-configured virtual environment at `/opt/venv`. It's automatically activated via the `PATH` environment variable.

## GPU Access

The container has access to all NVIDIA GPUs via the `nvidia.com/gpu=all` device configuration.

```bash
# Check GPU availability
nvidia-smi

# Monitor GPU in real-time
nvtop
```

## Using Claude Code

Claude Code CLI is pre-installed and uses the API key from your `.env` file:

```bash
# Start Claude Code
claude

# Run with specific model
claude --model opus

# Get help
claude --help
```

## Customization

### Adding VS Code Extensions

Edit `.devcontainer/devcontainer.json` and add extensions to the `extensions` array:

```json
"extensions": [
  "ms-python.python",
  "github.copilot",
  "eamodio.gitlens"
]
```

### Installing Additional Tools

Edit the Containerfile and rebuild:

```bash
docker compose build --no-cache
docker compose up -d
```

## Troubleshooting

### Container won't start

```bash
# Check logs
docker compose logs

# Ensure GPU drivers are working
nvidia-smi
```

### Git ownership warnings

If you see git warnings about dubious ownership:

```bash
git config --global --add safe.directory /workspace
```

### VS Code can't find Python interpreter

Manually set the interpreter:
- Press `F1` → `Python: Select Interpreter`
- Choose `/opt/venv/bin/python`

## Tips

1. **Shell configuration**: Your `~/.zshrc` from the host is available in the container due to the home directory mount.

2. **SSH keys**: Your SSH keys from `~/.ssh` are automatically available for git operations.

3. **Git config**: Your `~/.gitconfig` is mounted, so all your git settings work in the container.

4. **Persistent cache**: UV package cache is mounted to `${HOME}/.cache/uv` for faster package installations across container rebuilds.

5. **Working with multiple terminals**: You can attach multiple VS Code windows or terminal sessions to the same container.

## Project Structure

```
.
├── compose.yml              # Docker Compose configuration
├── .env                     # Environment variables (create this)
├── library/
│   └── devel/
│       └── Containerfile    # Base development image
├── kilin/
│   └── devel/
│       ├── Containerfile    # Extended image with tools
│       └── entrypoint.sh    # Container startup script
└── README.md               # This file
```

## Building Custom Images

The setup uses a two-stage build:

1. **library/devel**: Base image with CUDA and Python
2. **kilin/devel**: Extended image with zsh, neovim, and Claude Code

To build and push to your registry:

```bash
# Build base image
cd library/devel
docker build -t registry.lab.wangup.org/library/devel:latest .

# Push to registry
docker push registry.lab.wangup.org/kilin/devel:0.2-cuda13.1
```

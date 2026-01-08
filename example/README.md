# How to Open a Development Container in VS Code

Follow these steps to set up and open your development container in VS Code.

## Step 1: SSH into the Remote Machine

1. Open your terminal or SSH client
2. Connect to the remote machine:
```bash
ssh your_username@remote_machine_address
```

The remote machine already has Podman installed for running containers.

## Step 2: Set Up Shell Configuration

Copy the provided `.zshrc` file to your home directory:

```bash
cd /path/to/this/repository/example
cp .zshrc ~/
```

## Step 3: Install VS Code and Extension

1. **VS Code**: Download from [code.visualstudio.com](https://code.visualstudio.com/)

2. **VS Code Extension**:
   - Open VS Code
   - Click the Extensions icon (or press `Ctrl+Shift+X`)
   - Search for "Dev Containers"
   - Install the extension: **Dev Containers** (by Microsoft)

## Step 4: Configure VS Code to Use Podman

1. In VS Code, press `F1` (or `Ctrl+Shift+P` on Windows/Linux, `Cmd+Shift+P` on Mac)
2. Type: `Preferences: Open User Settings (JSON)`
3. Add these lines to your settings:

```json
{
  "dev.containers.dockerPath": "podman",
  "dev.containers.dockerComposePath": "podman-compose"
}
```

4. Save the file

## Step 5: Copy Configuration Files to Your Project

Copy the container configuration files to your desired project directory:

```bash
cd /path/to/your/desired/project
cp /path/to/this/repository/compose.yml .
mkdir -p .devcontainer
cp /path/to/this/repository/.devcontainer/devcontainer.json .devcontainer/
```

## Step 6: Create Environment File (Optional)

If you need to use Claude Code or set custom variables, create a `.env` file:

1. Open the project folder in VS Code
2. Create a new file named `.env` in the project root folder
3. Add your configuration:

```bash
ANTHRPOIC_API_KEY=your_api_key_here
USER=${USER}
```

4. Save the file

## Step 7: Open the Container in VS Code

### 7.1 Open Your Project in VS Code

1. Open VS Code
2. Click "File" → "Open Folder" (or press `Ctrl+K Ctrl+O`)
3. Navigate to your project directory (where you copied the configuration files)
4. Click "Open"

### 7.2 Reopen in Container

1. Press `F1` (or `Ctrl+Shift+P` on Windows/Linux, `Cmd+Shift+P` on Mac)
2. Type: `Dev Containers: Reopen in Container`
3. Press `Enter`

### 7.3 Wait for Container to Build

VS Code will now:
1. Read your `compose.yml` and `.devcontainer/devcontainer.json` files
2. Pull the container image (first time only - this may take 5-10 minutes)
3. Build the container with your configuration
4. Start the container
5. Reload VS Code and connect to the container

You'll see a notification in the bottom-right corner showing the progress.

### 7.4 Verify You're Inside the Container

Once VS Code reloads:
1. Look at the bottom-left corner of VS Code
2. You should see a green indicator showing "Dev Container: Development"
3. Open a terminal (Terminal → New Terminal)
4. You should see a zsh prompt inside the container

You are now working inside the container!

## How to Stop Working in the Container

When you're done:

1. Press `F1`
2. Type: `Dev Containers: Reopen Folder Locally`
3. Press `Enter`

This closes the container connection. The container will stop automatically.

---

## What's Inside the Container?

Your development container includes:

- **Python 3.13** with UV package manager
- **CUDA 13.1** for GPU programming
- **Development tools**: git, vim, neovim, tmux
- **Shell**: zsh (a powerful command-line shell)
- **Claude Code CLI** for AI assistance
- **GPU monitoring tools**: nvidia-smi, nvtop

## Working with Python

The container has Python pre-installed with a virtual environment ready to use.

**Install Python packages:**
```bash
uv pip install package-name
```

**Run Python scripts:**
```bash
uv run python your_script.py
```

**Check GPU is available (if you have NVIDIA GPU):**
```bash
nvtop
```

## Additional Tips

**Your files are shared**: Any files you create in `/workspace` inside the container will appear in your project folder on your computer.

**Your settings are available**: Your git config and SSH keys from your computer are accessible in the container.

**To use multiple terminals**: You can open multiple VS Code windows and attach them all to the same container.


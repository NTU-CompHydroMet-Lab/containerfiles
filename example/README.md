# How to use this compose file? 

Follow these steps to set up and open your development container in VS Code.

## Step 1: SSH into the Remote Machine

SSH into your remote host machine. (For example up4090)  
The remote machine already has Podman installed for running containers.

## Step 2: Copy Configuration Files to Your Project

Copy the `compose.yml` files to your project directory:

## Step 3: Modify necessary configuration

1. SSH port (default 12345)
2. Container name

You should choose a free port as ssh port. You should also modify container   
name for your own idetification.

## Step 4: Start the container

```bash
cd ~/projects/myproject
podman compose up -d
```

## Step 5: Edit ~/.ssh/config on your computer 

```apacheconf
Host myproject
    HostName up4090
    User dani
    IdentityFile ~/.ssh/WangUp
    Port 12345
```

## Step 6: SSH into your project

Use VSCode or terminal to ssh into your project `myproject`

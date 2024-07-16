# new-machine

Basic setup script for getting a new \*nix machine setup.

# WSL Manual setup

Add the following to windows home:

```ssh.bat
C:\Windows\system32\wsl.exe ssh %*
```

Set VSCode's ssh command to the new bat file.

Copy WSL's ssh config to C:\Users\<your user>\.ssh\config periodically

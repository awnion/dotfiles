# WSL

## Set default user

### In wsl ubuntu

```bash
adduser ...
```

### In powershell

```bash
ubuntu config --default-user <username>
# or wsl -u <username>
```


## WSL backup

### Export

```powershell
wsl --export Ubuntu <path>
```

### Import

```powershell
wsl --import <Distro> <InstallLocation> <FileName> [Options]

#         Imports the specified tar file as a new distribution.
#         The filename can be - for standard input.

#         Options:
#             --version <Version>
#                 Specifies the version to use for the new distribution.
```

## Known problems

- [ ] ubuntu loses bash history
- [ ] missing antigen bundles

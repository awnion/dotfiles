[original post](https://dev.to/benjaminblack/signing-git-commits-with-modern-encryption-1koh)

# Main key

```bash
brew install gpg
gpg --full-generate-key --expert

# (9) ECC (sign and encrypt) *default*
# (1) Curve 25519 *default*
```

## Info

```bash
gpg --list-keys --keyid-format short
```

# Subkey

```bash
gpg --expert --edit-key <mainkey>
```

```output
gpg> addkey

Please select what kind of key you want:
...
  (10) ECC (sign only)
...
Your selection? 10
Please select which elliptic curve you want:
   (1) Curve 25519
...
Your selection? 1

gpg> save
```

# Finish

```bash
SIGN_KEY=<signkey>
git config --global user.signingkey $SIGN_KEY
gpg --armor --export $SIGN_KEY # add to github
```

# Misc

Add to `.gitconfig`: 

```toml
[include]
path=~/.gitsignkey
```

```bash
echo "[user]\nsigningkey = $SIGN_KEY" > ~/.gitsignkey
```

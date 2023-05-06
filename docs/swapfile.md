# Make or resize swapfile (Ubuntu)

```bash
free -h

# turn off swap
sudo swapoff /swap.img

# to create the SWAP file, you will need to use this.
sudo fallocate -l 42G /swap.img
# or "sudo dd if=/dev/zero of=/swap.img bs=1G count=4"

# secure swap.
sudo chown root:root /swap.img
sudo chmod 0600 /swap.img

# activate swap
sudo mkswap /swap.img
sudo swapon /swap.img

# confirm that the swap partition exists.
sudo swapon -s

# check your swap again
free -h
```

Links: <https://askubuntu.com/questions/927854/how-do-i-increase-the-size-of-swapfile-without-removing-it-in-the-terminal>

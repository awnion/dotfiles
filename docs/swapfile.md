# Make or resize swapfile (Ubuntu)

```bash
free -h

# turn off swap
sudo swapoff /swapfile

# to create the SWAP file, you will need to use this.
sudo fallocate -l 4G /swapfile
# or "sudo dd if=/dev/zero of=/swapfile bs=1G count=4"

# secure swap.
sudo chown root:root /swapfile
sudo chmod 0600 /swapfile

# activate swap
sudo mkswap /swapfile
sudo swapon /swapfile

# confirm that the swap partition exists.
sudo swapon -s

# check your swap again
free -h
```

Links: <https://askubuntu.com/questions/927854/how-do-i-increase-the-size-of-swapfile-without-removing-it-in-the-terminal>

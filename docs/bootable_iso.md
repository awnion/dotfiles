# Create bootable USB

## Find proper mount

```bash
df
# or
lsblk

# make `sudo umount /dev/sdb1` if needed
```

Note: If the USB drive has multiple partitions (e.g. `/dev/sdb1`, `/dev/sdb2`, etc.), you need to unmount all of them before formatting the drive.

## Format USB

```bash
sudo mkfs.vfat /dev/sdb
```

## Write an ISO to USB

```bash
sudo dd if=$(realpath ~/Downloads/pop-os_22.04_amd64_nvidia_25.iso) of=/dev/sdb bs=10M conv=noerror status=progress
```

# Export wifi passwords from NetworkManager

```bash
cd /etc/NetworkManager/system-connections
for i in *.nm*; do 
  a=${i//.nmconnection}
  echo $a
  echo `nmcli --show-secrets connection show id $a | grep .psk: | awk '{print $2}'`
  echo '=============='
done
```


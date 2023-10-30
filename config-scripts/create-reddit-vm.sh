yc compute instance create   --name reddit-app   --hostname reddit-app \
  --create-boot-disk name=disk1,image-id=fd8o2lbevo0gmmd691kt \
  --metadata serial-port-enable=1 \
  --zone ru-central1-a \
  --public-ip

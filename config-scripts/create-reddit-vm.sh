#!/bin/bash

yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --platform-id "standard-v3" \
  --cores 2 \
  --memory 2G \
  --create-boot-disk image-id=fd8ild331mtkccrnjkao,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --zone ru-central1-a \
  --metadata-from-file user-data=./metadata_packer.yml

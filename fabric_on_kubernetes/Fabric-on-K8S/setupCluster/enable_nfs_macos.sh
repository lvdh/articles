#!/usr/bin/env bash

# Configure and start a local NFS server
# As tested on Mac OS X 10.10.5

USER_ID=501
LOCAL_SHARE=/opt/share
NFS_EXPORTS_FILE=/etc/exports

echo " >>> Ensure nfsd is stopped ..."
sudo nfsd stop
sleep 1

echo " >>> Configure nfsd ..."
echo "${LOCAL_SHARE} -mapall=${USER_ID} -alldirs" | sudo tee ${NFS_EXPORTS}

echo " >>> (Re)start nfsd ..."
sudo nfsd start

echo " >>> Exported shares:"
while ! sudo showmount -e 2>/dev/null
do
  echo " >>>  Waiting for NFS to come up..."
  sleep 2
done

echo " >>> All done."

exit 0

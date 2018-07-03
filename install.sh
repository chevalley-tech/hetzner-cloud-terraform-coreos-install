#!/usr/bin/env sh

set -e

echo "Installing coreos-install..."
wget https://raw.github.com/coreos/init/master/bin/coreos-install
chmod +x coreos-install

echo "Installing ct..."
wget https://github.com/coreos/container-linux-config-transpiler/releases/download/v0.8.0/ct-v0.8.0-x86_64-unknown-linux-gnu
mv ct-v0.8.0-x86_64-unknown-linux-gnu ct
chmod +x ct

./ct -in-file /root/ignition.yml -out-file /root/ignition.json
./coreos-install -d /dev/sda -i /root/ignition.json
reboot

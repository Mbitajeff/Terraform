#!/bin/bash
set -ex

apt-get update -y
apt-get install -y apache2
echo "<h1>Hello World v2 — served by $(hostname -f)</h1>" > /var/www/html/index.html
systemctl enable apache2
systemctl start apache2

#!/bin/bash
cat > /index.html <<HTML
<h1>Hello World ${app_version}</h1>
HTML

nohup busybox httpd -f -p ${server_port} &

#!/bin/bash -e

readonly url=http://localhost
readonly tmp_file=index
wget -q --retry-connrefused --waitretry=10 --timeout=20 --tries=10 -O "/tmp/$tmp_file" "$url"
cd /tmp && sha256sum "$tmp_file"
cat "/tmp/$tmp_file" | grep "Welcome to nginx"

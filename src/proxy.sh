#!/bin/bash

export http_proxy=http://127.0.0.1:1087
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

git config --global http.proxy http://127.0.0.1:1087
git config --global https.proxy https://127.0.0.1:1087

#!/bin/bash


unset http_proxy
unset https_proxy
unset ftp_proxy
unset rsync_proxy
unset no_proxy


git config --global --unset http.proxy
git config --global --unset https.proxy

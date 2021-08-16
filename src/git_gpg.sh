#!/usr/bin/env bash

PROJECT_F="${PWD}/.git/config"

if [ ! -f "$PROJECT_F" ];
then
  echo "Not found .git/config"
  exit 1;
fi

EMAIL="better.sunjian@gmail.com"
NAME="danielsss"
AUTO_SIGN=1
SIGNING_KEY=$(gpg --list-secret-keys --keyid-format LONG ${EMAIL} | grep "sec" | awk '{print $2}' | awk -F/ '{print $2}')


if [ ! -x $(which gpg) ];
then
  echo "Not found command 'gpg'"
  exit 1;
fi

echo "Set user.name = ${NAME}"
git config --local user.name ${NAME}

echo "Set user.email = ${EMAIL}"
git config --local user.email ${EMAIL}

echo "Set commit.gpgsign = 'true'"
git config --local commit.gpgsign "true"

echo "Set user.signingkey = ${SIGNING_KEY}"
git config --local user.signingkey ${SIGNING_KEY}

echo "done ..."

#!/usr/bin/env bash

if [ $# -lt 2 ];
then
  echo "Usage: ./git_gpg.sh --user='string value' --email='string value'"
fi

EMAIL=
NAME=
PROJECT_F="${PWD}/.git/config"

for item in "$@"; do
  case "${item}" in
    -u|--user=*)
      NAME="${item#*=}"
    ;;
    -e|--email=*)
      EMAIL="${item#*=}"
    ;;
    *)
      # Unknown Options
    ;;
  esac
done

# check username
if [ -z "$NAME" ]; then
  echo "-u | --user must be non-empty"
fi

# check email
if [ -z "$EMAIL" ]; then
  echo "-e | --email must be non-empty"
fi

if [ ! -f "$PROJECT_F" ];
then
  echo "Not found .git/config"
  exit 1;
fi

# exit with error code if email is not valid
gpg --list-secret-keys --keyid-format LONG ${EMAIL} > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
  echo "Error reading key: No secret key with you specified --email=${EMAIL}";
  exit 1;
fi

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

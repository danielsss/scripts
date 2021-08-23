#!/usr/bin/env bash

# Switch workspace
cd $PWD;

# Calculate input length
if [ $# -lt 2 ]; then
  echo -e "\t\t\t\t<GGPG>\n";
  echo -e "\t\t\t------------------------\n";
  echo -e "\tUsage:";
  echo -e "\t ./git_gpg.sh --user='string value' --email='string value'\n";
  echo -e "\t\t\t\t OR \n";
  echo -e "\t alias ggpg=$(pwd)/src/git_gpg.sh";
  echo -e "\t alias GGPG=$(pwd)/src/git_gpg.sh\n"
  echo -e "\t ggpg --user='string value' --email='string value'";
  exit 0;
fi

# Assign input arguments
EMAIL=
NAME=
for item in "$@"; do
  case "${item}" in
    -u|--user=*)
      NAME="${item#*=}";
    ;;
    -e|--email=*)
      EMAIL="${item#*=}";
    ;;
    *)
      # Unknown Options
    ;;
  esac
done

# Check username
if [ -z "$NAME" ]; then
  echo "-u | --user must be non-empty";
  exit 1;
fi

# Check email
if [ -z "$EMAIL" ]; then
  echo "-e | --email must be non-empty";
  exit 1;
fi

# Check project
PROJECT_F="${PWD}/.git/config";
if [ ! -f "$PROJECT_F" ]; then
  echo "Not found .git/config";
  exit 1;
fi

# Exit with error code if email is not valid
gpg --list-secret-keys --keyid-format LONG ${EMAIL} > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
  echo "Error reading key: No secret key with you specified --email=${EMAIL}";
  exit 1;
fi

AUTO_SIGN=1
SIGNING_KEY=$(gpg --list-secret-keys --keyid-format LONG ${EMAIL} | grep "sec" | awk '{print $2}' | awk -F/ '{print $2}')

if [ ! -x $(which gpg) ]; then
  echo "Not found command 'gpg'";
  exit 1;
fi

echo "git config --local user.name ${NAME}";
git config --local user.name ${NAME}
echo "git config --local user.email = ${EMAIL}";
git config --local user.email ${EMAIL}
echo "git config --local commit.gpgsign = 'true'";
git config --local commit.gpgsign "true"
echo "git config --local user.signingkey = ${SIGNING_KEY}";
git config --local user.signingkey ${SIGNING_KEY}

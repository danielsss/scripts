#!/bin/bash

DIRECTORY=$1

if [ -z "$DIRECTORY" ]; then
  echo "sh rebase.master.sh /project/myapp"
  exit 1;
fi

if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY doesn't exsits ..."
  exit 1;
fi

if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.' >&2
  exit 1
fi

if [ `echo "$DIRECTORY" | awk '{print substr($0,length,1)}'` != "/" ]; then
  DIRECTORY+="/";
fi

if [ ! -d "${DIRECTORY}.git" ]; then
  echo "$DIRECTORY doesn't have .git directory ..."
  exit 1;
fi

echo "change to $DIRECTORY and create a new branch temp_branch"
cd $DIRECTORY && git checkout master && git checkout --orphan temp_branch

echo "git add & commit & -D master & -m master & push origin"
git add -A
git commit -am "rebase: master"
git branch -D master
git branch -m master
git push -f origin master

echo "done ... check your repositry"


#!/bin/bash

ssh -vT git@github.com

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

git rm -r public
rm -r public/

git submodule add --force https://github.com:arareddy/arareddy.github.io.git public

git add .
git push -u origin master

# Build the project.
hugo # if using a theme, replace by `hugo -t <yourtheme>`

# Go To Public folder
cd public/

# Add changes to git.
git add .

# Commit changes.
 msg="rebuilding site `date`"
  if [ $# -eq 1 ]
    then msg="$1"
  fi
  git commit -m "$msg"

  # Push source and build repos.
  git push origin master

  # Come Back

cd ../

git commit -am "$msg"
git push origin master

#!/bin/bash
set -eux

# https://docs.pivotal.io/platform-automation/v4.3/tasks.html#make-git-commit

git clone repository repository-commit


FILE_DESTINATION_PATH="repository-commit/$FILE_DESTINATION_PATH"
mkdir -p $FILE_DESTINATION_PATH

cp -R file-source/$FILE_SOURCE_PATH $FILE_DESTINATION_PATH
cd repository-commit
git config user.name "$GIT_AUTHOR_NAME"
git config user.email "$GIT_AUTHOR_EMAIL"
if [[ -n $(git status --porcelain) ]]; then
  git add -A
  git commit -m "$COMMIT_MESSAGE" --allow-empty
fi

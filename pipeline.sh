#!/usr/bin/env bash

#set -eo pipefail
env

git branch | grep \* | cut -d ' ' -f2
git symbolic-ref --short HEAD

BRANCH=$(git rev-parse --abbrev-ref HEAD)
git diff-tree --no-commit-id --name-only -r HEAD \
  | grep / \
  | cut -d / -f 1 \
  | uniq \
  | xargs -L 1 -I {} \
    bash -c \
      'cd "{}" && test -x pipeline.sh && ./pipeline.sh "$@"' _ "$BRANCH"

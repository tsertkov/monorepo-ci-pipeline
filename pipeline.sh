#!/usr/bin/env bash

set -e
#set -eo pipefail
env


if [ ! -z "$TRAVIS_BRANCH" ]; then
  BRANCH="$TRAVIS_BRANCH"
else
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
fi

git diff-tree --no-commit-id --name-only -r HEAD \
  | grep / \
  | cut -d / -f 1 \
  | uniq \
  | xargs -L 1 -I {} \
    bash -c \
      'cd "{}" && test -x pipeline.sh && ./pipeline.sh "$@"' _ "$BRANCH"

#!/usr/bin/env bash

set -eo pipefail

BRANCH=$(git rev-parse --abbrev-ref HEAD)
git diff-tree --no-commit-id --name-only -r HEAD \
  | grep / \
  | cut -d / -f 1 \
  | uniq \
  | xargs -L 1 -I {} \
    bash -c \
      'cd "{}" && test -x pipeline.sh && ./pipeline.sh "$@"' _ "$BRANCH"

exit 0

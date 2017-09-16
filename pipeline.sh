#!/usr/bin/env bash

set -e

git symbolic-ref --quiet --short HEAD || echo 'HEAD is not symbolic-ref'
git show-ref --heads

env

CURRENT_BRANCH=$(
  git symbolic-ref --quiet --short HEAD \
    || git show-ref --heads \
      | sed -ne 's/.* refs\/heads\/\(.*\)/\1/p'
)

runPipelines () {
  for SERVICE in $1; do
    cd "$SERVICE"
    test -x pipeline.sh && ./pipeline.sh "$CURRENT_BRANCH"
    cd - >/dev/null
  done
}

if [ "$CURRENT_BRANCH" = "master" ]; then
  # execute pipeline for all services
  runPipelines "$(find . -mindepth 1 -maxdepth 1 -type d -and -not -name '.*')"
else
  # executes pipeline only for updated services in current branch
  # assumes that current branch was forked from master
  git remote set-branches --add origin master
  git fetch
  FORK_POINT_SHA=$(git merge-base --fork-point origin/master)

  runPipelines "$(
    git diff --name-only "${FORK_POINT_SHA}..HEAD" \
      | sed -ne 's/^\(.*\)\/.*$/\1/p' \
      | sort \
      | uniq
  )"
fi

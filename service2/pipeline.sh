#!/usr/bin/env bash

echo "/service2/pipeline.sh $@"

case "$1" in
  "master")
    echo "- pipeline for master branch"
    exit 2
    ;;
  "staging")
    echo "- pipeline for staging branch"
    ;;
  *)
    echo "- pipeline for default branch: '$1'"
    ;;
esac

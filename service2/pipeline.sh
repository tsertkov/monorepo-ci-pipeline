#!/usr/bin/env bash

echo "Service2 pipeline"

case "$1" in
  "master")
    echo "- pipeline for master branch"
    ;;
  "staging")
    echo "- pipeline for staging branch"
    ;;
  *)
    echo "- pipeline for default branch: '$1'"
    ;;
esac

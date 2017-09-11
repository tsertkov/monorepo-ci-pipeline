# Monorepo CI simple pipeline solution

> Language agnostic monorepo CI approach for executing pipelines on updated packages only

## Overview

CI executes `pipeline.sh` from monorepo project root which finds directories with updated code and runs `pipeline.sh` from these directories passing branch name as first argument.

Directories without executable `pipeline.sh` script are skipped from pipelines.

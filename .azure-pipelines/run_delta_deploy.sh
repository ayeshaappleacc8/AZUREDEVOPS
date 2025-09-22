#!/usr/bin/env bash
set -euo pipefail

BASE=${1:-HEAD~1}
TARGET_ORG=${2:-$TARGET_ORG}
API_VERSION=${3:-58.0}

echo "Base: $BASE"
echo "Target org: $TARGET_ORG"

echo "Ensure sgd plugin is installed"
echo y | sf plugins install sfdx-git-delta || true

echo "Generating delta..."
sf sgd source delta --from "$BASE" --to "HEAD" --output-dir "package" --generate-delta --api-version ${API_VERSION}

if [ ! -f package/package.xml ]; then
  echo "No delta to deploy - exiting"
  exit 0
fi

if [ -f package/destructiveChanges/destructiveChanges.xml ]; then
  echo "Deploying with post-destructive-changes..."
  sf project deploy start --manifest package/package.xml --post-destructive-changes package/destructiveChanges/destructiveChanges.xml --purge-on-delete --target-org "$TARGET_ORG" --wait 20 --test-level RunLocalTests
else
  echo "Deploying..."
  sf project deploy start --manifest package/package.xml --target-org "$TARGET_ORG" --wait 20 --test-level RunLocalTests
fi

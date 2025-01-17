#! /bin/bash

set -e
cd "$(dirname "${BASH_SOURCE[0]}")"

target="../netlify.toml"

# Common content
common='
# This file is generated by scripts/generate_netlify_toml.sh
# DO NOT MODIFY, MODIFY THE GENERATING SCRIPT
'

# Dev only
dev_only='
[[plugins]]
package = "./plugin/src/index.ts"
  [plugins.inputs]
  branches = ["*"]
  mainBranch = "master"

[[plugins]]
package = "@algolia/netlify-plugin-crawler"
  [plugins.inputs]
  disabled = true
'

# Prod only
prod_only='
[[plugins]]
package = "@algolia/netlify-plugin-crawler"
  [plugins.inputs]
  branches = ["*"]
'

echo "$common" >"$target"
if [ "$ALGOLIA_DEV_ENV" = "true" ]; then
  echo "$dev_only" >>"$target"
else
  echo "$prod_only" >>"$target"
fi

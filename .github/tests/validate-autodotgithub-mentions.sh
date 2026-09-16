#!/usr/bin/env bash
set -euo pipefail

input=$'Thanks @octocat and @hubot[bot] for the help.\nPlease also review @alice @bob.'
expected=$'Thanks [@octocat](https://github.com/octocat) and [@hubot](https://github.com/hubot)[bot] for the help.\nPlease also review [@alice](https://github.com/alice) [@bob](https://github.com/bob).'

actual=$(printf '%s\n' "$input" | perl -pe 's/(?<![A-Za-z0-9_])@([A-Za-z0-9][A-Za-z0-9-]{0,38})(\[[^\]]+\])?/\x5B\x40$1\x5D(https:\/\/github.com\/$1)$2/g')

if [[ "$actual" != "$expected" ]]; then
  echo "Unexpected output:"
  echo "$actual"
  exit 1
fi

echo "Mention regex tests passed"

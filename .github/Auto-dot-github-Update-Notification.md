# `Auto-dot-github.yml` Update Notification

> [!TIP]
> Update this file will notify the listener repos of changes.

```yml
name: '[Auto] Repo Gardening'

on:
  schedule:
    - cron: "0 23 * * *"
  pull_request:  # PR labeler
    types:
      - opened
      - edited
      - closed
      - reopened
  release:
    types:
      - published  # Auto changelog
      - created    # Auto bump
  workflow_dispatch:
  workflow_call:
    inputs:
      auto-bump:
        type: string
        required: false
        description: |

          Auto bump PR

          - npm (any non-empty string)
            Always executed (best-effort).
            --> npm version "VERSION_WITHOUT_v_PREFIX" --no-git-tag-version

          - csproj=XmlTagName (e.g. csproj=MyVersionProperty)
            Finds the current value from the first matching .csproj/.props file.
            --> Then performs plain text replacement.
            --> NOTE: This is a naive string replacement (not XML-aware, not schema-aware).
                Carefully review PR.

jobs:
  main:
    uses: sator-imaging/.github/.github/workflows/Auto-dot-github.yml@main
    with:
      # See above
      auto-bump: csproj=MyDirectoryBuildPropsXmlTagName
    secrets: inherit
    permissions:
      pull-requests: write
      contents: write  # Sync .github | Auto changelog | Auto bump
      issues: write    # PR labeler
```

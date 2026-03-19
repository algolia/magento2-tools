# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`algolia/magento2-tools` is a Composer-installable package providing bash wrapper scripts that run PHP code quality tools on Algolia's Magento 2 extensions. It is intended to be installed globally via `composer global require algolia/magento2-tools`.

## Commands

All tools live in [bin/](bin/) and accept two arguments:
1. `path/to/magento/extension` — the extension directory (required)
2. Optional vendor bin path prefix

| Command | Purpose |
|---|---|
| `magento2-lint` | Runs php-cs-fixer and **modifies** files in place |
| `magento2-test` | Dry-run of coding style + PHP compatibility checks (no modifications) |
| `magento2-php-compatibility` | Checks PHP version compatibility using PHPCompatibility/phpcs |
| `magento2-update` | Auto-updates this package via Composer if a newer version is available |

There are no build steps or test suites for this repository itself.

## Architecture

Each bin script sets `EXTENSION_DIR` (argument 1) and `VENDOR_BIN` (argument 2), then sources `lib/env.sh` which handles shared setup: resolving `LIB_DIR`/`BIN_DIR`, auto-detecting `VENDOR_BIN`, and running `magento2-update`. The tools then operate directly on `EXTENSION_DIR`.

**PHP Compatibility path detection** — `magento2-test` and `magento2-php-compatibility` check two possible locations for the `phpcompatibility/php-compatibility` package relative to `BIN_DIR`, handling both local and global Composer install layouts.

## Release Process

1. `git add . && git reset --hard` — clean working directory
2. `git checkout master && git pull`
3. Bump the version string in [bin/magento2-update](bin/magento2-update)
4. `git commit -m "chore: bumps version to vX.X.X"`
5. `git push`
6. `git tag vX.X.X && git push --tags`
7. Create a GitHub release at `https://github.com/algolia/magento2-tools/releases/new` named `vX.X.X`

Users receive the update automatically via the `magento2-update` auto-update mechanism.

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`algolia/magento2-tools` is a Composer-installable package providing bash wrapper scripts that run PHP code quality tools on Algolia's Magento 2 extensions. It is intended to be installed globally via `composer global require algolia/magento2-tools`.

## Commands

All tools live in [bin/](bin/) and accept arguments:
1. `path/to/magento/extension` — the extension directory (required)
2. Optional vendor bin path prefix

| Command | Purpose |
|---|---|
| `magento2-analyse` | Runs PHPStan static analysis (requires Magento root — auto-detected from extension path) |
| `magento2-lint` | Runs php-cs-fixer and **modifies** files in place |
| `magento2-test` | Dry-run of coding style + PHP compatibility + PHPStan checks (no modifications) |
| `magento2-php-compatibility` | Checks PHP version compatibility using PHPCompatibility/phpcs |
| `magento2-update` | Auto-updates this package via Composer if a newer version is available |

There are no build steps or test suites for this repository itself.

## Architecture

Each bin script sets `EXTENSION_DIR` (argument 1) and `VENDOR_BIN` (argument 2), then sources `lib/env.sh` which handles shared setup: resolving `LIB_DIR`/`BIN_DIR`, auto-detecting `VENDOR_BIN`, and running `magento2-update`. The tools then operate directly on `EXTENSION_DIR`.

**PHP Compatibility path detection** — `magento2-test` and `magento2-php-compatibility` check two possible locations for the `phpcompatibility/php-compatibility` package relative to `BIN_DIR`, handling both local and global Composer install layouts.

**PHPStan analysis** — `magento2-analyse` requires a Magento root installation. The Magento root is auto-detected by `lib/detect-magento.sh`, which checks for `app/etc/env.php` or `bin/magento` by walking up from the extension directory or inspecting `/vendor/` path segments. If no Magento root is found, the script aborts with a clear error.

`bitexpert/phpstan-magento` is bundled as a dependency and loaded with the correct `magentoRoot` — its `ClassLoaderProvider` bootstraps Magento's `vendor/autoload.php`, resolving all framework classes and generating Factory/Proxy stubs without needing `setup:di:compile`.

**Runtime neon generation** — `magento2-analyse` generates a temporary neon file in `/tmp` (cleaned up on exit) that composes absolute-path includes for the base config (`lib/phpstan/magento2-tools.neon`), PHPStan extensions (`phpstan-phpunit`, `bitexpert/phpstan-magento`), and any extension-level `phpstan.neon`/`phpstan.neon.dist` overlay. PHPStan extensions are included manually (not via `extension-installer`) for explicit control over load order.

`magento2-test` delegates its PHPStan step to `magento2-analyse`. The `MAGENTO2_TOOLS_ENV_LOADED` guard in `lib/env.sh` prevents double update checks when scripts delegate to each other.

## Release Process

1. `git add . && git reset --hard` — clean working directory
2. `git checkout master && git pull`
3. Bump the version string in [bin/magento2-update](bin/magento2-update)
4. `git commit -m "chore: bumps version to vX.X.X"`
5. `git push`
6. `git tag vX.X.X && git push --tags`
7. Create a GitHub release at `https://github.com/algolia/magento2-tools/releases/new` named `vX.X.X`

Users receive the update automatically via the `magento2-update` auto-update mechanism.

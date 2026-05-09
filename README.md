<p align="center">
  <a href="https://www.algolia.com">
    <img alt="" src="https://raw.githubusercontent.com/algolia/algoliasearch-client-common/master/readme-banner.png" >
  </a>

  <h4 align="center">The perfect starting point to analyse the PHP quality of our Algolia Magento 2 extension</h4>
</p>

## 💡 Getting Started

First, install globally the `magento2-tools`:
```bash
composer global require algolia/magento2-tools
```

Make sure to place Composer's system-wide vendor bin directory in your `$PATH`
so the `magento2-tool` executable can be located by your system.

Finally, you can launch the quality tools with:
```bash
{command} path/to/magento/extension [vendor/bin/path/]
```

The second argument is optional. If omitted, the scripts will attempt to auto-resolve the vendor bin directory by checking for a local `vendor/bin/` install (e.g. after running `composer install` in the package directory) and then falling back to the global Composer vendor bin. If neither is found, the tools are expected to be on your `$PATH`.

Here is the list of available commands:

- **`magento2-lint`**: Runs the linter and fixes the found issues - configuration file under `algoliasearch-magento-2/.php-cs-fixer.php`.

- **`magento2-analyse`**: Runs PHPStan static analysis. Uses `phpstan.neon` or `phpstan.neon.dist` from the extension directory if present; otherwise runs at level 1 with sensible defaults.

- **`magento2-php-compatibility`**: Checks if your code is compatible across all PHP versions supported by Magento.

- **`magento2-test`**: Runs all previous commands in `--dry-run` / read-only mode (coding style, PHP compatibility, and PHPStan analysis).

## Known issue: PHPStan crash from `bitexpert/phpstan-magento` autoloaders

Under PHPStan's parallel-worker mode with a warm cache, `bitexpert/phpstan-magento`'s `Extension*Autoloader` classes can collide with `phpstan/phpstan-phpunit`'s `MockObjectTypeNodeResolverExtension`, producing either a hard crash or silent false-positive `return statement is missing` errors. Tracked upstream in [bitExpert/phpstan-magento#297](https://github.com/bitExpert/phpstan-magento/issues/297).

Until upstream merges a fix, this package ships [patches/bitexpert-phpstan-magento-skip-phpstan-namespace.patch](patches/bitexpert-phpstan-magento-skip-phpstan-namespace.patch), which makes both autoloaders skip classes in the `PHPStan\` namespace. Two ways to apply it:

### Option A: composer-patches opt-in (recommended)

[`cweagans/composer-patches`](https://github.com/cweagans/composer-patches) is included as a dependency and will auto-apply the patch on every `composer global install`/`update`, but only if the consumer (your global Composer environment) opts in. One-time setup:

```bash
composer global config --no-plugins allow-plugins.cweagans/composer-patches true
composer global config extra.patches --json '{"bitexpert/phpstan-magento":{"Skip PHPStan namespace in Extension autoloaders":"vendor/algolia/magento2-tools/patches/bitexpert-phpstan-magento-skip-phpstan-namespace.patch"}}'
```

Then the patch applies on the next install/update:

```bash
composer global require algolia/magento2-tools
```

You should see `Applying patches for bitexpert/phpstan-magento` in the install output. From then on, every `composer global update` will reapply the patch automatically.

### Option B: one-off manual `patch` (fallback)

If you'd rather not opt into `cweagans/composer-patches`, apply the patch manually after each install/update:

```bash
COMPOSER_HOME=$(composer global config --absolute home) && \
  patch -d "$COMPOSER_HOME/vendor/bitexpert/phpstan-magento" -p1 \
    < "$COMPOSER_HOME/vendor/algolia/magento2-tools/patches/bitexpert-phpstan-magento-skip-phpstan-namespace.patch"
```

If the patch reports "Reversed (or previously applied) patch detected" it has already been applied; answer `n` to skip. If it fails for any other reason, `bitexpert/phpstan-magento` has been updated and the patch needs revisiting.

## Release process

- Clear your the local repository with: `git add . && git reset --hard`
- Make sure you are on the latest master branch: `git checkout master && git pull`
> Note: make sure that there is no breaking changes and you may use `git tag --list` to check the latest release
- Bump version in the file `bin/magento2-update`
- Commit the `bin/magento2-update` with the message: `git commit -m "chore: bumps version to vX.X.X"`
- `git push`
- `git tag vX.X.X`
- `git push --tags`
- Create a new release with the name `vX.X.X` under [https://github.com/algolia/magento2-tools/releases/new](https://github.com/algolia/magento2-tools/releases/new).

> Developers will get the new version via the `auto-update` mechanism of this tool.

## 📄 License

magento2-tools is an open-sourced software licensed under the [MIT license](LICENSE).

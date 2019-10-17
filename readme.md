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
{command} path/to/magento/extension
```

Here is the list of available commands:

- **`magento2-lint`**: Runs the linter and fixes the found issues - configuration file under `algoliasearch-magento-2/.php_cs`.

- **`magento2-types`**: Runs the type checker and displays the found issues - configuration file under `algoliasearch-magento-2/phpstan.neon`.

- **`magento2-php-compatibility`**: Checks if your code is compatibility between multiple all php versions supported by magento.

- **`magento2-test`**: Runs all previous commands in `--dry-run` mode.

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

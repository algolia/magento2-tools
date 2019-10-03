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

## 📄 License

magento2-tools is an open-sourced software licensed under the [MIT license](LICENSE).

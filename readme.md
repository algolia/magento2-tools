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

Finally, you can launch the quality tools with:
```bash
{command} path/to/magento/extension
```

Here is the list of available commands:

- `magento2-lint`: Runs the linter and fixes the found issues
- `magento2-types`: Runs the type checker and displays the found issues
- `magento2-test`: Runs both previous commands in `--dry-run` mode

## 📄 License

magento2-tools is an open-sourced software licensed under the [MIT license](LICENSE).

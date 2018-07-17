# Redmine Queries Issues Count

Redmine plugin to display issues count for queries in the sidebar.

## Compatibility

This plugin version is compatible only with Redmine 3.0 and later.

## Installation

1. Download the .ZIP archive, extract files and copy the plugin directory into `#{REDMINE_ROOT}/plugins`.

2. Make a backup of your database, then run the following command to update it:

    ```
    bundle exec rake redmine:plugins:migrate RAILS_ENV=production 
    ```

3. Restart Redmine.

## Security

If you discover any security related issues, please email security@exolnet.com instead of using the issue tracker.

## Credits

- [Alexandre D'Eschambeault](https://github.com/xel1045)
- [All Contributors](../../contributors)

## License

This code is licensed under the [MIT license](http://choosealicense.com/licenses/mit/). 
Please see the [license file](LICENSE) for more information.
# Redmine Queries Count

[![Latest Release](https://img.shields.io/github/release/eXolnet/redmine-queries-count.svg?style=flat-square)](https://github.com/eXolnet/redmine-queries-count/releases)
[![Software License](https://img.shields.io/badge/license-MIT-8469ad.svg?style=flat-square)](LICENSE)
[![Build Status](https://img.shields.io/travis/eXolnet/redmine-queries-count/master.svg?style=flat-square)](https://travis-ci.org/eXolnet/redmine-queries-count)
[![Maintainability](https://api.codeclimate.com/v1/badges/1b08f64f3a4885efbae3/maintainability)](https://codeclimate.com/github/eXolnet/redmine-queries-count/maintainability)

This plugin allow user to add queries item count in the sidebar.

## Compatibility

This plugin version is compatible only with Redmine 3.3 and later.

## Installation

1. Download the .ZIP archive, extract files and copy the plugin directory to `#{REDMINE_ROOT}/plugins/redmine_queries_count`.

2. From the directory `#{REDMINE_ROOT}`, install the plugin's dependencies:

    ```bash
    bundle install
    ```

3. Make a backup of your database, then run the following command to update it:

    ```bash
    bundle exec rake redmine:plugins:migrate NAME=redmine_queries_count RAILS_ENV=production
    ```

4. Restart Redmine.

### Uninstall

1. Make a backup of your database, then run the following command:

    ```bash
    bundle exec rake redmine:plugins:migrate NAME=redmine_queries_count VERSION=0 RAILS_ENV=production
    ```

2. Remove the plugin's folder from `#{REDMINE_ROOT}/plugins`.

3. Restart Redmine.

## Testing

Run tests using the following command:

```bash
bundle exec rake redmine:plugins:test NAME=redmine_queries_count RAILS_ENV=development
```

## Contributing

Please see [CONTRIBUTING](CONTRIBUTING.md) and [CODE OF CONDUCT](CODE_OF_CONDUCT.md) for details.

## Security

If you discover any security related issues, please email security@exolnet.com instead of using the issue tracker.

## Credits

- [Alexandre D'Eschambeault](https://github.com/xel1045)
- [All Contributors](../../contributors)

## License

This code is licensed under the [MIT license](http://choosealicense.com/licenses/mit/).
Please see the [license file](LICENSE) for more information.
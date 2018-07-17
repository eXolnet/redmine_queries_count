# Redmine Queries Issues Count

[![Github Release](https://img.shields.io/github/release/eXolnet/redmine-queries-issues-count.svg)](./releases)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](LICENSE.md)
[![Build Status](https://img.shields.io/travis/eXolnet/redmine-queries-issues-count/master.svg?style=flat-square)](https://travis-ci.org/eXolnet/redmine-queries-issues-count)
[![Github All Releases](https://img.shields.io/github/downloads/eXolnet/redmine-queries-issues-count/total.svg)]()


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
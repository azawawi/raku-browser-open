# Browser::Open

[![Actions
Status](https://github.com/azawawi/raku-browser-open/workflows/test/badge.svg)](https://github.com/azawawi/raku-browser-open/actions)

This is a humble Raku port of Perl's
[Browser::Open](http://metacpan.org/module/Browser::Open).

## Installation

To install it using zef, the Raku module manager:

```
$ zef install Browser::Open
```

## Synopsis

```Raku
use Browser::Open;

my $ok = open-browser($url);
```

## Description

This module allow you to open URLs in a browser. A set of known browser commands
per OS-name is tested for presence, and the first one found is executed. With an
optional parameter, all known commands are checked.

## Testing

- To run tests:
```
$ prove --ext .rakutest -ve "raku -I."
```

- To run all tests including author tests (Please make sure
[Test::Meta](https://github.com/jonathanstowe/Test-META) is installed):
```
$ zef install Test::META
$ AUTHOR_TESTING=1 prove --ext .rakutest -ve "raku -I."
```

## Author

Ahmad M. Zawawi, azawawi on #raku, https://github.com/azawawi/

Original Perl Author: Pedro Melo `<melo at cpan.org>`

## License

MIT License

#!/usr/bin/env raku

use v6;

use Browser::Open;

my $url = 'www.raku.org';
my $ok = open-browser($url);

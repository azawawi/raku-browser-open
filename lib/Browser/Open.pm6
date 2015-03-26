module Browser::Open;

my @known_commands = (
  ['', $ENV{BROWSER}],
  ['darwin',  '/usr/bin/open', 1],
  ['cygwin',  'start'],
  ['MSWin32', 'start', undef, 1],
  ['solaris', 'xdg-open'],
  ['solaris', 'firefox'],
  ['linux',   'sensible-browser'],
  ['linux',   'xdg-open'],
  ['linux',   'x-www-browser'],
  ['linux',   'www-browser'],
  ['linux',   'htmlview'],
  ['linux',   'gnome-open'],
  ['linux',   'gnome-moz-remote'],
  ['linux',   'kfmclient'],
  ['linux',   'exo-open'],
  ['linux',   'firefox'],
  ['linux',   'seamonkey'],
  ['linux',   'opera'],
  ['linux',   'mozilla'],
  ['linux',   'iceweasel'],
  ['linux',   'netscape'],
  ['linux',   'galeon'],
  ['linux',   'opera'],
  ['linux',   'w3m'],
  ['linux',   'lynx'],
  ['freebsd', 'xdg-open'],
  ['freebsd', 'gnome-open'],
  ['freebsd', 'gnome-moz-remote'],
  ['freebsd', 'kfmclient'],
  ['freebsd', 'exo-open'],
  ['freebsd', 'firefox'],
  ['freebsd', 'seamonkey'],
  ['freebsd', 'opera'],
  ['freebsd', 'mozilla'],
  ['freebsd', 'netscape'],
  ['freebsd', 'galeon'],
  ['freebsd', 'opera'],
  ['freebsd', 'w3m'],
  ['freebsd', 'lynx'],
  ['',        'open'],
  ['',        'start'],
);

sub open_browser(Str $url, $all) {
  my $cmd = $all ? open_browser_cmd_all() : open_browser_cmd();
  return unless $cmd;
 
  return system($cmd, $url);
}
 
sub open_browser_cmd {
  return _check_all_cmds($*O);
}
 
sub open_browser_cmd_all {
  return _check_all_cmds('');
}
 
 
##################################
 
sub _check_all_cmds(Str $filter) {
 
  for my @known_commands -> $spec {
    my ($osname, $cmd, $exact, $no_search) = @$spec;
    next unless $cmd;
    next if $osname && $filter && $osname ne $filter;
    next if $no_search && !$filter && $osname ne $^O;
 
    return $cmd if $exact && -x $cmd;
    return $cmd if $no_search;
    $cmd = _search_in_path($cmd);
    return $cmd if $cmd;
  }

  return;
}
 
sub _search_in_path(Str $cmd) {
 
  for my $path (split(/:/, $ENV{PATH})) {
    next unless $path;
    my $file = catfile($path, $cmd);
    return $file if -x $file;
  }

  return;
}
 

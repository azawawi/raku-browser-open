module Browser::Open;

my @known_commands =
(
	['', %*ENV<BROWSER>],
	['darwin',  '/usr/bin/open', 1],
	['cygwin',  'start'],
	['win32',   'start', Nil, 1],
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

sub open_browser(Str $url, Bool $all = False) is export returns Proc::Status
{
	my $cmd = $all ?? (open_browser_cmd_all) !! (open_browser_cmd);
	return unless $cmd;

	my $proc = Proc::Async.new("$cmd", "$url");
	return $proc.start;
}
 
sub open_browser_cmd is export returns Str
{
	return _check_all_cmds($*KERNEL.name);
}
 
sub open_browser_cmd_all is export returns Str {
	return _check_all_cmds('');
}
 
sub _check_all_cmds(Str $filter) returns Str
{
	for @known_commands -> $spec
	{
		my ($osname, $cmd, $exact, $no_search) = @$spec;
		next unless $cmd;
		next if $osname && $filter && $osname ne $filter;
		next if $no_search && !$filter && $osname ne $*KERNEL.name;

		return $cmd if $exact && $cmd.IO ~~ :x;
		return $cmd if $no_search;
		$cmd = _search_in_path($cmd);
		return $cmd if $cmd;
	}

	return;
}
 
sub _search_in_path(Str $cmd) returns Str
{
	for %*ENV<PATH>.split(':') -> $path
	{
		next unless $path;
		my Str $file = $*SPEC.catdir($path, $cmd);
		return $file if $file.IO ~~ :x;
	}

	return;
}
 

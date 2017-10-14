use v6;
use Test;

use Browser::Open;
 
my $osname = $*VM.osname;
my $cmd    = open-browser-cmd;
if $cmd {
    ok $cmd, "got command '$cmd'";
    SKIP: {
        skip "Won't test execution on MSWin32", 1 if $osname eq 'MSWin32';
        ok $cmd.IO ~~ :e, '... and we can execute it';
    }
    diag "Found '$cmd' for '$osname'";
    ok open-browser-cmd-all, '... and the all commands version is also ok';
} else {
    $cmd = open-browser-cmd-all;
    if $cmd {
        pass "Found command in the 'all' version ($cmd)";
    }
    else {
        diag "$osname - need more data";
        pass "We can't make popcorn without corn";
    }
}

done-testing;

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 1;
use HTML::Tmpl;

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

HTML::Tmpl->cache_highwatermark=3;
HTML::Tmpl->cache_lowwatermark=1;

my $t=HTML::Tmpl->new( template=><<'EOF' );
pre<=val><: $v+0 /></=val>
EOF

$t->evaluate( val=>3 );

sleep 1;

$t=HTML::Tmpl->new( template=><<'EOF' );
pre<=val><: $v+1 /></=val>
EOF

$t->evaluate( val=>3 );

sleep 1;

$t=HTML::Tmpl->new( template=><<'EOF' );
pre<=val><: $v+2 /></=val>
EOF

$t->evaluate( val=>3 );

sleep 1;

$t=HTML::Tmpl->new( template=><<'EOF' );
pre<=val><: $v+3 /></=val>
EOF

$t->evaluate( val=>3 );

ok((HTML::Tmpl->cache_sizes)[0]==2 && (HTML::Tmpl->cache_sizes)[1]==2,
   'cache sizes');

# Local Variables:
# mode: cperl
# End:

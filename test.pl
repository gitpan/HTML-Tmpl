# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use Test;
BEGIN {
    plan tests => 3;
    $ENV{HTML_TEMPLATE_ROOT} = "templates";

}

use HTML::Tmpl;

ok(1); # If we made it this far, we're ok.

my $tmpl = new HTML::Tmpl(filename=>"sample.tmpl");

ok( ref($tmpl) );

print <<TEST;
Please insert your name below. It will generate an HTML document
with the greeting. And see if your name appears in the document.
TEST
chomp(my $name = <STDIN>);

$tmpl->param(
    name    => $name || $ENV{USER} || "Unknown friend",
    title   => "Hello World from HTML::Tmpl",
    success => "Congratulations, it's working just like a miracle",
);

print STDERR "HTML code:\n";
print "-" x 30, "\n";
$tmpl->print;
print "-" x 30, "\n";

ok( $tmpl->output );


package HTML::Tmpl;

use strict;
use vars qw($VERSION);
use File::Spec;
use Cwd;


$VERSION = "1.4";

sub new {
    my $class = shift;
    $class = ref($class) || $class;

    my $self = {
        filename       =>  undef,
        _row_template   =>  undef,
        _params         =>  [],
        @_,
    };

    bless $self, $class;

    $self->_init() or return undef;

    return $self;
}












sub _init {
    my $self = shift;

    my $filename = "";

    if ( -e $self->{filename} ) {
        $filename = $self->{filename};
    } elsif ( $ENV{HTML_TEMPLATE_ROOT} and (-e File::Spec->catfile($ENV{HTML_TEMPLATE_ROOT}, $self->{filename})) ) {
        $filename = File::Spec->catfile($ENV{HTML_TEMPLATE_ROOT}, $self->{filename});
    } else {
        return undef;
    }

    local $/ = undef;
    open( TMPL, $filename ) or return undef;
    $self->{_row_template} = <TMPL>;
    close( TMPL );

}





















sub param {
    my $self = shift;

    my %args = ();

    if ( ref($_[0]) eq "HASH" ) {
        %args = %{ $_[0] };
    } elsif ( not ref($_[0] ) ) {
        %args = @_;
    }

    study $self->{_row_template};

    $self->{_row_template} =~ s/<\%var\s+(\w+)\s*\%>/$args{$1}/g;

    return @{ $self->{_params} };
}



















sub output {
    my $self = shift;
    return $self->{_row_template};
}







sub print {
	my $self = shift;

	print $self->{_row_template};

}












1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

HTML::Tmpl - Perl extension handling simple HTML Templates in CGI Scripts

=head1 SYNOPSIS



    #!/usr/bin/perl -wT

    #in CGI app.:
    use HTML::Tmpl;

    my $tmpl = new HTML::Tmpl(-filename=>"some-template.tmpl");
    $tmpl->param(
        title       => "New Document",
        time        => scalar( localtime() ),
        name        => "Sherzod B. Ruzmetov"
    );

    print "Content-type: text/html\n\n";
    print $tmpl->output();


    in some-template.tmpl file:


    <HTML>
    <HEAD>
    <TITLE> <%var title%> </TITLE>
    </HEAD>
    <BODY>

    Today's date is <%var time %>

    Copyright (c) 2002 <%var name%>

    </BODY></HTML>

=head1 DESCRIPTION

    This documenation refers to Version 1.x of the library

    HTML::Tmpl is the lighter version of L<HTML::Template> module by Sam Trager (sam@trager.com)
    but with a lot less options. It uses JSP like styled tag sets (<% %>)

    As of version 1.1 HTML::Tmpl does only variable replacement. IF you want loop and if/else
    features to be available for your HTML templates, please go with L<HTML::Template>.
    Of course all the features HTML::Template offers are in my TODO list, and hopefully
    will appeare in the subsecquent versions of the library.


=head1 METHODS

=over 4

=item C<new()>

constructor C<new()> takes a hash argument which denotes the name of the file to ber parsed
as an HTML template. It returns L<HTML::Tmpl> object if it succeeds, I<undef> otherwise.

    my $tmpl = new HTML::Tmpl(-filename=>"some-template.tmpl");

=item C<param()>

assigns parameters to special tags. It expects arguments in key/value pairs, so it's abolutely
legal to give it already existing hash. As an alternative you can pass it a reference to a hash
variable. It dereferences it for you. This feature is quite usefull when you want to pass
it the result of I<$dbh->selectrow_hashref(qq|SELECT * FROM table_name WHERE id=?|, undef, $id)>
to select a row from an SQL database. Example.,

    # profile of the user with id 7 as saved in the 'profiles' table
    $tmpl->param($dbh->selectrow_hashref(qq|SELECT * FROM profiles WHERE id=?|, undef, 7);

=item C<output()>

when take care of all of your parameter processing (by calling the above C<param()> method),
at sometime you decide to printout your final template. That's when you use the C<output()> method.
Example.,

    print $tmpl->output();

But don't forget to take  care of your own HTTP headers:

    print "Content-type: text/html\n\n";
    print $tmpl->output();

As an alternative to C<output()> you can as well call the C<print()> method, which prints it for you
to STDOUT.

=item C<print()>

similar to C<output()>, but instead of returning the processed template, it prints it for you.
So you can just say:

    $tmpl->print;

    # instead of saying:
    # print $tmpl->output();

=back


=head1 AUTHOR

Sherzod B. Ruzmetov <sherzodr@cpan.org>

=head1 SEE ALSO

L<HTML::Template>, L<DBI>, L<perl>

=cut

#!/bin/bash

(perldoc -tU ./lib/HTML/Tmpl.pod
 perldoc -tU $0
) >README

exit 0

=head1 INSTALLATION

 perl Makefile.PL
 make
 make test
 make install

=head1 DEPENDENCIES

Class::Member 1.2

=cut
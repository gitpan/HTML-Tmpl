use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'HTML::Tmpl',
    'VERSION_FROM'	=> 'lib/HTML/Tmpl.pm', # finds $VERSION
    'PREREQ_PM'		=> {'Class::Member'=>1.2}, # e.g., Module::Name => 1.1
    'PMLIBDIRS'		=> ['lib'],
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'lib/HTML/Tmpl.pod', # retrieve abstract from module
       AUTHOR     => 'Torsten Förtsch <Torsten.Foertsch@gmx.net>') : ()),
);


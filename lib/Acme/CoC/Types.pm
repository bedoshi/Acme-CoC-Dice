package Acme::CoC::Types;
use strict;
use warnings;
use utf8;

use Moose::Util::TypeConstraints;

subtype 'Command',
    as => 'Str',
    where => sub {
        $_ =~ /skill|ccb|cc|[1-9][0-9]*[dD][1-9][0-9]/
    },
    message => sub { 'invalid command' };

1;

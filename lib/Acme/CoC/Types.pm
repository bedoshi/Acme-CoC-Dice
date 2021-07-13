package Acme::CoC::Types;
use strict;
use warnings;
use utf8;

use Moose::Util::TypeConstraints;

subtype 'Command',
    as 'Str',
    where {
        $_ =~ /^skill|ccb [1-9][0-9]*|cc [1-9][0-9]*|[1-9][0-9]*[dD][1-9][0-9]*$/
    },
    message { 'invalid command' };

1;

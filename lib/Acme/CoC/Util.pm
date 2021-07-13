package Acme::CoC::Util;
use strict;
use utf8;
use warnings;

use parent qw/Exporter/;

our @EXPORT = qw/
    eq_any
/;

sub eq_any {
    my ($target, $array) = @_;
    for my $item (@{ $array }) {
        return 1 if $target eq $item;
    }
}

1;

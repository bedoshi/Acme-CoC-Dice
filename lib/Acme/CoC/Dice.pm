package Acme::CoC::Dice;

use strict;
use warnings;
use utf8;

use Carp qw/croak/;

our $VERSION = '0.01';

sub role {
    my ($self, $command) = @_;

    # MdN in $command can be separated to M/d/N, and M is the times of roling dice, N is the number of sided dice.
    return $self->role_skill if $command =~ /^skill$/;

    $command =~ /([1-9][0-9]*)d([1-9][0-9]*)/;
    my $role_result = {
        message => 'input invalid command',
    };
    return $role_result unless $command;

    my $times = $1 || 1;
    my $sided_dice = $2 || 100;
    my $results = [];
    my $sum = 0;

    for (1..$times) {
        my $rand_num = int(rand($sided_dice)) + 1;
        push @{ $results }, $rand_num;
        $sum += $rand_num;
    }

    $role_result = {
        dices => $results,
        sum => $sum,
    };
    return $role_result;
}

sub role_skill {
    my ($self) = @_;

    return $self->role('1d100');
}

1;
__END__

=encoding utf-8

=head1 NAME

Acme::CoC::Dice - Dice role module for CoC TRPG.

=head1 SYNOPSIS

  use Acme::CoC::Dice;

=head1 DESCRIPTION

Acme::CoC::Dice is getting random number like 1d100.


=head1 AUTHOR

bedoshi E<lt>bedoshidiary.ester.freesia@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2021- bedoshi

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut

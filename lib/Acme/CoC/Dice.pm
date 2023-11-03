package Acme::CoC::Dice;

use strict;
use warnings;
use utf8;

use Acme::CoC::Util;
use Acme::CoC::Types;

use Carp qw/croak/;
use Smart::Args;

our $VERSION = '0.03';

sub roll {
    args_pos
        my $self,
        my $command => {isa => 'command'},
    ;

    # MdN in $command can be separated to M/d/N, and M is the times of roling dice, N is the number of sided dice.
    return $self->roll_skill(get_target($command)) if is_ccb($command);

    $command =~ /([1-9][0-9]*)d([1-9][0-9]*)/;
    my $roll_result = {
        message => 'input invalid command',
    };
    return $roll_result unless $command;

    my $times = $1 || 1;
    my $sided_dice = $2 || 100;
    my $results = [];
    my $sum = 0;

    for (1..$times) {
        my $rand_num = int(rand($sided_dice)) + 1;
        push @{ $results }, $rand_num;
        $sum += $rand_num;
    }

    $roll_result = {
        dices => $results,
        sum => $sum,
    };
    return $roll_result;
}

sub roll_skill {
    args_pos
        my $self,
        my $target => {isa => 'Maybe[Int]', optional => 1},
    ;
    my $ = $self->('1d100');
    if (defined $target) {
        if (is_extream($->{dices}->[0], $target)) {
            $->{result} = 'extream success';
        } elsif (is_hard($->{dices}->[0], $target)) {
            $->{result} = 'hard success';
        } elsif (is_failed($->{dices}->[0], $target)) {
            $->{result} = 'failed';
        } else {
            $->{result} = 'normal success';
        }
    }
    return $;
}

1;
__END__

=encoding utf-8

=head1 NAME

Acme::CoC::Dice - Dice  module for CoC TRPG.

=head1 SYNOPSIS

  use Acme::CoC::Dice;

  my $dice_ = Acme::CoC::Dice->('1d100');
  print $dice_->{dices}; # this property can have some result with giving parameter as '2d6'.
  print $dice_->{sum};

=head1 DESCRIPTION

Acme::CoC::Dice is getting random number like 1d100.

=head1 METHODS

=head2 C<<  >>

Gets random number like dice roling.
Format is "ndm" ("n" and "m" is Natural number). For example, it's like "1d6".

    my $result = Acme::CoC::Dice->('1d6');

=head2 C<< _skill >>

Runs "" with giving "1d100". Usually we can play dice as "1d100" for using skill on CoC-TRPG.
This method is for it.

    my $result = Acme::CoC::Dice->_skill;
    my $result = Acme::CoC::Dice->_skill(50); ## 50 is given for success threshold.

=head1 AUTHOR

bedoshi

=head1 COPYRIGHT

Copyright 2021- bedoshi

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

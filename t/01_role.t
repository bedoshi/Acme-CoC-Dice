use strict;
use warnings;
use utf8;

use Acme::CoC::Dice;
use Acme::CoC::Util;

use Test2::V0;
use Module::Spy;

my $target = 'Acme::CoC::Dice';

subtest '#roll' => sub {
    subtest 'normal calling' => sub {
        my $spy_roll_skill = spy_on($target, 'roll_skill')->and_call_through;

        $spy_roll_skill->calls_reset;
        my $result = $target->roll('1d100');
        is @{ $result->{dices} }, 1;
        for my $item (@{ $result->{dices} }) {
            ok $item >= 1 && $item <= 100, "1 <= result <= 100: $item";
            ok !$spy_roll_skill->called, 'roll_skill was not called';
        }

        $spy_roll_skill->calls_reset;
        $result = $target->roll('10d10');
        is @{ $result->{dices} }, 10;
        for my $item (@{ $result->{dices} }) {
            ok $item >= 1 && $item <= 10, "1 <= result <= 10: $item";
            ok !$spy_roll_skill->called, 'roll_skill was not called';
        }
    };

    subtest 'ccb calling' => sub {
        my $spy_roll_skill = spy_on($target, 'roll_skill')->and_call_through;

        $spy_roll_skill->calls_reset;
        my $result = $target->roll('skill');
        is @{ $result->{dices} }, 1;
        for my $dice (@{ $result->{dices} }) {
            ok $spy_roll_skill, 'roll_skill was called';
        }

        $spy_roll_skill->calls_reset;
        $result = $target->roll('ccb 60');
        is @{ $result->{dices} }, 1;
        for my $dice (@{ $result->{dices} }) {
            ok $spy_roll_skill, 'roll_skill was called';
        }
        ok $result->{result};
        ok eq_any($result->{result}, ['extream success', 'hard success', 'normal success', 'failed']);

        $spy_roll_skill->calls_reset;
        $result = $target->roll('cc 60');
        is @{ $result->{dices} }, 1;
        for my $dice (@{ $result->{dices} }) {
            ok $spy_roll_skill, 'roll_skill was called';
        }
        ok $result->{result};
        ok eq_any($result->{result}, ['extream success', 'hard success', 'normal success', 'failed']);
    };
};

done_testing;

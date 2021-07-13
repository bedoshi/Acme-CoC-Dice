use strict;
use warnings;
use utf8;

use Acme::CoC::Util;

use Test2::V0;

subtest 'eq_any' => sub {
    ok eq_any('test', [1, 2, 'test']);
    ok !eq_any('test', [1, 2]);
};

subtest 'is_ccb' => sub {
    ok is_ccb('skill');
    ok is_ccb('cc');
    ok is_ccb('ccb');
    ok !is_ccb('test');
};

subtest 'get_target' => sub {
    ok !get_target('skill');
    ok !get_target('1d100');
    is get_target('cc 100'), 100;
    is get_target('ccb 55'), 55;
};

done_testing;

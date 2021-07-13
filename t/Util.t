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

done_testing;

use strict;
use warnings;
use utf8;

use Acme::CoC::Util qw/eq_any/;

use Test2::V0;

subtest 'eq_any' => sub {
    ok eq_any('test', [1, 2, 'test']);
    ok !eq_any('test', [1, 2]);
};

done_testing;

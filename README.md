# NAME

Acme::CoC::Dice - Dice role module for CoC TRPG.

# SYNOPSIS

    use Acme::CoC::Dice;

    my $dice_role = Acme::CoC::Dice->role('1d100');
    print $dice_role->{dices}; # this property can have some result with giving parameter as '2d6'.
    print $dice_role->{sum};

# DESCRIPTION

Acme::CoC::Dice is getting random number like 1d100.

# METHODS

## `role`

Gets random number like dice roling.
Format is "ndm" ("n" and "m" is Natural number). For example, it's like "1d6".

    my $result = Acme::CoC::Dice->role('1d6);

## `role_skill`

Runs "role" with giving "1d100". Usually we can play dice as "1d100" for using skill on CoC-TRPG.
This method is for it.

    my $result = Acme::CoC::Dice->role_skill;

# AUTHOR

bedoshi

# COPYRIGHT

Copyright 2021- bedoshi

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

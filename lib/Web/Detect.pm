package Web::Detect;

use strict;
use warnings;

our $VERSION = '0.03'; # VERSION

sub import {
    if (@_ > 1 && $_[1] eq 'detect_web') {
        no strict 'refs';
        *{ caller() . '::detect_web' } = \&detect_web;
    }
}

sub detect_web {
    my %res;

    if (defined $ENV{GATEWAY_INTERFACE} && $ENV{GATEWAY_INTERFACE} =~ m/^CGI/) {
        $res{cgi} = 1;
    }
    if ($ENV{MOD_PERL}) {
        $res{mod_perl} = 1;
    }
    if ($ENV{PLACK_ENV}) {
        $res{plack} = 1;
        $res{psgi} = 1;
    }

    return unless %res;
    \%res;
}

1;
#ABSTRACT: Detect if program is running under some web environment


__END__
=pod

=head1 NAME

Web::Detect - Detect if program is running under some web environment

=head1 VERSION

version 0.03

=head1 SYNOPSIS

 use Web::Detect qw(detect_web);
 say "Running under web" if detect_web();

=head1 DESCRIPTION

=head1 FUNCTIONS

=head2 detect_web() => HASHREF

Return undef if not detected running under any web environment.

Return a hash otherwise, with following keys: C<mod_perl> (bool, true if
detected running under mod_perl), C<plack> (bool, true if detected running under
Plack), C<cgi> (bool, true if detected running under CGI).

=head1 FAQ

=head2 What is the use of this module?

Usually I do it to decide whether to output HTML or plaintext. Running under
some web environment usually prefers HTML output.

=head1 TODO

=head1 SEE ALSO

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

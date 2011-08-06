package MooseX::Role::MissingMethodUtils;

use Moose::Role;
our $VERSION = '0.01';

sub AUTOLOAD
{
    my ($self, @params)  = @_;
    my ($name)           = our $AUTOLOAD =~ /::(\w+)$/;

    my $meth_ref        = $self->can('method_missing');

    if ( $meth_ref ) 
    {
        @_ = ($self, $name, @params);

        goto &{$meth_ref} if $meth_ref;
    }

    return;
}

1;

# ABSTRACT: Getting rid of boilerplate AUTOLOAD stuff

=head1 NAME

MooseX::Role::MissingMethodUtils

=head1 SYNOPSIS

    package Foo;
    use Moose;

    with 'MooseX::Role::MissingMethodUtils';

    sub method_missing {
        my ($self, $method_name, @params) = @_;

        if ( $method_name eq 'do_this' ) {
            Delegator->do_this; 
        }
    }

=head1 DESCRIPTION

This role will now introduce a method named method_missing. This method is called via AUTOLOAD as a last
resort in the calling chain. 

Three parameters will be passed in to help with delegation: ref to self,method name, and parameters.

=head1  METHODS

=head2  AUTOLOAD

Just does all the boilerplate autoloading stuff.

=head1  TODO

Add some other useful methods and filter capabilities.

=head1 AUTHOR

Logan Bell C<< <logan.bell@gmail.com> >>

=head1 COPYRIGHT & LICENSE

Copyright 2011, Logan Bell C<< <logan.bell@gmail.com> >>

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut



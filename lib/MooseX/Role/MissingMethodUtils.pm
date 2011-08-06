package MooseX::Role::MissingMethodUtils;

use Moose::Role;
our $VERSION = '0.01';

sub AUTOLOAD
{
    my ($self, @params)  = @_;
    my ($name)           = our $AUTOLOAD =~ /::(\w+)$/;

    my $meth_ref    = $self->can($name);

    @_ = ($self, $name, @params);

    goto &{$meth_ref} if $meth_ref;

    return;
}

sub can
{
    my ($self, $method) = @_;

    my $meth_ref = $self->SUPER::can($method);

    return $meth_ref if $meth_ref;

    $meth_ref = $self->SUPER::can('method_missing');

    return $meth_ref if $meth_ref;

}


1;

# ABSTRACT: Getting rid of boilerplate AUTOLOAD stuff


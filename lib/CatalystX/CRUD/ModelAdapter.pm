package CatalystX::CRUD::ModelAdapter;
use strict;
use warnings;
use base qw(
    CatalystX::CRUD
    Class::Accessor::Fast
);
use Class::C3;
use Carp;

__PACKAGE__->mk_accessors(qw( model_name model_meta ));

=head1 NAME

CatalystX::CRUD::ModelAdapter - make CRUD Controllers work with non-CRUD models

=head1 SYNOPSIS

 package My::ModelAdapter::Foo;
 use base qw( CatalystX::CRUD::ModelAdapter );
                      
 # must implement the following methods
 sub new_object { }
 sub fetch      { }
 sub search     { }
 sub iterator   { }
 sub count      { }
 sub make_query { }
 
 1;
 
 # then in your CX::CRUD::Controller subclass
 package MyApp::Controller::CRUD;
 use base qw( CatalystX::CRUD::Controller );
 
 __PACKAGE__->config(
    'model_adapter' => 'My::ModelAdapter::Foo'
 );
 
 1;
 
=head1 DESCRIPTION

CatalystX::CRUD::ModelAdapter allows you to use existing, non-CRUD Models with
the CatalystX::CRUD::Controller API. The ModelAdapter class implements a similar
API to the CX::CRUD::Model, but does not inherit from Catalyst::Model and should
not sit in the ::Model namespace. 

If a 'model_adapter' config value is present
in a CX::CRUD::Controller subclass, the ModelAdapter instance will be called
instead of the 'model_name' instance. The B<model_name> accessor is available
on the ModelAdapter instance and is set automatically at instantiation time
by the calling Controller.

This documentation is intended for ModelAdapter developers.

=head1 CONFIGURATION

You may configure your CXCM-derived Models in the usual way (see the Catalyst
Manual).

=head1 METHODS

CatalystX::CRUD::ModelAdapter inherits from CatalystX::CRUD.

The following methods should be implemented in your subclass.

=head2 new_object( I<context> )

Should return a new instance from the Model you are adapting.

=cut

sub new_object { shift->throw_error("must implement new_object"); }

=head2 fetch( I<context>, I<args> )

Should return an instance of the Model you are adapting, based
on I<args>.

=cut

sub fetch { shift->throw_error("must implement fetch") }

=head2 search( I<context>, I<args> )

Should return an arrayref of instances of the Model you are adapting,
based on I<args>.

=cut

sub search { shift->throw_error("must implement search") }

=head2 iterator( I<context>, I<args> )

Should return an iterator of instances of the Model you are adapting,
based on I<args>.

=cut

sub iterator { shift->throw_error("must implement iterator") }

=head2 count( I<context>, I<args> )

Should return an integer representing the numbef of matching instances
of the Model you are adapting, based on I<args>.

=cut

sub count { shift->throw_error("must implement count") }

=head2 make_query( I<context> )

Should return appropriate values for passing to search(), iterator() and
count(). See CataystX::CRUD::Model for examples.

=cut

sub make_query { shift->throw_error("must implement make_query()") }

=head1 CRUD Methods

The following methods are implemented in CatalystX::CRUD::Object when
using the CatalystX::CRUD::Model API. When using the ModelAdapter API, they
should be implemented in the adapter class.

=head2 create( I<context>, I<object> )

Should implement the C in CRUD.

=cut

sub create { shift->throw_error("must implement create()") }

=head2 read( I<context>, I<object> )

Should implement the R in CRUD.

=cut

sub read { shift->throw_error("must implement read()") }

=head2 update( I<context>, I<object> )

Should implement the U in CRUD.

=cut

sub update { shift->throw_error("must implement update()") }

=head2 delete( I<context>, I<object> )

Should implement the D in CRUD.

=cut

sub delete { shift->throw_error("must implement delete()") }

1;

__END__

=head1 AUTHOR

Peter Karman, C<< <perl at peknet.com> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-catalystx-crud at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=CatalystX-CRUD>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc CatalystX::CRUD

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/CatalystX-CRUD>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/CatalystX-CRUD>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=CatalystX-CRUD>

=item * Search CPAN

L<http://search.cpan.org/dist/CatalystX-CRUD>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008 Peter Karman, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
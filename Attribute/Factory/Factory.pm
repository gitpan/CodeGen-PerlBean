package CodeGen::PerlBean::Attribute::Factory;

use 5.006;
use strict;
use warnings;
use Error qw (:try);

require Exporter;
use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use CodeGen::PerlBean::Attribute::Factory ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our ( $VERSION ) = '$Revision: 0.1.0.1 $ ' =~ /\$Revision:\s+([^\s]+)/;

sub attribute {
	# Allow both styles CodeGen::PerlBean::Attribute::Factory->attribute and CodeGen::PerlBean::Attribute::Factory::attribute
	$_[0] eq 'CodeGen::PerlBean::Attribute::Factory' && shift;

	# Get options
	my $opt = shift || {};

	# Switch attribute type
	if (!defined ($opt->{type}) || $opt->{type} eq 'SINGLE') {
		require CodeGen::PerlBean::Attribute::Single;
		import CodeGen::PerlBean::Attribute::Single;
		return (CodeGen::PerlBean::Attribute::Single->new ($opt));
	} elsif ($opt->{type} eq 'BOOLEAN') {
		require CodeGen::PerlBean::Attribute::Boolean;
		import CodeGen::PerlBean::Attribute::Boolean;
		return (CodeGen::PerlBean::Attribute::Boolean->new ($opt));
	} elsif ($opt->{type} eq 'MULTI') {
		if ($opt->{unique}) {
			if ($opt->{ordered}) {
				require CodeGen::PerlBean::Attribute::Multi::Unique::Ordered;
				import CodeGen::PerlBean::Attribute::Multi::Unique::Ordered;
				return (CodeGen::PerlBean::Attribute::Multi::Unique::Ordered->new ($opt));
			} else {
				require CodeGen::PerlBean::Attribute::Multi::Unique;
				import CodeGen::PerlBean::Attribute::Multi::Unique;
				return (CodeGen::PerlBean::Attribute::Multi::Unique->new ($opt));
			}
		} else {
			require CodeGen::PerlBean::Attribute::Multi::Ordered;
			import CodeGen::PerlBean::Attribute::Multi::Ordered;
			return (CodeGen::PerlBean::Attribute::Multi::Ordered->new ($opt));
		}
	} else {
		throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::Factory::attribute, option 'type' must be one of 'BOOLEAN', 'SINGLE' or 'MULTI' and NOT '$opt->{type}'.");
	}
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

CodeGen::PerlBean::Attribute::Factory - Factory class to generate CodeGen::PerlBean::Attribute objects.

=head1 SYNOPSIS

See L<CodeGen::PerlBean>.

=head1 ABSTRACT

C<CodeGen::PerlBean::Attribute> object factory

=head1 DESCRIPTION

Instanciates C<CodeGen::PerlBean::Attribute>.

=head2 CONSTRUCTOR

None.

=head1 METHODS

=over

=item attribute (OPT_HASH_REF)

Returns C<CodeGen::PerlBean::Attribute> objects based on C<OPT_HASH_REF>. C<OPT_HASH_REF> is a hash reference used to pass initialization options. The selected subclass of C<CodeGen::PerlBean::Attribute> is initialized using C<OPT_HASH_REF>. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> used by this method may include:

=over

=item ordered

Boolean flag. Attribute to return must be an ordered list. Defaults to B<0>. Only makes sense if C<type> is B<MULTI>.

=item type

If C<type> is B<BOOLEAN> a C<CodeGen::PerlBean::Attribute::Boolean>, on B<SINGLE> a C<CodeGen::PerlBean::Attribute::Single> and on B<MULTI> a C<CodeGen::PerlBean::Attribute::Multi> is returned. Defaults to B<SINGLE>. B<NOTE:> B<type> has precedence over B<ordered> and B<unique>.

=item unique

Boolean flag. Items in list must be unique. Defaults to B<0>. Only makes sense if C<type> is B<MULTI>.

=back

Options for C<OPT_HASH_REF> used by the constructors of C<CodeGen::PerlBean::Attribute> classes may include:

=over

=item allow_empty

Boolean flag. Allowed the attribute to be empty. Defaults to B<1>. Doesn't make sense if B<type> is B<BOOLEAN>.

=item allow_isa

List of allowed classes. Must be an C<ARRAY> reference. Doesn't make sense if B<type> is B<BOOLEAN>.

=item allow_ref

List of allowed references. Must be an C<ARRAY> reference. Doesn't make sense if B<type> is B<BOOLEAN>.

=item allow_value

List of allowed values. Must be an C<ARRAY> reference. Doesn't make sense if B<type> is B<BOOLEAN>.

=item attribute_name

Attribute's name. Mandatory option.

=item default_value

Attribute's default value.

=item exception_class

Class to throw when exception occurs. Defaults to B<Error::Simple>.

=item mandatory

Boolean flag. States that the attribute is mandatory. Defaults to B<0>.

=item method_base

Set alternative method base name.

=item package

Package name. Defaults to B<main>.

=item short_description

Short attribute description.

=back

=back

=head1 SEE ALSO

L<CodeGen::PerlBean>
L<CodeGen::PerlBean::Attribute>
L<CodeGen::PerlBean::Attribute::Boolean>
L<CodeGen::PerlBean::Attribute::Multi>
L<CodeGen::PerlBean::Attribute::Multi::Ordered>
L<CodeGen::PerlBean::Attribute::Multi::Unique>
L<CodeGen::PerlBean::Attribute::Multi::Unique::Ordered>
L<CodeGen::PerlBean::Attribute::Single>

=head1 BUGS

None known (yet.)

=head1 HISTORY

First development: November 2002

=head1 AUTHOR

Vincenzo Zocca

=head1 COPYRIGHT

Copyright 2002 by Vincenzo Zocca

=head1 LICENSE

This file is part of the C<CodeGen::PerlBean> module hierarchy for Perl by
Vincenzo Zocca.

The CodeGen::PerlBean module hierarchy is free software; you can redistribute it
and/or modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2 of
the License, or (at your option) any later version.

The CodeGen::PerlBean module hierarchy is distributed in the hope that it will
be useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the CodeGen::PerlBean module hierarchy; if not, write to
the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
Boston, MA 02111-1307 USA

=cut


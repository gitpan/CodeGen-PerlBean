package CodeGen::PerlBean::Attribute::Single;

use 5.006;
use strict;
use warnings;

require Exporter;
use AutoLoader qw(AUTOLOAD);

#our @ISA = qw(Exporter);

# Is subclass from CodeGen::PerlBean::Attribute
use base qw (CodeGen::PerlBean::Attribute Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use CodeGen::PerlBean::Attribute::Single ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our ( $VERSION ) = '$Revision: 0.1.0.2 $ ' =~ /\$Revision:\s+([^\s]+)/;

sub writeMethods {
	my $self = shift;
	my $fh = shift;

	$self->writeSetMethod ($fh);
	$self->writeGetMethod ($fh);

}

sub writeDocMethods {
	my $self = shift;
	my $fh = shift;

	$self->writeSetDoc ($fh);
	$self->writeGetDoc ($fh);

}

sub writeSetMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $an_esc = $self->escQuote ($an);
	my $mb = $self->getMethodBase ();
	my $ec = $self->getExceptionClass ();
	my $pkg = $self->getPackage ();
	my $pkg_us = $self->getPackageUS ();


	# Method head
	$fh->print (<<EOF);
sub set$mb {
	my \$self = shift;
	my \$val = shift;

EOF

	# Check if value is allowed to be empty
	if (! $self->isAllowEmpty ()) {
		$fh->print (<<EOF);
	# Value for $an_esc is not allowed to be empty
	defined (\$val) || throw $ec ("ERROR: ${pkg}::set$mb, value may not be empty.");

EOF
	}

	# Check if isa/ref/value is allowed
	$fh->print (<<EOF);
	# Check if isa/ref/value is allowed
	\&valueIsAllowed ($an_esc, \$val) || throw $ec ("ERROR: ${pkg}::set$mb, the specified value '\$val' is not allowed.");

EOF

	# Assignment and method tail
	$fh->print (<<EOF);
	# Assignment
	\$self->{$pkg_us}{$an} = \$val;
}

EOF
}

sub writeSetDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $def = defined ($self->getDefaultValue ()) ? ' Default value at initialization is C<' . $self->getDefaultValue () . '>.' : '';
	my $empt = $self->isAllowEmpty () ? '' : ' C<VALUE> may not be C<undef>.';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';

	$fh->print (<<EOF);
\=item set${mb} (VALUE)

Set ${desc}. C<VALUE> is the value.${def}${empt}${exc}

EOF

	$self->writeDocClauses ($fh);
}

sub writeGetMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $pkg_us = $self->getPackageUS ();

	$fh->print (<<EOF);
sub get$mb {
	my \$self = shift;

	return (\$self->{$pkg_us}{$an});
}

EOF
}

sub writeGetDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';

	$fh->print (<<EOF);
\=item get${mb} ()

Returns ${desc}.

EOF
}

1;

__END__

=head1 NAME

CodeGen::PerlBean::Attribute::Single - contains SINGLE bean attribute information

=head1 SYNOPSIS

 use CodeGen::PerlBean::Attribute::Single;
 use IO::File;

 my $attr = CodeGen::PerlBean::Attribute::Single->new ({
 	attribute_name => 'my_single',
 	default_value => 'default value',
 	short_description => 'single attribute',
 });

 my $fh = IO::File ('> /tmp/foo-bar.pm');
 $attr->writeMethods ($fh);

=head1 ABSTRACT

SINGLE bean attribute information

=head1 DESCRIPTION

C<CodeGen::PerlBean::Attribute::Single> contains SINGLE bean attribute information. It is a subclass of C<CodeGen::PerlBean::Attribute>. Code and documentation methods are implemented.

=head1 CONSTRUCTOR

Inherited from L<CodeGen::PerlBean::Attribute>.

=head1 METHODS

Inherited/implemented from L<CodeGen::PerlBean::Attribute>.

=over

=item writeMethods (FILEHANDLE)

Writes code for B<set> and B<get> methods.

=item writeDocMethods (FILEHANDLE)

Writes documenation for B<set> and B<get> methods.

=back

=head1 SEE ALSO

L<CodeGen::PerlBean>
L<CodeGen::PerlBean::Attribute>
L<CodeGen::PerlBean::Attribute::Factory>
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

Vincent Zocca

=head1 COPYRIGHT

Copyright 2002 by Vincent Zocca

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


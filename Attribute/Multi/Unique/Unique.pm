package CodeGen::PerlBean::Attribute::Multi::Unique;

use 5.006;
use strict;
use warnings;

require Exporter;
use AutoLoader qw(AUTOLOAD);

#our @ISA = qw(Exporter);

# Is subclass from CodeGen::PerlBean::Attribute::Multi
use base qw (CodeGen::PerlBean::Attribute::Multi Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use CodeGen::PerlBean::Attribute::Multi::Unique ':all';
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
	$self->writeAddMethod ($fh);
	$self->writeDeleteMethod ($fh);
	$self->writeHasMethod ($fh);
	$self->writeGetMethod ($fh);
}

sub writeDocMethods {
	my $self = shift;
	my $fh = shift;

	$self->writeSetDoc ($fh);
	$self->writeAddDoc ($fh);
	$self->writeDeleteDoc ($fh);
	$self->writeHasDoc ($fh);
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

EOF

	# Check if list value is allowed to be empty
	if (! $self->isAllowEmpty ()) {
		$fh->print (<<EOF);
	# List value for $an_esc is not allowed to be empty
	scalar (\@_) || throw $ec ("ERROR: ${pkg}::set$mb, list value may not be empty.");

EOF
	}

	# Check if isas/refs/values are allowed
	$fh->print (<<EOF);
	# Check if isas/refs/values are allowed
	\&valueIsAllowed ($an_esc, \@_) || throw $ec ("ERROR: ${pkg}::set$mb, one ore more specified value(s) '\@_' is/are not allowed.");

EOF

	# Method tail
	$fh->print (<<EOF);
	# Empty list
	\$self->{$pkg_us}{$an} = {};

	# Add values
	foreach my \$val (\@_) {
		\$self->{$pkg_us}{$an}{\$val} = \$val;
	}
}

EOF
}

sub writeSetDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $def = defined ($self->getDefaultValue ()) ? ' Default value at initialization is C<' . $self->getDefaultValue () . '>.' : '';
	my $empt = $self->isAllowEmpty () ? '' : ' C<ARRAY> must at least have one element.';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';

	$fh->print (<<EOF);
\=item set${mb} (ARRAY)

Set ${desc} absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored.${def}${empt}${exc}

EOF

	$self->writeDocClauses ($fh);
}

sub writeAddMethod {
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
sub add$mb {
	my \$self = shift;

EOF

	# Check if isas/refs/values are allowed
	$fh->print (<<EOF);
	# Check if isas/refs/values are allowed
	\&valueIsAllowed ($an_esc, \@_) || throw $ec ("ERROR: ${pkg}::add$mb, one ore more specified value(s) '\@_' is/are not allowed.");

EOF

	# Method tail
	$fh->print (<<EOF);
	# Add values
	foreach my \$val (\@_) {
		\$self->{$pkg_us}{$an}{\$val} = \$val;
	}
}

EOF
}

sub writeAddDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';

	$fh->print (<<EOF);
\=item add${mb} (ARRAY)

Add additional values on ${desc}. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, Multiple occurences of the same element cause the last occurence to be inserted.${exc}

EOF

	$self->writeDocClauses ($fh);
}

sub writeDeleteMethod {
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
sub delete$mb {
	my \$self = shift;

EOF

	# Check if list value is allowed to be empty
	if (! $self->isAllowEmpty ()) {
		$fh->print (<<EOF);
	# List value for $an_esc is not allowed to be empty
	my \%would_delete = ();
	foreach my \$val (\@_) {
		\$would_delete{\$val} = \$val if (exists (\$self->{$pkg_us}{$an}{\$val}))
	}
	(scalar (keys (\%{\$self->{$pkg_us}{$an}})) == scalar (keys (\%would_delete))) && throw $ec ("ERROR: ${pkg}::delete$mb, list value may not be empty.");

EOF
	}

	# Method tail
	$fh->print (<<EOF);
	# Delete values
	my \$del = 0;
	foreach my \$val (\@_) {
		exists (\$self->{$pkg_us}{$an}{\$val}) || next;
		delete (\$self->{$pkg_us}{$an}{\$val});
		\$del++;
	}
	return (\$del);
}

EOF
}

sub writeDeleteDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $empt = $self->isAllowEmpty () ? '' : ' After deleting at least one element must remain.';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';

	$fh->print (<<EOF);
\=item delete${mb} (ARRAY)

Delete elements from ${desc}.${empt} Returns the number of deleted elements.${exc}

EOF

	$self->writeDocClauses ($fh);
}

sub writeHasMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $pkg_us = $self->getPackageUS ();

	$fh->print (<<EOF);
sub has$mb {
	my \$self = shift;

	# Count occurences
	my \$count = 0;
	foreach my \$val (\@_) {
		\$count += exists (\$self->{$pkg_us}{$an}{\$val});
	}
	return (\$count);
}

EOF
}

sub writeHasDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';

	$fh->print (<<EOF);
\=item has${mb} (ARRAY)

Returns the count of items in C<ARRAY> that are in ${desc}.

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

	# Return values
	return (values (\%{\$self->{$pkg_us}{$an}}));
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

Returns an C<ARRAY> containing ${desc}.

EOF

	$self->writeDocClauses ($fh);
}
1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

CodeGen::PerlBean::Attribute::Multi::Unique - contains unique MULTI bean attribute information

=head1 SYNOPSIS

 use CodeGen::PerlBean::Attribute::Multi::Unique;
 use IO::File;

 my $attr = CodeGen::PerlBean::Attribute::Multi::Unique->new ({
 	attribute_name => 'my_multi_unique',
 	default_value => [qw (foo bar)],
 	short_description => 'multi unique attribute',
 });

 my $fh = IO::File ('> /tmp/foo-bar.pm');
 $attr->writeMethods ($fh);

=head1 ABSTRACT

Unique MULTI bean attribute information

=head1 DESCRIPTION

C<CodeGen::PerlBean::Attribute::Multi::Unique> contains unique MULTI bean attribute information. It is a subclass of C<CodeGen::PerlBean::Attribute::Multi>. Code and documentation methods from C<CodeGen::PerlBean::Attribute> are implemented.

=head1 CONSTRUCTOR

Inherited from L<CodeGen::PerlBean::Attribute>.

=head1 METHODS

Inherited/implemented from L<CodeGen::PerlBean::Attribute>.

=over

=item writeMethods (FILEHANDLE)

Writes code for B<set>, B<add>, B<delete>, B<has> and B<get> methods.

=item writeDocMethods (FILEHANDLE)

Writes documenation for B<set>, B<add>, B<delete>, B<has> and B<get> methods.

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


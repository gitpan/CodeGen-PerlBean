package CodeGen::PerlBean;

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

# This allows declaration	use CodeGen::PerlBean ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our ( $VERSION ) = '$Revision: 0.1.0.2 $ ' =~ /\$Revision:\s+([^\s]+)/;

my @MON = qw (
	January
	February
	March
	April
	May
	June
	July
	August
	September
	October
	November
	December
);
my %ALLOW_ISA = (
	'attribute' => ['CodeGen::PerlBean::Attribute'],
);
my %ALLOW_REF = (
);
my %ALLOW_VALUE = (
);
my %DEFAULT_VALUE = (
	'exception_class' => 'Error::Simple',
	'package' => 'main',
	'short_description' => 'NO DESCRIPTION AVAILABLE',
);

sub new {
	my $class = shift;

	my $self = {};
	bless ($self, (ref($class) || $class));
	return ($self->_initialize (@_));
}

sub _initialize {
	my $self = shift;
	my $opt = defined ($_[0]) ? shift : {};

	# Check $opt
	ref ($opt) eq 'HASH' || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::_initialize, first argument must be 'HASH' reference.");

	# attribute, MULTI
	if (exists ($opt->{attribute})) {
		ref ($opt->{attribute}) eq 'ARRAY' || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::_initialize, specified value for option 'attribute' must be an 'ARRAY' reference.");
		$self->setAttribute (@{$opt->{attribute}});
	}

	# exception_class, SINGLE, with default value
	$self->setExceptionClass (exists ($opt->{exception_class}) ? $opt->{exception_class} : $DEFAULT_VALUE{exception_class});

	# package, SINGLE, with default value
	$self->setPackage (exists ($opt->{package}) ? $opt->{package} : $DEFAULT_VALUE{package});

	# short_description, SINGLE, with default value
	$self->setShortDescription (exists ($opt->{short_description}) ? $opt->{short_description} : $DEFAULT_VALUE{short_description});

	return ($self);
}

sub setAttribute {
	my $self = shift;

	# Check if isas/refs/values are allowed
	&valueIsAllowed ('attribute', @_) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setAttribute, one ore more specified value(s) '@_' is/are not allowed.");

	# Empty list
	$self->{CodeGen_PerlBean_Attribute}{attribute}{ARRAY} = [];
	$self->{CodeGen_PerlBean_Attribute}{attribute}{HASH} = {};

	# Add values
	foreach my $val (@_) {
		next if (exists ($self->{CodeGen_PerlBean_Attribute}{attribute}{HASH}{$val}));
		push (@{$self->{CodeGen_PerlBean_Attribute}{attribute}{ARRAY}}, $val);
		$self->{CodeGen_PerlBean_Attribute}{attribute}{HASH}{$val} = $val;
	}
}

sub pushAttribute {
	my $self = shift;

	# Check if isas/refs/values are allowed
	&valueIsAllowed ('attribute', @_) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::pushAttribute, one ore more specified value(s) '@_' is/are not allowed.");

	# Push values
	foreach my $val (@_) {
		next if (exists ($self->{CodeGen_PerlBean_Attribute}{attribute}{HASH}{$val}));
		push (@{$self->{CodeGen_PerlBean_Attribute}{attribute}{ARRAY}}, $val);
		$self->{CodeGen_PerlBean_Attribute}{attribute}{HASH}{$val} = $val;
	}
}

sub popAttribute {
	my $self = shift;

	# Pop value
	my $val = pop (@{$self->{CodeGen_PerlBean_Attribute}{attribute}{ARRAY}});
	delete ($self->{CodeGen_PerlBean_Attribute}{attribute}{HASH}{$val});
	return ($val);
}

sub shiftAttribute {
	my $self = shift;

	# Shift value
	my $val = shift (@{$self->{CodeGen_PerlBean_Attribute}{attribute}{ARRAY}});
	delete ($self->{CodeGen_PerlBean_Attribute}{attribute}{HASH}{$val});
	return ($val);
}

sub unshiftAttribute {
	my $self = shift;

	# Check if isas/refs/values are allowed
	&valueIsAllowed ('attribute', @_) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::unshiftAttribute, one ore more specified value(s) '@_' is/are not allowed.");

	# Unshift values
	foreach my $val (reverse (@_)) {
		next if (exists ($self->{CodeGen_PerlBean_Attribute}{attribute}{HASH}{$val}));
		unshift (@{$self->{CodeGen_PerlBean_Attribute}{attribute}{ARRAY}}, $val);
		$self->{CodeGen_PerlBean_Attribute}{attribute}{HASH}{$val} = $val;
	}
}

sub hasAttribute {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{CodeGen_PerlBean_Attribute}{attribute}{HASH}{$val});
	}
	return ($count);
}

sub getAttribute {
	my $self = shift;

	# Return the list
	return (@{$self->{CodeGen_PerlBean_Attribute}{attribute}{ARRAY}});
}

sub setExceptionClass {
	my $self = shift;
	my $val = shift;

	# Value for 'exception_class' is not allowed to be empty
	defined ($val) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setExceptionClass, value may not be empty.");

	# Check if isa/ref/value is allowed
	&valueIsAllowed ('exception_class', $val) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setExceptionClass, the specified value '$val' is not allowed.");

	# Assignment
	$self->{CodeGen_PerlBean_Attribute}{exception_class} = $val;
}

sub getExceptionClass {
	my $self = shift;

	return ($self->{CodeGen_PerlBean_Attribute}{exception_class});
}

sub setPackage {
	my $self = shift;
	my $val = shift;

	# Value for 'package' is not allowed to be empty
	defined ($val) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setPackage, value may not be empty.");

	# Check if isa/ref/value is allowed
	&valueIsAllowed ('package', $val) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setPackage, the specified value '$val' is not allowed.");

	# Assignment
	$self->{CodeGen_PerlBean_Attribute}{package} = $val;
}

sub getPackage {
	my $self = shift;

	return ($self->{CodeGen_PerlBean_Attribute}{package});
}

sub setShortDescription {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/value is allowed
	&valueIsAllowed ('short_description', $val) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setShortDescription, the specified value '$val' is not allowed.");

	# Assignment
	$self->{CodeGen_PerlBean_Attribute}{short_description} = $val;
}

sub getShortDescription {
	my $self = shift;

	return ($self->{CodeGen_PerlBean_Attribute}{short_description});
}

sub valueIsAllowed {
	my $name = shift;

	# Value is allowed if no ALLOW clauses exist for the named attribute
	if (!exists ($ALLOW_ISA{$name}) && !exists ($ALLOW_REF{$name}) && !exists ($ALLOW_VALUE{$name})) {
		return (1);
	}

	# At this point, all values in @_ must to be allowed
	CHECK_VALUES:
	foreach my $val (@_) {
		# Check ALLOW_ISA
		if (ref ($val) && exists ($ALLOW_ISA{$name})) {
			foreach my $class (@{$ALLOW_ISA{$name}}) {
				&UNIVERSAL::isa ($val, $class) && next CHECK_VALUES;
			}
		}
		
		# Check ALLOW_REF
		if (ref ($val) && exists ($ALLOW_REF{$name})) {
			exists ($ALLOW_REF{$name}{$val}) && next CHECK_VALUES;
		}

		# Check ALLOW_VALUE
		if (!ref ($val) && exists ($ALLOW_VALUE{$name})) {
			exists ($ALLOW_VALUE{$name}{$val}) && next CHECK_VALUES;
		}

		# We caught a not allowed value
		return (0);
	}

	# OK, all values are allowed
	return (1);
}

sub write {
	my $self = shift;
	my $fh = shift;

	$self->writeClassHead ($fh);

	$self->writeAllowIsaHash ($fh);

	$self->writeAllowRefHash ($fh);

	$self->writeAllowValueHash ($fh);

	$self->writeDefaultValueHash ($fh);

	$self->writeNewMethod ($fh);

	$self->writeInitMethodHead ($fh);

	$self->writeInitMethodBody ($fh);

	$self->writeInitMethodTail ($fh);

	foreach my $attribute ($self->getAttribute ()) {
		$attribute->setPackage ($self->getPackage ());
		$attribute->writeMethods ($fh);
	}

	$self->writeValueAllowedMethod ($fh);

	$self->writeClassTail ($fh);

	$self->writeDocHead ($fh);

	$self->writeDocConstructorHead ($fh);

	$self->writeDocConstructorBody ($fh);

	$self->writeDocConstructorTail ($fh);

	$self->writeDocMethodsHead ($fh);

	$self->writeDocMethodsBody ($fh);

	$self->writeDocMethodsTail ($fh);

	$self->writeDocTail ($fh);
}

sub writeClassHead {
	my $self = shift;
	my $fh = shift;

	$fh->print ('package '. $self->getPackage () . ";\n\n");
	$fh->print (<<EOF);
use strict;
use Error qw (:try);

EOF
}

sub writeAllowIsaHash {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
my \%ALLOW_ISA = (
EOF
	foreach my $attribute ($self->getAttribute ()) {
		$attribute->writeAllowIsa ($fh);
	}
	$fh->print (<<EOF);
);
EOF

}

sub writeAllowRefHash {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
my \%ALLOW_REF = (
EOF
	foreach my $attribute ($self->getAttribute ()) {
		$attribute->writeAllowRef ($fh);
	}
	$fh->print (<<EOF);
);
EOF

}

sub writeAllowValueHash {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
my \%ALLOW_VALUE = (
EOF
	foreach my $attribute ($self->getAttribute ()) {
		$attribute->writeAllowValue ($fh);
	}
	$fh->print (<<EOF);
);
EOF

}

sub writeDefaultValueHash {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
my \%DEFAULT_VALUE = (
EOF
	foreach my $attribute ($self->getAttribute ()) {
		$attribute->writeDefaultValue ($fh);
	}
	$fh->print (<<EOF);
);
EOF

}

sub writeNewMethod {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);

sub new {
	my \$class = shift;

	my \$self = {};
	bless (\$self, (ref(\$class) || \$class));
	return (\$self->_initialize (\@_));
}

EOF
}

sub writeInitMethodHead {
	my $self = shift;
	my $fh = shift;

	my $pkg = $self->getPackage ();

	$fh->print (<<EOF);
sub _initialize {
	my \$self = shift;
	my \$opt = defined (\$_[0]) ? shift : {};

	# Check \$opt
	ref (\$opt) eq 'HASH' || throw Error::Simple ("ERROR: ${pkg}::_initialize, first argument must be 'HASH' reference.");

EOF
}

sub writeInitMethodBody {
	my $self = shift;
	my $fh = shift;

	foreach my $attribute ($self->getAttribute ()) {
		$attribute->writeOptInit ($fh);
	}
}

sub writeInitMethodTail {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
	return (\$self);
}

EOF
}

sub writeValueAllowedMethod {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
sub valueIsAllowed {
	my \$name = shift;

	# Value is allowed if no ALLOW clauses exist for the named attribute
	if (!exists (\$ALLOW_ISA{\$name}) && !exists (\$ALLOW_REF{\$name}) && !exists (\$ALLOW_VALUE{\$name})) {
		return (1);
	}

	# At this point, all values in \@_ must to be allowed
	CHECK_VALUES:
	foreach my \$val (\@_) {
		# Check ALLOW_ISA
		if (ref (\$val) && exists (\$ALLOW_ISA{\$name})) {
			foreach my \$class (\@{\$ALLOW_ISA{\$name}}) {
				&UNIVERSAL::isa (\$val, \$class) && next CHECK_VALUES;
			}
		}
		
		# Check ALLOW_REF
		if (ref (\$val) && exists (\$ALLOW_REF{\$name})) {
			exists (\$ALLOW_REF{\$name}{\$val}) && next CHECK_VALUES;
		}

		# Check ALLOW_VALUE
		if (!ref (\$val) && exists (\$ALLOW_VALUE{\$name})) {
			exists (\$ALLOW_VALUE{\$name}{\$val}) && next CHECK_VALUES;
		}

		# We caught a not allowed value
		return (0);
	}

	# OK, all values are allowed
	return (1);
}

EOF
}

sub writeClassTail {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
1;

EOF
}

sub writeDocHead {
	my $self = shift;
	my $fh = shift;

	my $pkg = $self->getPackage ();
	my $desc = $self->getShortDescription ();

	$fh->print (<<EOF);
__END__

\=head1 NAME

${pkg} - ${desc}

\=head1 SYNOPSIS

 TODO

\=head1 DESCRIPTION

C<$pkg> TODO

EOF
}

sub writeDocConstructorHead {
	my $self = shift;
	my $fh = shift;

	my $pkg = $self->getPackage ();
	my $mand = '';
	my $pre = '[';
	my $post = ']';
	foreach my $attribute ($self->getAttribute ()) {
		if ($attribute->isMandatory ()) {
			$pre = '';
			$post = '';
			$mand = ' C<OPT_HASH_REF> is mandatory.';
			last;
		}
	}

	$fh->print (<<EOF);
\=head1 CONSTRUCTOR

\=over

EOF

	$fh->print (<<EOF);
\=item new (${pre}OPT_HASH_REF${post})

Creates a new C<$pkg> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options.$mand

Options for C<OPT_HASH_REF> may include:

\=over

EOF
}

sub writeDocConstructorBody {
	my $self = shift;
	my $fh = shift;

	foreach my $attribute ($self->getAttribute ()) {
		$attribute->writeDocInit ($fh);
	}
}

sub writeDocConstructorTail {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
\=back

\=back

EOF
}

sub writeDocMethodsHead {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
\=head1 METHODS

\=over

EOF

}

sub writeDocMethodsBody {
	my $self = shift;
	my $fh = shift;

	foreach my $attribute ($self->getAttribute ()) {
		$attribute->writeDocMethods ($fh);
	}
}

sub writeDocMethodsTail {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
\=back

EOF
}

sub writeDocTail {
	my $self = shift;
	my $fh = shift;

	my $m = $MON[(localtime ())[4]];
	my $y = (localtime ())[5] + 1900;
	my $p = (getpwuid ($>))[6];

	$fh->print (<<EOF);
\=head1 SEE ALSO

TODO

\=head1 BUGS

TODO

\=head1 HISTORY

First development: ${m} ${y}

\=head1 AUTHOR

${p}

\=head1 COPYRIGHT

Copyright ${y} by ${p}

\=head1 LICENSE

TODO

\=cut
EOF
}
1;

__END__

=head1 NAME

CodeGen::PerlBean - Class to generate bean like Perl modules

=head1 SYNOPSIS

 use strict;
 use IO::File;
 use CodeGen::PerlBean;
 use CodeGen::PerlBean::Attribute::Factory;
 
 # Attribute descriptions
 my @attr = (
 	{
 		attribute_name => 'attribute',
 		type => 'MULTI',
 		unique => 1,
 		short_description => 'the list \'CodeGen::PerlBean::Attribute\' objects',
 		ordered => 1,
 	},
 	{
 		attribute_name => 'exception_class',
 		allow_empty => 0,
 		default_value => 'Error::Simple',
 		short_description => 'class to throw when exception occurs',
 	},
 	{
 		attribute_name => 'package',
 		allow_empty => 0,
 		default_value => 'main',
 		short_description => 'package name',
 	},
 	{
 		attribute_name => 'short_description',
 		short_description => 'attribute description',
 		default_value => 'NO DESCRIPTION AVAILABLE',
 	},
 );
 
 # Create CodeGen::PerlBean object
 my $bean = CodeGen::PerlBean->new ({package => 'CodeGen::PerlBean'});
 
 # Add CodeGen::PerlBean::Attribute objects
 foreach my $attr (@attr) {
 	$bean->pushAttribute (CodeGen::PerlBean::Attribute::Factory->attribute ($attr));
 }
 
 # Write the CodeGen::PerlBean object to a file
 my $fh = IO::File->new ('> PerlBean-gen.pm');
 $bean->write ($fh);

=head1 ABSTRACT

Code generation for bean like Perl modules

=head1 DESCRIPTION

C<CodeGen::PerlBean> generates bean like Perl module code. That is, it generates code with for a module with attributes (properties) and the attribute's access methods (B<set>, B<push>, B<pop>, B<shift>, B<unshift>, B<has>, B<get> or B<is>, depending on the type of attribute). The attribute base types are B<BOOLEAN>, B<SINGLE> and B<MULTI>. B<BOOLEAN> attributes may be set to C<0> or C<1>. B<SINGLE> attributes may contain any scalar. B<MULTI> attributes contain a set of values (ordered/not ordered and unique/not unique).

The attribute insertion methods (C<setAttribute ()>, C<pushAttribute ()> and unshiftAttribute ()) accept C<CodeGen::PerlBean::Attribute> objects. However, C<CodeGen::PerlBean::Attribute> are best generated using C<CodeGen::PerlBean::Attribute::Factory>. See the sample in the B<SYNOPSIS> section.

Finaly, the actual bean code is written using the C<wite ()> method.

The generated code should to be free of syntax errors. It's intended to be mixed with the application logic you intend to write yourself.

Background information: Of course the attribute code in C<CodeGen::PerlBean> and C<CodeGen::PerlBean::Attribute> are actually generated using this method.

=head1 CONSTRUCTOR

=over

=item new ([OPT_HASH_REF])

Creates a new C<CodeGen::PerlBean> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item attribute

Passed to L<setAttribute ()>. Must be an C<ARRAY> reference.

=item exception_class

Passed to L<setExceptionClass ()>. Defaults to B<Error::Simple>.

=item package

Passed to L<setPackage ()>. Defaults to B<main>.

=item short_description

Passed to L<setShortDescription ()>.

=back

=back

=head1 METHODS

=over

=item setAttribute (ARRAY)

Set the list 'CodeGen::PerlBean::Attribute' objects absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the first occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item pushAttribute (ARRAY)

Push additional values on the list 'CodeGen::PerlBean::Attribute' objects. C<ARRAY> is the list value. The push may not yield to multiple identical elements in the list. Hence, Multiple occurences of the same element are ignored. On error an exception C<Error::Simple> is thrown.

=item popAttribute ()

Pop and return an element off the list 'CodeGen::PerlBean::Attribute' objects. On error an exception C<Error::Simple> is thrown.

=item shiftAttribute ()

Shift and return an element off the list 'CodeGen::PerlBean::Attribute' objects. On error an exception C<Error::Simple> is thrown.

=item unshiftAttribute (ARRAY)

Unshift additional values on the list 'CodeGen::PerlBean::Attribute' objects. C<ARRAY> is the list value. The push may not yield to multiple identical elements in the list. Hence, Multiple occurences of the same element are ignored. On error an exception C<Error::Simple> is thrown.

=item hasAttribute (ARRAY)

Returns the count of items in C<ARRAY> that are in the list 'CodeGen::PerlBean::Attribute' objects.

=item getAttribute ()

Returns an C<ARRAY> containing the list 'CodeGen::PerlBean::Attribute' objects.

=item setExceptionClass (VALUE)

Set class to throw when exception occurs. C<VALUE> is the value. Default value at initialization is C<Error::Simple>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item getExceptionClass ()

Returns class to throw when exception occurs.

=item setPackage (VALUE)

Set package name. C<VALUE> is the value. Default value at initialization is C<main>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item getPackage ()

Returns package name.

=item setShortDescription (VALUE)

Set attribute description. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item getShortDescription ()

Returns attribute description.

=item write (FILEHANDLE)

Write the Perl class code to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=back

=head1 SEE ALSO

L<CodeGen::PerlBean::Attribute>
L<CodeGen::PerlBean::Attribute::Boolean>
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


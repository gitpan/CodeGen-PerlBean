package CodeGen::PerlBean::Attribute;

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

# This allows declaration	use CodeGen::PerlBean::Attribute ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our ( $VERSION ) = '$Revision: 0.1.0.1 $ ' =~ /\$Revision:\s+([^\s]+)/;

my %ALLOW_ISA = (
);
my %ALLOW_REF = (
);
my %ALLOW_VALUE = (
);
my %DEFAULT_VALUE = (
	'allow_empty' => 1,
	'exception_class' => 'Error::Simple',
	'mandatory' => 0,
	'package' => 'main',
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
	ref ($opt) eq 'HASH' || throw Error::Simple ("ERROR: CodeGen::PerlBean::_initialize, first argument must be 'HASH' reference.");

	# allow_empty, BOOLEAN, with default value
	$self->setAllowEmpty (exists ($opt->{allow_empty}) ? $opt->{allow_empty} : $DEFAULT_VALUE{allow_empty});

	# allow_isa, MULTI
	if (exists ($opt->{allow_isa})) {
		ref ($opt->{allow_isa}) eq 'ARRAY' || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::_initialize, specified value for option 'allow_isa' must be an 'ARRAY' reference.");
		$self->setAllowIsa (@{$opt->{allow_isa}});
	}

	# allow_ref, MULTI
	if (exists ($opt->{allow_ref})) {
		ref ($opt->{allow_ref}) eq 'ARRAY' || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::_initialize, specified value for option 'allow_ref' must be an 'ARRAY' reference.");
		$self->setAllowRef (@{$opt->{allow_ref}});
	}

	# allow_value, MULTI
	if (exists ($opt->{allow_value})) {
		ref ($opt->{allow_value}) eq 'ARRAY' || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::_initialize, specified value for option 'allow_value' must be an 'ARRAY' reference.");
		$self->setAllowValue (@{$opt->{allow_value}});
	}

	# attribute_name, SINGLE, mandatory
	exists ($opt->{attribute_name}) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::_initialize, option 'attribute_name' is mandatory.");
	$self->setAttributeName ($opt->{attribute_name});

	# default_value, SINGLE
	exists ($opt->{default_value}) && $self->setDefaultValue ($opt->{default_value});

	# exception_class, SINGLE, with default value
	$self->setExceptionClass (exists ($opt->{exception_class}) ? $opt->{exception_class} : $DEFAULT_VALUE{exception_class});

	# mandatory, BOOLEAN, with default value
	$self->setMandatory (exists ($opt->{mandatory}) ? $opt->{mandatory} : $DEFAULT_VALUE{mandatory});

	# method_base, SINGLE
	exists ($opt->{method_base}) && $self->setMethodBase ($opt->{method_base});

	# package, SINGLE, with default value
	$self->setPackage (exists ($opt->{package}) ? $opt->{package} : $DEFAULT_VALUE{package});

	# short_description, SINGLE
	exists ($opt->{short_description}) && $self->setShortDescription ($opt->{short_description});

	return ($self);
}

sub setAllowEmpty {
	my $self = shift;

	if (shift) {
		$self->{CodeGen_PerlBean_Attribute}{allow_empty} = 1;
	} else {
		$self->{CodeGen_PerlBean_Attribute}{allow_empty} = 0;
	}
}

sub isAllowEmpty {
	my $self = shift;

	if ($self->{CodeGen_PerlBean_Attribute}{allow_empty}) {
		return (1);
	} else {
		return (0);
	}
}

sub setAllowIsa {
	my $self = shift;

	# Check if isas/refs/values are allowed
	&valueIsAllowed ('allow_isa', @_) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setAllowIsa, one ore more specified value(s) '@_' is/are not allowed.");

	# Empty list
	$self->{CodeGen_PerlBean_Attribute}{allow_isa} = {};

	# Add values
	foreach my $val (@_) {
		$self->{CodeGen_PerlBean_Attribute}{allow_isa}{$val} = $val;
	}
}

sub addAllowIsa {
	my $self = shift;

	# Check if isas/refs/values are allowed
	&valueIsAllowed ('allow_isa', @_) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::addAllowIsa, one ore more specified value(s) '@_' is/are not allowed.");

	# Add values
	foreach my $val (@_) {
		$self->{CodeGen_PerlBean_Attribute}{allow_isa}{$val} = $val;
	}
}

sub deleteAllowIsa {
	my $self = shift;

	# Delete values
	my $del = 0;
	foreach my $val (@_) {
		exists ($self->{CodeGen_PerlBean_Attribute}{allow_isa}{$val}) || next;
		delete ($self->{CodeGen_PerlBean_Attribute}{allow_isa}{$val});
		$del++;
	}
	return ($del);
}

sub hasAllowIsa {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{CodeGen_PerlBean_Attribute}{allow_isa}{$val});
	}
	return ($count);
}

sub getAllowIsa {
	my $self = shift;

	# Return values
	return (values (%{$self->{CodeGen_PerlBean_Attribute}{allow_isa}}));
}

sub setAllowRef {
	my $self = shift;

	# Check if isas/refs/values are allowed
	&valueIsAllowed ('allow_ref', @_) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setAllowRef, one ore more specified value(s) '@_' is/are not allowed.");

	# Empty list
	$self->{CodeGen_PerlBean_Attribute}{allow_ref} = {};

	# Add values
	foreach my $val (@_) {
		$self->{CodeGen_PerlBean_Attribute}{allow_ref}{$val} = $val;
	}
}

sub addAllowRef {
	my $self = shift;

	# Check if isas/refs/values are allowed
	&valueIsAllowed ('allow_ref', @_) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::addAllowRef, one ore more specified value(s) '@_' is/are not allowed.");

	# Add values
	foreach my $val (@_) {
		$self->{CodeGen_PerlBean_Attribute}{allow_ref}{$val} = $val;
	}
}

sub deleteAllowRef {
	my $self = shift;

	# Delete values
	my $del = 0;
	foreach my $val (@_) {
		exists ($self->{CodeGen_PerlBean_Attribute}{allow_ref}{$val}) || next;
		delete ($self->{CodeGen_PerlBean_Attribute}{allow_ref}{$val});
		$del++;
	}
	return ($del);
}

sub hasAllowRef {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{CodeGen_PerlBean_Attribute}{allow_ref}{$val});
	}
	return ($count);
}

sub getAllowRef {
	my $self = shift;

	# Return values
	return (values (%{$self->{CodeGen_PerlBean_Attribute}{allow_ref}}));
}

sub setAllowValue {
	my $self = shift;

	# Check if isas/refs/values are allowed
	&valueIsAllowed ('allow_value', @_) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setAllowValue, one ore more specified value(s) '@_' is/are not allowed.");

	# Empty list
	$self->{CodeGen_PerlBean_Attribute}{allow_value} = {};

	# Add values
	foreach my $val (@_) {
		$self->{CodeGen_PerlBean_Attribute}{allow_value}{$val} = $val;
	}
}

sub addAllowValue {
	my $self = shift;

	# Check if isas/refs/values are allowed
	&valueIsAllowed ('allow_value', @_) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::addAllowValue, one ore more specified value(s) '@_' is/are not allowed.");

	# Add values
	foreach my $val (@_) {
		$self->{CodeGen_PerlBean_Attribute}{allow_value}{$val} = $val;
	}
}

sub deleteAllowValue {
	my $self = shift;

	# Delete values
	my $del = 0;
	foreach my $val (@_) {
		exists ($self->{CodeGen_PerlBean_Attribute}{allow_value}{$val}) || next;
		delete ($self->{CodeGen_PerlBean_Attribute}{allow_value}{$val});
		$del++;
	}
	return ($del);
}

sub hasAllowValue {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{CodeGen_PerlBean_Attribute}{allow_value}{$val});
	}
	return ($count);
}

sub getAllowValue {
	my $self = shift;

	# Return values
	return (values (%{$self->{CodeGen_PerlBean_Attribute}{allow_value}}));
}

sub setAttributeName {
	my $self = shift;
	my $val = shift;

	# Value for 'attribute_name' is not allowed to be empty
	defined ($val) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setAttributeName, value may not be empty.");

	# Check if isa/ref/value is allowed
	&valueIsAllowed ('attribute_name', $val) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setAttributeName, the specified value '$val' is not allowed.");

	# Assignment
	$self->{CodeGen_PerlBean_Attribute}{attribute_name} = $val;
}

sub getAttributeName {
	my $self = shift;

	return ($self->{CodeGen_PerlBean_Attribute}{attribute_name});
}

sub setDefaultValue {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/value is allowed
	&valueIsAllowed ('default_value', $val) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setDefaultValue, the specified value '$val' is not allowed.");

	# Assignment
	$self->{CodeGen_PerlBean_Attribute}{default_value} = $val;
}

sub getDefaultValue {
	my $self = shift;

	return ($self->{CodeGen_PerlBean_Attribute}{default_value});
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

sub setMandatory {
	my $self = shift;

	if (shift) {
		$self->{CodeGen_PerlBean_Attribute}{mandatory} = 1;
	} else {
		$self->{CodeGen_PerlBean_Attribute}{mandatory} = 0;
	}
}

sub isMandatory {
	my $self = shift;

	if ($self->{CodeGen_PerlBean_Attribute}{mandatory}) {
		return (1);
	} else {
		return (0);
	}
}

sub setMethodBase {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/value is allowed
	&valueIsAllowed ('method_base', $val) || throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::setMethodBase, the specified value '$val' is not allowed.");

	# Assignment
	$self->{CodeGen_PerlBean_Attribute}{method_base} = $val;
}

sub getMethodBase {
	my $self = shift;

	defined ($self->{CodeGen_PerlBean_Attribute}{method_base}) && return ($self->{CodeGen_PerlBean_Attribute}{method_base});

	my @method_base = split (/_/, $self->getAttributeName ());
	foreach my $part (@method_base) {
		$part = ucfirst ($part);
	}
	return (join ('', @method_base));
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

sub getPackageUS {
	my $self = shift;

	my $pkg = $self->getPackage ();
	$pkg =~ s/:+/_/g;
	return ($pkg);
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
				&UNIVERSAL::isa ($class, $val) && next CHECK_VALUES;
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

sub writeAllowIsa {
	my $self = shift;
	my $fh = shift;

	if (scalar ($self->getAllowIsa ())) {
		my $an = $self->getAttributeName ();
		my $dv = $self->escQuote (sort ($self->getAllowIsa ()));
		$fh->print (<<EOF);
\t$an => [ $dv ],
EOF
	}
}

sub writeAllowRef {
	my $self = shift;
	my $fh = shift;

	if (scalar ($self->getAllowRef ())) {
		my $an = $self->getAttributeName ();
		$fh->print (<<EOF);
\t$an => {
EOF
		my @dv = sort ($self->escQuoteL ($self->getAllowRef ()));
		foreach my $dv (@dv) {
			$fh->print (<<EOF);
\t\t$dv => 1,
EOF
		}
		$fh->print (<<EOF);
\t},
EOF
	}
}

sub writeAllowValue {
	my $self = shift;
	my $fh = shift;

	if (scalar ($self->getAllowValue ())) {
		my $an = $self->getAttributeName ();
		$fh->print (<<EOF);
\t$an => {
EOF
		my @dv = sort ($self->escQuoteL ($self->getAllowValue ()));
		foreach my $dv (@dv) {
			$fh->print (<<EOF);
\t\t$dv => 1,
EOF
		}
		$fh->print (<<EOF);
\t},
EOF
	}
}

sub writeDefaultValue {
	my $self = shift;
	my $fh = shift;

	defined ($self->getDefaultValue ()) || return;

	my $an = $self->getAttributeName ();
	if ($self->isa ('CodeGen::PerlBean::Attribute::Multi')) {
		my $dv = $self->escQuote (@{$self->getDefaultValue ()});
		$fh->print (<<EOF);
\t'$an' => [ $dv ],
EOF
	} else {
		my $dv = $self->escQuote ($self->getDefaultValue ());
		$fh->print (<<EOF);
\t'$an' => $dv,
EOF
	}
}

sub writeOptInit {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $ec = $self->getExceptionClass ();
	my $pkg = $self->getPackage ();

	# Comment
	$fh->print ("\t# $an, ", $self->type ());
	$self->isMandatory () && $fh->print (', mandatory');
	defined ($self->getDefaultValue ()) && $fh->print (', with default value');
	$fh->print ("\n");

	# isMandatory check
	if ($self->isMandatory ()) {
		$fh->print (<<EOF);
	exists (\$opt->{$an}) || throw $ec ("ERROR: ${pkg}::_initialize, option '$an' is mandatory.");
EOF
	}

	# MULTI / non MULTI
	if ($self->isa ('CodeGen::PerlBean::Attribute::Multi')) {
		# MULTI
		my $pre = '';
		if (! $self->isMandatory ()) {
			$pre .= "\t";
			$fh->print (<<EOF);
	if (exists (\$opt->{$an})) {
EOF
		}
		$fh->print (<<EOF);
	${pre}ref (\$opt->{$an}) eq 'ARRAY' || throw $ec ("ERROR: ${pkg}::_initialize, specified value for option '$an' must be an 'ARRAY' reference.");
	${pre}\$self->set$mb (\@{\$opt->{$an}});
EOF
		# MULTI default value
		if (! $self->isMandatory () && defined ($self->getDefaultValue ())) {
			$fh->print (<<EOF);
	} else {
		\$self->set$mb (\@{\$DEFAULT_VALUE{$an}});
EOF
		}
		if (! $self->isMandatory ()) {
			$fh->print (<<EOF);
	}
EOF
		}
	} else {
		# Non MULTI
		if ($self->isMandatory ()) {
			$fh->print (<<EOF);
	\$self->set$mb (\$opt->{$an});
EOF
		} else {
			if (defined ($self->getDefaultValue ())) {
			$fh->print (<<EOF);
	\$self->set$mb (exists (\$opt->{$an}) ? \$opt->{$an} : \$DEFAULT_VALUE{$an});
EOF
			} else {
			$fh->print (<<EOF);
	exists (\$opt->{$an}) && \$self->set$mb (\$opt->{$an});
EOF
			}
		}
	}

	# Empty line
	$fh->print ("\n");
}


sub writeDocInit {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $mand = $self->isMandatory () ? ' Mandatory option.' : '';
	my $multi = ($self->isa ('CodeGen::PerlBean::Attribute::Multi')) ? ' Must be an C<ARRAY> reference.' : '';
	my $def = '';
	if (defined ($self->getDefaultValue ())) {
		if ($self->isa ('CodeGen::PerlBean::Attribute::Multi')) {
			my $list = join ('> , B<', $self->escQuoteL (@{$self->getDefaultValue ()}));
			$def = ' Defaults to B<[> B<' . $list . '> B<]>.';
		} else {
			$def = ' Defaults to B<' . $self->getDefaultValue () . '>.';
		}
	}

	$fh->print (<<EOF);
\=item $an

Passed to L<set$mb ()>.${multi}${mand}${def}

EOF
}

sub escQuoteL {
	my $self = shift;

	my @in = @_;
	my @el = ();
	foreach my $el (@in) {
		$el = $self->escQuote ($el);
		push (@el, $el);
	}
	return (@el);
}

sub escQuote {
	my $self = shift;

	my @in = @_;
	my @el = ();
	foreach my $el (@in) {
		if ($el =~ /^\s*[+-]?\s*\d*$/) {
			$el = (int ($el));
		} else {
			$el =~ s/'/\\'/g;
			$el = '\'' . $el . '\'';
		}
		push (@el, $el);
	}
	return (join (', ', @el));
}

sub writeMethods {
	throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::writeMethods, call this method in a subclass that has implemented it.");
}

sub writeDocMethods {
	throw Error::Simple ("ERROR: CodeGen::PerlBean::Attribute::writeDocMethods, call this method in a subclass that has implemented it.");
}

sub writeDocClauses {
	my $self = shift;
	my $fh = shift;

	return if (!scalar ($self->getAllowIsa ()) && !scalar ($self->getAllowRef ()) && !scalar ($self->getAllowValue ()));

	$fh->print (<<EOF);
\=over

EOF

	$self->writeDocClausesAllowIsa ($fh);
	$self->writeDocClausesAllowRef ($fh);
	$self->writeDocClausesAllowValue ($fh);

	$fh->print (<<EOF);
\=back

EOF
}

sub writeDocClausesAllowIsa {
	my $self = shift;
	my $fh = shift;

	return if (!scalar ($self->getAllowIsa ()));

	$fh->print (<<EOF);
\=item VALUE must be a (sub)class of:

\=over

EOF

	foreach my $class (sort ($self->getAllowIsa ())) {
		$fh->print (<<EOF);
\=item ${class}

EOF
	}

	$fh->print (<<EOF);
\=back

EOF
}

sub writeDocClausesAllowRef {
	my $self = shift;
	my $fh = shift;

	return if (!scalar ($self->getAllowRef ()));
	my $or = scalar ($self->getAllowIsa ()) ? 'Or, ' : '';

	$fh->print (<<EOF);
\=item ${or}VALUE must be a reference of:

\=over

EOF

	foreach my $class (sort ($self->getAllowRef ())) {
		$fh->print (<<EOF);
\=item ${class}

EOF
	}

	$fh->print (<<EOF);
\=back

EOF
}

sub writeDocClausesAllowValue {
	my $self = shift;
	my $fh = shift;

	return if (!scalar ($self->getAllowValue ()));
	my $or = scalar ($self->getAllowRef ()) ? 'Or, ' : '';

	$fh->print (<<EOF);
\=item ${or}VALUE must be a one of:

\=over

EOF

	foreach my $class (sort ($self->getAllowValue ())) {
		$fh->print (<<EOF);
\=item ${class}

EOF
	}

	$fh->print (<<EOF);
\=back

EOF
}

sub type {
	my $self = shift;

	$self->isa ('CodeGen::PerlBean::Attribute::Boolean') && return ('BOOLEAN');
	$self->isa ('CodeGen::PerlBean::Attribute::Single') && return ('SINGLE');
	$self->isa ('CodeGen::PerlBean::Attribute::Multi') && return ('MULTI');
}

1;

__END__

=head1 NAME

CodeGen::PerlBean::Attribute - contains bean attribute information

=head1 SYNOPSIS

None. This is an abstract class.

=head1 ABSTRACT

Abstract bean attribute information

=head1 DESCRIPTION

C<CodeGen::PerlBean::Attribute> abstract class for bean attribute information. Attribute access methods are implemented. Code and documentation generation interface methods are defined.

=head1 CONSTRUCTOR

=over

=item new (OPT_HASH_REF)

Creates a new C<CodeGen::PerlBean::Attribute> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item allow_empty

Passed to L<setAllowEmpty ()>. Defaults to B<1>.

=item allow_isa

Passed to L<setAllowIsa ()>. Must be an C<ARRAY> reference.

=item allow_ref

Passed to L<setAllowRef ()>. Must be an C<ARRAY> reference.

=item allow_value

Passed to L<setAllowValue ()>. Must be an C<ARRAY> reference.

=item attribute_name

Passed to L<setAttributeName ()>. Mandatory option.

=item default_value

Passed to L<setDefaultValue ()>.

=item exception_class

Passed to L<setExceptionClass ()>. Defaults to B<Error::Simple>.

=item mandatory

Passed to L<setMandatory ()>. Defaults to B<0>.

=item method_base

Passed to L<setMethodBase ()>.

=item package

Passed to L<setPackage ()>. Defaults to B<main>.

=item short_description

Passed to L<setShortDescription ()>.

=back

=back

=head1 METHODS

=over

=item setAllowEmpty (VALUE)

State that the attribute is allowed to be empty. C<VALUE> is the value. Default value at initialization is C<1>. On error an exception C<Error::Simple> is thrown.

=item isAllowEmpty ()

Returns whether the attribute is allowed to be empty or not.

=item setAllowIsa (ARRAY)

Set the list of allowed classes absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item addAllowIsa (ARRAY)

Add additional values on the list of allowed classes. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, Multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item deleteAllowIsa (ARRAY)

Delete elements from the list of allowed classes. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item hasAllowIsa (ARRAY)

Returns the count of items in C<ARRAY> that are in the list of allowed classes.

=item getAllowIsa ()

Returns an C<ARRAY> containing the list of allowed classes.

=item setAllowRef (ARRAY)

Set the list of allowed references absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item addAllowRef (ARRAY)

Add additional values on the list of allowed references. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, Multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item deleteAllowRef (ARRAY)

Delete elements from the list of allowed references. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item hasAllowRef (ARRAY)

Returns the count of items in C<ARRAY> that are in the list of allowed references.

=item getAllowRef ()

Returns an C<ARRAY> containing the list of allowed references.

=item setAllowValue (ARRAY)

Set the list of allowed values absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item addAllowValue (ARRAY)

Add additional values on the list of allowed values. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, Multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item deleteAllowValue (ARRAY)

Delete elements from the list of allowed values. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item hasAllowValue (ARRAY)

Returns the count of items in C<ARRAY> that are in the list of allowed values.

=item getAllowValue ()

Returns an C<ARRAY> containing the list of allowed values.

=item setAttributeName (VALUE)

Set attribute's name. C<VALUE> is the value. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item getAttributeName ()

Returns attribute's name.

=item setDefaultValue (VALUE)

Set attribute's default value. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item getDefaultValue ()

Returns attribute's default value.

=item setExceptionClass (VALUE)

Set class to throw when exception occurs. C<VALUE> is the value. Default value at initialization is C<Error::Simple>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item getExceptionClass ()

Returns class to throw when exception occurs.

=item setMandatory (VALUE)

State that the attribute is mandatory. C<VALUE> is the value. Default value at initialization is C<0>. On error an exception C<Error::Simple> is thrown.

=item isMandatory ()

Returns whether the attribute is mandatory or not.

=item setMethodBase (VALUE)

Set method base name. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item getMethodBase ()

Returns method base name.

=item setPackage (VALUE)

Set package name. C<VALUE> is the value. Default value at initialization is C<main>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item getPackage ()

Returns package name.

=item getPackageUS ()

Returns package name with C<:+> replaces by C <_>.

=item setShortDescription (VALUE)

Set attribute description. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item getShortDescription ()

Returns attribute description.

=item writeAllowIsa (FILEHANDLE)

Write C<%ALLOW_ISA> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeAllowRef (FILEHANDLE)

Write C<%ALLOW_REF> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeAllowValue (FILEHANDLE)

Write C<%ALLOW_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDefaultValue (FILEHANDLE)

Write C<%DEFAULT_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeOptInit (FILEHANDLE)

Write C<_initialize ()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocInit (FILEHANDLE)

Write documentation for C<_initialize ()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeMethods (FILEHANDLE)

Write the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocMethods (FILEHANDLE)

Write documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=back

=head1 SEE ALSO

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



# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 2 };
use CodeGen::PerlBean;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

use IO::File;
use CodeGen::PerlBean::Attribute::Factory;

my @attribute_class = (
	{
		attribute_name => 'b1',
		type => 'BOOLEAN',
	},
	{
		attribute_name => 'b2',
		type => 'BOOLEAN',
		default_value => 1,
	},
	{
		attribute_name => 'b3',
		type => 'BOOLEAN',
		mandatory => 1,
	},
	{
		attribute_name => 'b4',
		type => 'BOOLEAN',
		default_value => 1,
		mandatory => 1,
	},

	{
		attribute_name => 's1',
		type => 'SINGLE',
	},
	{
		attribute_name => 's2',
		type => 'SINGLE',
		allow_empty => 0,
	},
	{
		attribute_name => 's3',
		type => 'SINGLE',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
	},
	{
		attribute_name => 's4',
		type => 'SINGLE',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
		allow_ref => [qw (refFoo refBar)],
	},
	{
		attribute_name => 's5',
		type => 'SINGLE',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
		allow_ref => [qw (refFoo refBar)],
		allow_value => [qw (valueFoo valueBar)],
	},
	{
		attribute_name => 's6',
		type => 'SINGLE',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
		allow_ref => [qw (refFoo refBar)],
		allow_value => [qw (valueFoo valueBar)],
		mandatory => 1,
	},

	{
		attribute_name => 'm1',
		type => 'MULTI',
	},
	{
		attribute_name => 'm2',
		type => 'MULTI',
		allow_empty => 0,
	},
	{
		attribute_name => 'm3',
		type => 'MULTI',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
	},
	{
		attribute_name => 'm4',
		type => 'MULTI',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
		allow_ref => [qw (refFoo refBar)],
	},
	{
		attribute_name => 'm5',
		type => 'MULTI',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
		allow_ref => [qw (refFoo refBar)],
		allow_value => [qw (valueFoo valueBar)],
	},
	{
		attribute_name => 'm6',
		type => 'MULTI',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
		allow_ref => [qw (refFoo refBar)],
		allow_value => [qw (valueFoo valueBar)],
		mandatory => 1,
	},
	{
		attribute_name => 'm7',
		type => 'MULTI',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
		allow_ref => [qw (refFoo refBar)],
		allow_value => [qw (valueFoo valueBar)],
		mandatory => 1,
		ordered => 1,
	},
	{
		attribute_name => 'm8',
		type => 'MULTI',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
		allow_ref => [qw (refFoo refBar)],
		allow_value => [qw (valueFoo valueBar)],
		mandatory => 1,
		unique => 1,
	},
	{
		attribute_name => 'm9',
		type => 'MULTI',
		allow_empty => 0,
		allow_isa => [qw (isaFoo isaBar)],
		allow_ref => [qw (refFoo refBar)],
		allow_value => [qw (valueFoo valueBar)],
		mandatory => 1,
		ordered => 1,
		unique => 1,
	},
);

my $bean = CodeGen::PerlBean->new ({package => 'test'});

foreach my $attribute_class (@attribute_class) {
	my $attribute = CodeGen::PerlBean::Attribute::Factory->attribute ($attribute_class);
	$attribute->{short_description} = $attribute->{attribute_name};
	$bean->pushAttribute ($attribute);
}

my $fh = IO::File->new ('> test.out');

$bean->write ($fh);

system ('perl -c test.out > /dev/null 2>&1');
if ($?>>8) {
	ok (0);
} else {
	ok (1);
}

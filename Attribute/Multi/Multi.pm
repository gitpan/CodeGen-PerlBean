package CodeGen::PerlBean::Attribute::Multi;

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

# This allows declaration	use CodeGen::PerlBean::Attribute::Multi ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our ( $VERSION ) = '$Revision: 0.1.0.2 $ ' =~ /\$Revision:\s+([^\s]+)/;


# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;

__END__

=head1 NAME

CodeGen::PerlBean::Attribute::Multi - contains MULTI bean attribute information

=head1 SYNOPSIS

None. This is an abstract class.

=head1 ABSTRACT

MULTI bean attribute abstraction

=head1 DESCRIPTION

C<CodeGen::PerlBean::Attribute::Multi> is a subclass of C<CodeGen::PerlBean::Attribute> and it's only function is to group it's subclasses.

=head1 CONSTRUCTOR

Inherited from L<CodeGen::PerlBean::Attribute>.

=head1 METHODS

Inherited from L<CodeGen::PerlBean::Attribute>.

=head1 SEE ALSO

L<CodeGen::PerlBean>
L<CodeGen::PerlBean::Attribute>
L<CodeGen::PerlBean::Attribute::Boolean>
L<CodeGen::PerlBean::Attribute::Factory>
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

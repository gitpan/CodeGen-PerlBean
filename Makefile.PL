# $Revision: 0.1.0.2 $
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	NAME		=> 'CodeGen::PerlBean',
	VERSION_FROM	=> 'PerlBean.pm', # finds $VERSION
	PREREQ_PM	=> {
		Error => 0,
	},
	($] >= 5.005 ? ## Add these new keywords supported since 5.005
	(ABSTRACT_FROM => 'PerlBean.pm', # retrieve abstract from module
	AUTHOR => 'Vincenzo Zocca <Vincenzo@Zocca.com>') : ()),
	clean => {
		FILES => 'test.out',
	},
);

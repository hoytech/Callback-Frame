use ExtUtils::MakeMaker;

my $preop =
    'perldoc -uT $(VERSION_FROM) | tee $(DISTVNAME)/README.pod > README.pod;' .
    'pod2text README.pod | tee $(DISTVNAME)/README > README';

WriteMakefile(
  NAME => 'Callback::Frame',
  VERSION_FROM => 'lib/Callback/Frame.pm',
  LIBS => [''],
  INC => '-I lib/',
  PREREQ_PM => {
    'Guard' => 0,
  },
  dist => {
    PREOP => $preop,
  },
);

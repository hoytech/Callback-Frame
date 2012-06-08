use strict;

use Callback::Frame;
use Test::More tests => 5; 


my ($cb);

our $foo = 123;

frame(name => "base frame",
      local => __PACKAGE__ . '::foo',
      code => sub {

  $cb = frame(code => sub {
    my $err = $@;
    is($err, 'pass me through');
    is($foo, undef);
    $foo = 234;
    die "byebye";
  }, catch => sub {
    my $err = $@;
    ok($err =~ /^byebye/);
  });

})->();

is($foo, 123);

{
  local $@ = 'pass me through';
  $cb->();
  ## is($@, 'pass me through'); ## clobbers $@ but maybe this is OK
}

is($foo, 123);

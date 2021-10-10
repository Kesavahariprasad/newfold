package Database;
use DBI
use strict;
sub new {
   my $class = shift;
   my $self = {
	   driver => "mysql"; 
       database => "TESTDB";
       dsn => "DBI:$driver:database=$database";
       userid => "testuser";
       password => "test123";
   };
   bless $self, $class;
   return $self;
}

sub connectDB{
	my $dbh = DBI->connect($self->{dsn}, $self->{userid}, $self->{password} ) or die $DBI::errstr;
	return $dbh;	
}

sub disconnectDB{
	my($self,$dbh) = @_;
	$rc = $dbh->disconnect  or warn $dbh->errstr;
}
1;

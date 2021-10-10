#!/usr/bin/perl 

package Products;
use Database;
use strict;
sub new {
   my $class = shift;
   my $self = {
   };
   bless $self, $class;
   return $self;
}
#add customer
sub addCustomer {
   my ( $self, $customer_name ,$email ) = @_;
   $self->{customer_name} = $customer_name;
   $self->{email} = $email;
   my $sql = "insert into Customer_info(customer_name,email) values(?,?)";
   my $dbObject = new Database();
   my $dbh = $dbObject->connect();
   my $sth = $dbh->prepare($sql);
   $sth->execute($self->{customer_name}, $self->{email}) or die $DBI::errstr;
   $sth->finish();
   $dbh->commit or die $DBI::errstr;
   $dbObject->disconnectDB($dbh);
}
1;
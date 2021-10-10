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
#for adding products 
sub addProduct {
   my ( $self, $product_name ,$domain ) = @_;
   $self->{product_name} = $product_name;
   $self->{domain} = $domain;
   my $sql = "insert into Product_info(prod_name,domain) values(?,?)";
   my $dbObject = new Database();
   my $dbh = $dbObject->connect();
   my $sth = $dbh->prepare($sql);
   $sth->execute($self->{product_name}, $self->{domain}) or die $DBI::errstr;
   $sth->finish();
   $dbh->commit or die $DBI::errstr;
   $dbObject->disconnectDB($dbh);
}

#get product details
sub getProductDetails{
	my($self,$product_name) = @_;
	my $sql = "select prod_id,prod_name,domain 
	           from Product_info where prod_name=?";
	my $dbObject = new Database();
    my $dbh = $dbObject->connect()
	my $sth = $dbh->prepare($sql);
    $sth->execute($product_name) or die $DBI::errstr;
    return $sth;
}
1;
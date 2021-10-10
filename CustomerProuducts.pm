#The full Perl Package for adding/removing products
package CustomerProducts;
use strict;
use Products;
use Customer;
use Database;
our @ISA = qw(Products,Customer);

sub new {
   my $class = shift;
   my $self = {};
   bless $self, $class;
   return $self;
}

#for adding products
sub addProductToCustomer{
	my($self, $customer_id,$product_name,$start_date,$duration_months) = @_;
	my $prodctObj = new Products();
	my $sth = $prodctObj->getProductDetails($product_name);
	my $rows = $sth->rows;
	my @row = $sth->fetchrow_array();
	          $sth->finish();
	my $prod_id = $row[0];
	my $prod_name = $row[1];
	my $domain = $row[2];
	my $sql = "insert into Customer_Prod_info(cust_id,prod_id,start_date,duration_months) values (?,?,?,?)";
	my $dbObject = new Database();
    my $dbh = $dbObject->connect();
    my $sth = $dbh->prepare($sql);
       $sth->execute($customer_id,$prod_id,$start_date,$duration_months) or die $DBI::errstr;
       $sth->finish();
       $dbh->commit or die $DBI::errstr;
       $dbObject->disconnectDB($dbh);
}

#for removing products
sub removeCustomerProducts{
	my($self, $customer_id,$product_name,$$domain) = @_;
	my $prodctObj = new Products();
	my $sth = $prodctObj->getProductDetails($product_name);
	my $rows = $sth->rows;
	my @row = $sth->fetchrow_array();
	          $sth->finish();
	my $prod_id = $row[0];
	my $sql = "delete from Customer_Prod_info where cust_id=? and prod_id=?";
	my $dbObject = new Database();
    my $dbh = $dbObject->connect();
    my $sth = $dbh->prepare($sql);
       $sth->execute($customer_id,$prod_id) or die $DBI::errstr;
       $sth->finish();
       $dbh->commit or die $DBI::errstr;
       $dbObject->disconnectDB($dbh);
}
				
1;
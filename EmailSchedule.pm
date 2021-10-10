package EmailSchedule;
use strict;
use Database;
sub new {
   my $class = shift;
   my $self = {};
   bless $self, $class;
   return $self;
}

sub List_and_store_email_schedule{
	my($self) = @_;
	my $sql = " select CustomerID , ProductName , Domain, EmailDate
                from
				(select ci.cust_name as CustomerID ,
	                  pi.prod_name ProductName ,
					  pi.domain as Domain ,
					  DATE_ADD(cpi.start_date, pec.days_b4_expiry INTERVAL  MONTH) as EmailDate
	           from Customer_Prod_info cpi
               inner join 
               Product_info pi 
               on cpi.prod_id = pi.prod_id	
               inner join Customer_info ci
               on cpi.cust_id = ci.cust_id	
               left join product_email_configs pec
               on cpi.prod_id = pec.prod_id
               where pec.days_b4_expiry is not null	
               union	
               select ci.cust_name as CustomerID ,
	                  pi.prod_name ProductName ,
					  pi.domain as Domain ,
					  DATE_ADD(cpi.start_date, pec.days_after_activation INTERVAL  MONTH) as EmailDate
	           from Customer_Prod_info cpi
               inner join 
               Product_info pi 
               on cpi.prod_id = pi.prod_id	
               inner join Customer_info ci
               on cpi.cust_id = ci.cust_id	
               left join product_email_configs pec
               on cpi.prod_id = pec.prod_id
               where pec.days_after_activation is not null)				   
	           ";
	my $dbObject = new Database();
    my $dbh = $dbObject->connect()
	my $sth = $dbh->prepare($sql);
    $sth->execute() or die $DBI::errstr;
	print "customerID ProductName Domain EmailDate";
	
   while (my @row = $sth->fetchrow_array()) {
   my ($customerID,$productName,$domain,$emailDate ) = @row;
   print $customerID." ".$productName." ".$domain." ".$emailDate;
    $sql = "insert into email_transactions(customer_id,product_name,domain,emailDate)
	        values(?,?,?,?)";
	my $sth1 = $dbh->prepare($sql);
	   $sth1->execute($customerID,$productName,$domain,$emailDate) or die $DBI::errstr;
	   $sth1->finish();
	   
	
	
    }
   $sth->finish();
   $dbObject->disconnectDB($dbh);
			   
			   
}

1;

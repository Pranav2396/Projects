<html>
<?php
        $mc=$fc=0;
	$fname=$_POST['fname'];
	$lname=$_POST['lname'];
	$email=$_POST['email'];
	$Phoneno=$_POST['Phoneno'];
	$address=$_POST['address'];
        $t=time();
        $td = date('Y-m-d',$t);
        $foodname=$_POST['foodname'];
        $fquantity=$_POST['quantity'];
        $amount=$_POST['amount'];
        $status=""; $remark=""; $tr="";
        $count=0;
        $countavb=0;

       if(isset($_POST['Moneycheck']))
        $mc=1;
       if(isset($_POST['Foodcheck']))
        $fc=1;

        $age=$_POST['age'];

	session_start(); 

$db_name="floods";

$res=mysql_connect("localhost","root","");
if(!$res)
	{
		die("Unable to connect".mysql_error());
	}

$db_is=mysql_select_db("$db_name");

if(!$db_is){
die("Unable to select database".mysql_error());
} 


$sql1="insert into food_donation values('','$Phoneno','$email','$foodname','$fquantity','$status','$remark',now(),'$tr')" ;
$sql2="insert into money_donation values('','$Phoneno','$email','$amount','$status','$remark',now(),'$tr')" ;
$sql="insert into user_details values('$Phoneno','$email','$fname','$lname','$age','$address','$mc','$fc')" ;


$sqlsel="select * from user_details where PhoneNo='$Phoneno' and EmailAddress='$email'";
$ret=mysql_query($sqlsel,$res);


$sqlavb="select * from foodavailability where FoodName='$foodname'";
$ret1=mysql_query($sqlavb,$res);


if($ret1)
 {
   $countavb=mysql_num_rows($ret1);
   if($countavb>=1)
   {
      $int="select * from foodavailability where FoodName='$foodname'";
      $sqlupdfd=mysql_query($int,$res);
      $row=mysql_fetch_row($sqlupdfd);
      $value=$row[1];

      $ans=$value+$fquantity;

      $sqlfd="update foodavailability set QuantityAvb='$ans' where FoodName='$foodname'";
      $retupdfd=mysql_query($sqlfd,$res);
   }
   else
   {
      $sqlinsfd="insert into foodavailability values('$foodname','$fquantity')";
      $retinsfd=mysql_query($sqlinsfd,$res);
   }
 }


if($ret)
  $count=mysql_num_rows($ret);

if($fc==1)
{
  $retval1=mysql_query($sql1,$res);
}

if($mc==1)
{
  $retval2=mysql_query($sql2,$res);
}

 echo $count."\n";
 echo $Phoneno."\n";
 echo $email."\n";
 if($count>=1)
 {
   if($mc==1)
    {
       $sqlupd="update user_details set MoneyD=1 where PhoneNo='$Phoneno' and EmailAddress='$email'";
       $retupd=mysql_query($sqlupd,$res);
    }
  
    if($fc==1)
    {
       $sqlupd="update user_details set FoodD=1 where PhoneNo='$Phoneno' and EmailAddress='$email'";
       $retupd=mysql_query($sqlupd,$res);
    }
 }
 else
   { $retval = mysql_query( $sql, $res );

   if(! $retval ) {
      die('Could not enter data: ' . mysql_error());
   }
    }

echo "Data entered\n";
echo $mc;

mysql_close($res);

?>

</html>
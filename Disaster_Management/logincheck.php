<html>
<head>
<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title>Disaster management</title>
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600" rel="stylesheet" type="text/css" />
	<link href='http://fonts.googleapis.com/css?family=Abel|Satisfy' rel='stylesheet' type='text/css' />
	<link href="style.css" rel="stylesheet" type="text/css" media="screen" />
	<link rel="stylesheet" href="w3.css">
        <script type="text/javascript" src="jquery-1.11.0.min.js"></script>
</head>
<body>

<form action="automessage.php" method="post">
<div id="send">
<p>
  <input class="w3-check" type="checkbox" id="sms" name="ssms">
  <label class="w3-validate">SMS</label>
</p>

<p>
  <input class="w3-check" type="checkbox" id="email" name="semail">
  <label class="w3-validate">Email</label>
</p>

<input class="send_btn" name="email" type="submit" value="Submit" alt="Submit" title="Send" /><br>
</body>
</div>
</form>


<?php
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


$username=$_POST['email'];
$password=$_POST['password'];

$username = stripslashes($username);
$password = stripslashes($password);


if($username=="" || $password=="")
{
   header("location:/Flood/survival.php");
exit;
}
else
{
$sql="select AEmailAddress,APassword from admin where AEmailAddress='$username' and APassword='$password'";
$result1=mysql_query($sql,$res);

$count=mysql_num_rows($result1);

if($count==1)
{
$_SESSION['logged_in'] = "1";
$_SESSION['username1']=$username;
//header("location:/control.php");
exit;
}
else 
{
$_SESSION['message']="success";
header("location:/Flood/survival.php");
exit;
}
}
?>
</html>
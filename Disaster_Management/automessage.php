<html>
<?php
include('way2sms-api.php');
require_once 'swiftmailer-5.x/lib/swift_required.php';
$sms=$email=0;

 if(isset($_POST['ssms']))
        $sms=1;
 if(isset($_POST['semail']))
        $email=1;

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

$id="9320550219";
   $pass="P2445T";
   $no=array();
 
	  
      $int="select * from departments";
      $ret=mysql_query($int,$res);
	  
if($sms==1)
{  
	  while($row_sections=mysql_fetch_array($ret))
        {
            $value=$row_sections[4];
			$message="We need your help  ".$row_sections[2]."\nBy Akshay";
			$res = sendWay2SMS($id, $pass, $value, $message);
        }
     
    if (is_array($res))
        echo "Message sent\n";

}

$transport = Swift_SmtpTransport::newInstance('smtp.gmail.com', 465, 'ssl')
        ->setUsername('rr459595@gmail.com')
        ->setPassword('exam459595');
 
         $mailer = Swift_Mailer::newInstance($transport);

if($email==1)
{	     
	    while($row_sections=mysql_fetch_array($ret))
	   {
	     $to = $row_sections[6];
         $subject = "Floods";
         
         $messagebody = "We need your help ".$row_sections[2]."\nBy Akshay.";   
         
       
        $message = Swift_Message::newInstance($subject)
          ->setFrom(array('rr459595@gmail.com'))
          ->setTo(array($to))
          ->setBody($messagebody);

          $result = $mailer->send($message);    
	   }
	   
	  
	  echo"Message sent";
}

?>
</html>
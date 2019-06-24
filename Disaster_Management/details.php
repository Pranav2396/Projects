<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--
Design by TEMPLATED
http://templated.co
Released for free under the Creative Commons Attribution License

Name       : Breakeven
Description: A two-column, fixed-width design with dark color scheme.
Version    : 1.0
Released   : 20130509

-->
<html xmlns="http://www.w3.org/1999/xhtml">

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
   
        <script type="text/javascript" src="validate.js"></script>
        <script type="text/javascript">

        $(document).ready(function(){
        $("#fooddata").hide();
        $("#moneydata").hide();

        $("#Foodcheck").change(function(){
	      if(this.checked)
                {$("#fooddata").slideDown();
                 $("#fooddata").animate({
								width:'+1000px',
								height:'+180px',

				});
			$("#fooddata").css({
								'position':'relative',
								'top':'10px',
				});
                }
              else
                $("#fooddata").hide();		                       	
             });			

        
        $("#Moneycheck").change(function(){
	     if(this.checked){
                $("#moneydata").slideDown();		
		          $("#moneydata").animate({
								width:'+1000px',
								height:'+80px',

				});
			$("#moneydata").css({
								'position':'relative',
								'top':'10px',
				});
                         }
               else
                 $("#moneydata").hide();	
             });			
        });
     </script>
</head>

<body>
	<div id="wrapper">
		<div id="header-wrapper">
			<div id="header" class="container">
				<div id="logo">
					<h1><a href="#">FLOOD RELIEF</a></h1>
				</div>
				<div id="menu">
					<ul>
						<li class="current_page_item"><a href="#">Homepage</a></li>
						<li><a href="#">Donate</a></li>
						<li><a href="#">Download</a></li>
						<li><a href="#">About</a></li>
						<li><a href="#">Login</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- end #header -->
    <body>

<div class="w3-container" width="30%" > 

<div class="w3-container w3-blue " >
<h2>Input Form</h2>
</div>

<form name="feedback" method="post" action="abc.php" onsubmit="return validate()" class="w3-container">

<p>
<label>First Name</label>
<input class="w3-input" name="fname" type="text"></p>

<p>
<label>Last Name</label>
<input class="w3-input" name="lname" type="text"></p>

<p>
<label>Email</label>
<input class="w3-input" name="email" type="text"></p>

<p>
<label>Phone Number</label>
<input class="w3-input" name="Phoneno" type="text"></p>
<p>

<label>Address</label>
<input class="w3-input" name="address" type="text"></p>

<p>
<label>Age</label>
<input class="w3-input" name="age" type="text"></p>

  <div id="money">
  <p>
  <input class="w3-check" type="checkbox" id="Moneycheck" name="Moneycheck">
  <label class="w3-validate">Money</label></p>

  <div id="moneydata">
    <label>Amount</label>
    <input class="w3-input" name="amount" type="text"></p>
  </div>
  </div>
 
  <div id="food">
  <p>
  <input class="w3-check" name="Foodcheck" id="Foodcheck" type="checkbox" >
  <label class="w3-validate">Food</label></p>
   <div id="fooddata">
     <label>FoodName</label>
    <input class="w3-input" name="foodname" type="text"></p>

     <label>Quantity</label>
    <input class="w3-input" name="quantity" type="text"></p>
   </div>
  </div>

<input class="send_btn" type="submit" value="Submit" alt="Submit" title="Submit" />

</form>
</div>


<div id="error">
		<div id="error_1">		
			
		</div>
</div>
</html>

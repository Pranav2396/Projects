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
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<style>
.material-icons{vertical-align:-14%}
</style>
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
						<li><a href="#" onclick="document.getElementById('login').style.display='block'">Login</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- end #header -->
		<div id="page" style="margin-top:120px">
			<div id="content">
				<div class="post w3-content w3-light-grey w3-padding">
					<h2 class="title"><a href="#">Locations</a></h2>
					<form name="addentry" method="post" action="findaddress.php">
					<div class="entry">
						<p>
                          <label>Enter your address</label>
                          <input class="w3-input" name="uaddress" type="text">
                        </p>
				        
						<p>
							<input class="send_btn" type="submit" value="Submit" alt="Submit" title="Submit" />
						</p>					
					</div>
					</form>
				</div>

			</div>
			<!-- end #content -->

			<div id="sidebar" class="w3-card-4 ">
				<ul>
					<li>
						<h2 > Help Details</h2>
						<ul>

							<li><p style="color:red">Fire Brigade<p>
								<p class="w3-large">
									<i class="material-icons w3-large" style="margin-right:5px">phone</i>Number</p></li>

							<li><p style="color:red">Govt. zones</p>
								<p class="w3-large">	<i class="material-icons w3-large" style="margin-right:5px">phone</i>
								Number
							</p></li>

						</ul>
					</li>
				</ul>
			</div>
			<!-- end #sidebar -->
			<div style="clear: both;">&nbsp;</div>
		</div>
		<!-- end #page -->


	<!-- login -->
	<div id="login" class="w3-modal">
			<div class="w3-card-4 w3-light-grey w3-margin" style="width:80%;max-width:350px; float:right;">
				<header class="w3-container w3-light-grey">
					<span onclick="document.getElementById('login').style.display='none'" class="w3-closebtn">×</span>
					<h3 style="margin-bottom:20px">Admin Login</h3>
				</header>
				<div class="w3-container w3-center">
					<p>
						<input class="w3-input w3-border" type="text" placeholder="Email"></p>
						<p>
							<input class="w3-input w3-border" type="text" placeholder="Password">
						</p>
							<button class="w3-btn w3-btn-block w3-green">Login</button>
						<a href="#" class="w3-left w3-section w3-text-green">Forgot password?</a>
					</p>
				</div>
			</div>
		</div>
		<!-- end login -->

	<div id="footer" style="bottom:0">
		<p>&copy; Untitled. All rights reserved. Images by <a href="http://fotogrph.com/">Fotogrph</a>. Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</p>
	</div>
	<!-- end #footer -->

</body>
</html>

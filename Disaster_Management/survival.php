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
		.material-icons {
			vertical-align: -14%
		}
		.w3-leftbar{
			font-size: 1.1em;
			margin-bottom: 10px;
		}
		li{
			padding-top: 7px;
		}
	</style>
</head>

<body>
	<div id="wrapper">
		<div id="header-wrapper" style="height:70px">
			<div id="header" class="container" style="z-index:100">
				<div id="logo">
					<h1 style="line-height:50px"><a href="#">FLOOD RELIEF</a></h1>
				</div>
				<div id="menu">
					<ul style="padding-top:20px">
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

		<!-- login -->
		<div id="login" class="w3-modal">
			<div class="w3-card-4 w3-light-grey w3-margin" style="width:80%;max-width:350px; float:right;">
				<header class="w3-container w3-light-grey">
					<span onclick="document.getElementById('login').style.display='none'" class="w3-closebtn">×</span>
					<h3 style="margin-bottom:20px">Admin Login</h3>
				</header>
				<form action="logincheck.php" method="post">
				<div class="w3-container w3-center">
					<p>
						<input class="w3-input w3-border" type="text" name="email" placeholder="Email">
					</p>
					<p>
						<input class="w3-input w3-border" type="password" name="password" placeholder="Password">
					</p>
					<button class="w3-btn w3-btn-block w3-green">Login</button>
					<a href="#" class="w3-left w3-section w3-text-green">Forgot password?</a>
					
					<div id="error">
					 <?php
					   if(!empty($_SESSION['messsage'])) 
					   {$message = $_SESSION['message']; echo $message;}
					 ?>
					</div>
					</p>
				</div>
				</form>
			</div>
		</div>
		<!-- end login -->


		<nav class="w3-sidenav w3-light-grey w3-card-2" style="width:20%; padding-top:40px; position:fixed; top:70px">
			<a class="w3-padding-24 w3-large" href="#survival">Survival Guildelines</a>
			<a class="w3-padding-24 w3-large" href="#does_donts">Dos and Dont's</a>
			<a class="w3-padding-24 w3-large" href="#faqs">FAQs</a>

		</nav>

		<div id="survival" class="w3-card-2 w3-padding w3-light-grey" style=" margin:24px; margin-left:22%; margin-top:80px;">
			<div class="w3-container">
				<h1>
			Survival Guidelines
		</h1>
				<hr />
				<div class="w3-container">
					<h2>1. Being Prepared</h2>
					<div class="w3-padding">
						<img src="sf1.jpg" alt="flood" width="100%" style="max-height:400px" />

						<div class="w3-card-2 w3-leftbar  w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<p>
								<b>1. Be aware of your area's flood risk before the expected rain is going to hit.</b>
								<br /> This information can usually be found online on your local news or weather station's website, or they may show it on TV
							</p>
							<br />
							<p>
								<b>2. Check to see if you have insurance that covers flooding. If not, find out how to get flood insurance.</b>
								<br />Any damage that is done by water, no matter where you live, is covered by flood insurance, so it is good to have it to be on the safe side.
							</p>
							<br />
							<p>
								<b>3. Keep insurance policies, documents, and other valuables in a safe-deposit box, that is located up high and out of harm's way.</b>
							</p>
							<br />
							<p>
								<b>4. Assemble a Disaster Supplies Kit</b>
							</p>
							<ul>
								<li>
									First aid kit and essential medications.
								</li>
								<li>
									Canned food and can opener
								</li>
								<li>
									At least three gallons of water per person
								</li>
								<li>
									Protective clothing, rainwear, and bedding or sleeping bags
								</li>
								<li>
									Battery-powered radio, flashlight, and extra batteries.
								</li>
								<li>
									Identification, such as a passport, driver's license, etc.
								</li>
								<li>
									Special items for infants, elderly, or disabled family members, such as diapers, toys, etc.
								</li>
								<li>
									Written instructions for how to turn off electricity, gas and water if authorities advise you to do so. (Remember, you'll need a professional to turn them back on.)
								</li>
							</ul>
							<br />
							<p>
								<b>5. Identify where you could go if told to evacuate</b>
								<br /> Choose several places in case one is unavailable, such as a friend's home in another town, a motel, or a shelter. Make sure that everyone in the family knows exactly where each place is located and how to get there.
							</p>
							<br />
							<p>
								<b>6. Reduce any potential flood damage</b>
							</p>
							<ul>
								<li>
									Raise your furnace, water heater and electric panel to a higher level if they are in areas of your home that could flood.
								</li>
								<li>
									Move valuables to higher points in your home.
								</li>
							</ul>
							<br />
							<p>
								<b>7. When a flood WARNING is issued, listen to local radio and TV stations for information and advice.</b>
								<br /> If told to evacuate, do so as soon as possible. Always listen to the instructions authorities give you.
							</p>
						</div>
					</div>

				</div>
				<div class="w3-container">
					<h2>2. During a Flood</h2>
					<div class="w3-padding">
						<!-- <img src="images/sf2.jpg" alt="flood" width="100%" /> -->

						<div class="w3-card-2 w3-leftbar w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<p>
								<b>1. Evacuate immediately</b>
								<br /> You may have only a short time to escape. Act quickly, utilizing your planning route.
							</p>
							<br />
							<p>
								<b>2. Move to higher ground away from rivers, streams, creeks, and storm drains.</b>
								<br /> Do not drive around barricades. They are there for your safety.
							</p>
							<br />
							<p>
								<b>3. If evacuating in your car, drive through as little water as possible, although sometimes this may be unavoidable, and take the shortest route possible to your meeting place</b>
								<br /> Make sure that you have your emergency kit with you.
							</p>
							<br />
							<p>
								<b>4. Know that you should never walk through moving water</b>
								<br /> The currents in even 6 inches (15 cm) of water can be dangerous. In still water, use a stick or another long object to test the area and make sure it is safe.
							</p>
							<p>
								<b>5. If your car stalls in rapidly rising waters, abandon it immediately and climb to higher ground.</b>
								<br /> You may have only a short time to escape. Act quickly, utilizing your planning route.
							</p>
							<br />
							<p>
								<b>6. Be aware that flash flooding can occur. If there is any possibility of a flash flood, move immediately to higher ground. Do not wait for instructions to move.</b>
								<br />
							</p>
							<br />
						</div>
					</div>
				</div>
				<div class="w3-container">
					<h2>3. After a Flood</h2>
					<div class="w3-padding">
						<!-- <img src="images/sf2.jpg" alt="flood" width="100%" /> -->

						<div class="w3-card-2 w3-leftbar w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<p>
								<b>The following are guidelines for the period following a flood:</b>
								<br />
							</p>
							<br />
							<ul>
								<li>
									Listen for news reports to learn whether the community’s water supply is safe to drink.
								</li>
								<li>
									Avoid floodwaters; water may be contaminated by oil, gasoline, or raw sewage. Water may also be electrically charged from underground or downed power lines.
								</li>
								<li>
									Avoid moving water.
								</li>
								<li>
									Be aware of areas where floodwaters have receded. Roads may have weakened and could collapse under the weight of a car.
								</li>
								<li>
									Stay away from downed power lines, and report them to the power company.
								</li>
								<li>
									Return home only when authorities indicate it is safe.
								</li>
								<li>
									Stay out of any building if it is surrounded by floodwaters.
								</li>
								<li>
									Use extreme caution when entering buildings; there may be hidden damage, particularly in foundations.
								</li>
								<li>
									Service damaged septic tanks, cesspools, pits, and leaching systems as soon as possible. Damaged sewage systems are serious health hazards.
								</li>
							</ul>
						</div>
					</div>
				</div>
				<div class="w3-container">
					<h2>4. Recovering from a Flood</h2>
					<div class="w3-padding">
						<!-- <img src="images/sf2.jpg" alt="flood" width="100%" /> -->

						<div class="w3-card-2 w3-leftbar w3-border-green w3-padding w3-border" style="margin-top:10px;">

							<ul>

								                    <LI>
								                      <FONT KERNING="1">Return home only when officials have declared the area safe.</FONT>
								                    </LI>
								                    <LI>
								                      <FONT KERNING="1">Before entering your home, look outside for loose power lines, damaged gas lines, foundation cracks or other damage.</FONT>
								                    </LI>
								                    <LI>
								                      <FONT KERNING="1">Parts of your home may be collapsed or damaged. Approach entrances carefully. See if porch roofs and overhangs have all their supports.</FONT>
								                    </LI>
								                    <LI>
								                      <FONT KERNING="1">Watch out for wild animals, especially poisonous snakes that may have come into your home with the floodwater.</FONT>
								                    </LI>
								                    <LI>
								                      <FONT KERNING="1">If you smell natural or propane gas or hear a hissing noise, leave immediately and call the fire department.</FONT>
								                    </LI>
								                    <LI>
								                      <FONT KERNING="1">If power lines are down outside your home, do not step in puddles or standing water.</FONT>
								                    </LI>
								                    <LI>
								                      <FONT KERNING="1">Keep children and pets away from hazardous sites and floodwater.</FONT>
								                    </LI>
								                    <LI>
								                      <FONT KERNING="1">Materials such as cleaning products, paint, batteries, contaminated fuel and damaged fuel containers are hazardous. Check with local authorities for assistance with disposal to avoid risk.</FONT>
								                    </LI>
								                    <LI>
								                      <FONT KERNING="1">During cleanup, wear protective clothing, including rubber gloves and rubber boots.</FONT>
								                    </LI>
								                    <LI>
								                      <FONT KERNING="1">Make sure your food and water are safe. Discard items that have come in contact with floodwater, including canned goods, water bottles, plastic utensils and baby bottle nipples. When in doubt, throw it out!</FONT>
								                    </LI>
								                    <LI>
								                      <FONT KERNING="1">Contact your local or state public health department to see if your water supply might be contaminated. You may need to boil or treat it before use. Do not use water that could be contaminated to wash dishes, brush teeth, prepare food, wash hands, make ice or make baby formula!</FONT>
								                    </LI>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<!-- <div id="footer" style="">
	<p>&copy; Untitled. All rights reserved. Images by <a href="http://fotogrph.com/">Fotogrph</a>. Design by <a href="http://templated.co" rel="nofollow">TEMPLATED</a>.</p>
</div> -->
			<!-- end #footer -->
		</div>

		<div id="does_donts" class="w3-card-2 w3-padding w3-light-grey" style=" margin:24px; margin-left:22%; margin-top:80px;">
			<div class="w3-container">
				<h1>
			Do's and Dont's
		</h1>
				<hr />
				<div class="w3-container">
					<h2>Do's</h2>
					<div class="w3-padding">

						<div class="w3-card-2 w3-leftbar  w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<ul>
								<li>Stay calm</li>
								<li>Check that neighbours know about any flood warnings that may have been issued. If you know that you live in a flood risk area, you may be able to subscribe to the free <strong><a href="https://fwd.environment-agency.gov.uk/app/olr/home">Environment Agency automated flood warning system</a></strong></li>
								<li>Switch off gas, water and electricity</li>
								<li>Move people and animals to a place of safety. Remember to provide a litter tray for pets and have pet carriers available if possible</li>
								<li>Unplug electrical items and store them upstairs if possible. For larger appliances such as fridges and freezers, it may me necessary to raise them on bricks</li>
								<li>If you can, move furniture, rugs, valuables and sentimental items upstairs</li>
								<li>Have a supply of drinking water in clean bottles or similar containers</li>
								<li>Fill the bath and buckets with water for washing etc.</li>
								<li>Listen to the local media for up-to-date news on the flood</li>
								<li>If you need to be evacuated because of severe flooding or damage contact the emergency services on 999</li>
								<li>If flooding traps you, stay by a window and try to attract attention</li>
								<li>Remember to <strong>lock up</strong> if you leave your property</li>
								<li>Avoid moving water</li>
							</ul>

						</div>
					</div>
				</div>
				<div class="w3-container">
					<h2>Dont's</h2>
					<div class="w3-padding">

						<div class="w3-card-2 w3-leftbar  w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<ul>
<li>Stay away from moving water and downed power lines or poles. Don&#8217;t try to walk through flood water and if you must, be very careful and use a stick to test the depth and feel for debris that can cause you to fall.</li>
<li>Avoid driving through flood water because it can be dangerous. Just one foot of fast flowing water can make your car float, not to mention the hidden dangers like fallen power lines or trees.</li>
<li>Avoid touching flood water, as it may be contaminated with chemical substances, sewage, etc.</li>
<li>Never swim through flood water for the same reasons. Also, you can easily drown in fast moving waters or you can be hit by a hidden object and knocked out, which can be fatal.</li>
<li>Do not return home until you know for a fact that it&#8217;s safe to do so.</li>
<li>Do not turn on your utilities until the installations are checked by a specialist. Gas leaks are common after a flood so using candles and smoking is not safe. Use flashlights instead.</li>
<li>Do not try to handle electrical equipment or appliances in humid areas or in standing water.</li>
<li>Avoid using your TV if it sits on a wet carpet or floor or on humid concrete floors. The basic rule is that water and electricity don&#8217;t mix!</li>
<li>Do not enter buildings that are surrounded by floodwaters.</li>
</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="faqs" class="w3-card-2 w3-padding w3-light-grey" style=" margin:24px; margin-left:22%; margin-top:80px;">
			<div class="w3-container">
				<h1>
		FAQs
		</h1>
				<hr />

				<div class="w3-container">
					<h2>How dangerous is flooding?</h2>
					<div class="w3-padding">

						<div class="w3-card-2 w3-leftbar  w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<p>
							Floods are a dangerous hazard throughout the world. On average in the United States, about 165 people are killed and about $2 billion of damage occurs each year. Most people underestimate the power and destructiveness of flood waters.
							</p>
						</div>
					</div>
				</div>
				<div class="w3-container">
					<h2>Where can I learn more about flood forecasting?</h2>
					<div class="w3-padding">

						<div class="w3-card-2 w3-leftbar  w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<p>
								Most currently available flood maps are used to assist planners in identifying and preparing for flooding scenarios. These maps portray statistics based on long-term historical records to estimate and forecast an approaching weather system. For more information on the techniques of flood statistics reports see: http://pubs.usgs.gov/twri/.
	The U.S. Geological Survey (USGS) and the National Weather Service (NWS) have developed a way to bring flood forecasting and flood mapping together, using available technologies, to produce maps which can be served on the Internet in time to allow communities to prepare for potential flooding. More information on this project can be obtained by downloading the USGS fact sheet at: http://pubs.water.usgs.gov/fs2004-3060/; or checking out the informational page at: http://wa.water.usgs.gov/projects/pugethazards/urbanhaz/MappingNWS.htm. For a demonstration of the system go to: http://wa.water.usgs.gov/cgi/flood_snoqualmie.cgi.
	WaterWatch, the USGS information on current water resources conditions, is found at: http://water.usgs.gov/waterwatch/.
	FEMA Flood Maps are available free at: http://msc.fema.gov. These maps are often used in regard to property damage and for local planners defining escape routes.
							</p>
						</div>
					</div>
				</div>
				<div class="w3-container">
					<h2>How are floods predicted?</h2>
					<div class="w3-padding">

						<div class="w3-card-2 w3-leftbar  w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<p>
								Several types of data can be collected to assist hydrologists predict when and where floods might occur:
								Monitoring the amount of rainfall occurring on a realtime basis
								Monitoring the rate of change in river stage on a realtime basis, which can help indicate the severity and immediacy of the threat
								Knowledge about the type of storm producing the moisture, such as duration, intensity and areal extent, which can be valuable for determining possible severity of the flooding
								Knowledge about the characteristics of a river's drainage basin, such as soil-moisture conditions, ground temperature, snowpack, topography, vegetation cover, and impermeable land area, which can help to predict how extensive and damaging a flood might become
								The National Weather Service collects and interprets rainfall data throughout the United States and issues flood watches and warnings as appropriate. The National Weather Service uses statistical models and flood histories to try to predict the results of expected storms. The USGS maintains a network of streamflow-gaging stations throughout the country for which the discharge and stage are monitored. Flood estimation maps are generally produced by estimating a flood with a certain recurrence interval or probability and simulating the inundation levels based on flood plain and channel characteristics.
							</p>
						</div>
					</div>
				</div>
				<div class="w3-container">
					<h2>Are there different types of flooding?</h2>
					<div class="w3-padding">

						<div class="w3-card-2 w3-leftbar  w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<p>
								There are two basic kinds of floods, flash floods and the more widespread river flooding. Flash floods generally cause greater loss of life and river floods generally cause greater loss of property.
								A flash flood occurs when runoff from excessive rainfall causes a rapid rise in the stage of a stream or normally dry channel. Flash floods are more common in areas with a dry climate and rocky terrain because lack of soil or vegetation allows torrential rains to flow overland rather than infiltrate into the ground.
								River flooding is generally more common for larger rivers in areas with a wetter climate, when excessive runoff from longer-lasting rainstorms and sometimes from melting snow causes a slower water-level rise, but over a larger area. Floods also can be caused by ice jams on a river, or high tides. However, most floods can be linked to a storm of some kind.
							</p>
						</div>
					</div>
				</div>
				<!-- <div class="w3-container">
					<h2>What causes drought?</h2>
					<div class="w3-padding">

						<div class="w3-card-2 w3-leftbar  w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<p>

							</p>
						</div>
					</div> -->
				<!-- </div> -->
				<div class="w3-container">
					<h2>How can I find flood maps?</h2>
					<div class="w3-padding">

						<div class="w3-card-2 w3-leftbar  w3-border-green w3-padding w3-border" style="margin-top:10px;">
							<p>
								Several kinds of flood maps are available from USGS and other sources.
								Online USGS map showing real-time flood conditions
								USGS Web site to track flooding in your area
								Online USGS current and past flood maps
								National Oceanic and Atmospheric Administration online River Flooding Forecast map
								Federal Emergency Management Agency "How to find your flood map" Web page
								Federal Emergency Management Agency Map Service Center Web site
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>



</body>



</html>

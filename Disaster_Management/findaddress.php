<html>
<?php

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

$i=0;
$sql="select * from departments";
$ret=mysql_query($sql,$res);

$arrayadd=array();
$distance=array();

$addressFrom=$_POST['uaddress'];

while($row_sections=mysql_fetch_array($ret))
{
  $arrayadd[]= $row_sections['Address'];
  $distance[] = getDistance($addressFrom, $arrayadd[$i], "K");
  $i++;
}

bubble_sort($distance,$arrayadd);

$size=count($arrayadd);
?>

<table>
 <tr>
   <th>Address</th>
   <th>Distance</th>
 </tr>

<?php
for($i=0;$i<$size;$i++)
{
  echo '<tr>';
  echo '<td>'.$arrayadd[$i].'</td>';
  echo '<td>'.$distance[$i].'</td>';
  echo '</tr>';
}
?>

<?php
function bubble_sort(&$arr,&$address) {
    $size = count($arr);
    for ($i=0; $i<$size; $i++) {
        for ($j=0; $j<$size-1-$i; $j++) {
            if ($arr[$j+1] < $arr[$j]) {
                swap($arr,$address, $j, $j+1);
            }
        }
    }
}


function swap(&$arr,&$address, $a, $b) {
    $tmp = $arr[$a];
    $arr[$a] = $arr[$b];
    $arr[$b] = $tmp;

    $tmp1=$address[$a];
    $address[$a]=$address[$b];
    $address[$b]=$tmp1;
}

function getDistance($addressFrom, $addressTo, $unit){

    $formattedAddrFrom = str_replace(" ","+",$addressFrom);
    $formattedAddrTo = str_replace(" ","+",$addressTo);
    
    
    $geocodeFrom = file_get_contents("http://maps.google.com/maps/api/geocode/json?address=".$formattedAddrFrom."&sensor=false");
    $outputFrom = json_decode($geocodeFrom);
    $geocodeTo = file_get_contents("http://maps.google.com/maps/api/geocode/json?address=".$formattedAddrTo."&sensor=false");
    $outputTo = json_decode($geocodeTo);
    
   
    $latitudeFrom = $outputFrom->results[0]->geometry->location->lat;
    $longitudeFrom = $outputFrom->results[0]->geometry->location->lng;
    $latitudeTo = $outputTo->results[0]->geometry->location->lat;
    $longitudeTo = $outputTo->results[0]->geometry->location->lng;
    
    $theta = $longitudeFrom - $longitudeTo;
    $dist = sin(deg2rad($latitudeFrom)) * sin(deg2rad($latitudeTo)) +  cos(deg2rad($latitudeFrom)) * cos(deg2rad($latitudeTo)) * cos(deg2rad($theta));
    $dist = acos($dist);
    $dist = rad2deg($dist);
    $miles = $dist * 60 * 1.1515;
    $unit = strtoupper($unit);
    if ($unit == "K") {
        return ($miles * 1.609344)." km";
    } else if ($unit == "N") {
        return ($miles * 0.8684)." nm";
    } else {
        return $miles." mi";
    }
}

?>
</html>
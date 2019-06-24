function validate()
{
	var fname=document.feedback.fname.value;
	var lname=document.feedback.lname.value;
	var email=document.feedback.email.value;
	var Phoneno=document.feedback.Phoneno.value;
        var address=document.feedback.address.value;
        var mc=document.feedback.Moneycheck.checked ;
        var fc=document.feedback.Foodcheck.checked;
        var age=document.feedback.age.value;

	if(validatefname(fname) && validatelname(lname) && validateemail(email) && validatePhone(Phoneno) && validateaddress(address)
           && checklength(Phoneno) && validateage(age))
	{

          if(mc || fc)
           return true;
          else
	    {
		document.getElementById('error_1').innerHTML="Please fill the checkboxes";
		return false;
	   }
	}

	return false;
}

function validateage(age_)
{
  if(age_ && age_>=15 && age_<=100)
    return true;
    else
	{
		document.getElementById('error_1').innerHTML="Please enter your age correctly";
		return false;
	}

}

function checklength(no_)
{
 if(no_.length <=10)
   return true;
  else
	{
		document.getElementById('error_1').innerHTML="Length of phone no greater than 10";
		return false;
	}
}

function validatePhone(no_)
{
  var no=/\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/;
  
 if(no_.match(no))
   return true;
 else
	{
		document.getElementById('error_1').innerHTML="Enter the PhoneNo";
		return false;
	}
}

function validateaddress(add_)
{
  if(add_)
    {return true;}
  else
     {
       document.getElementById('error_1').innerHTML="Enter the Address";
       return false;
	}
}

function validateemail(email_)
{
	var email=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/	; 

	if(email_.match(email))
	{
		return true;
	}
	else
	{
		document.getElementById('error_1').innerHTML="Enter the Mail Id";
		return false;
	}
}


function validatefname(name_)
{
	var name=/^[a-zA-Z]+$/;
	if(name_.match(name))
	{
		return true;
	}

	else
	{
		document.getElementById('error_1').innerHTML="Enter the fname";
		return false;
	}

}

function validatelname(name_)
{
	var name=/^[a-zA-Z]+$/;
	if(name_.match(name))
	{
		return true;
	}

	else
	{
		document.getElementById('error_1').innerHTML="Enter the lname";
		return false;
	}

}

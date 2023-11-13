/*
    Name validation:
    Name must not contains any number.
*/
function nameValidation(name){
    var letters = /^[A-Za-z]+$/;
    if(!letters.test(name)){
        return true;
    }
    return false;
}

function mobileValidation()
{
	var mobile = document.getElementById("mobile").value;
	if (/^\d{10}$/.test(mobile)) {
    // value is ok, use it
	} else {
    alert("Invalid number; must be ten digits")
	document.getElementById("mobile").value="";
    return false;
	}
}

function fullNameValidation(){
    var name = document.getElementById("name").value;
    var fullNameArray = name.split(" ");

    if(fullNameArray.length == 2){
        if(firstNameValidate(fullNameArray[0]) || lastNameValidate(fullNameArray[2])){
            alert("Name does not contains numbers.");
            document.getElementById("name").value = "";
        }
        
    } else if(fullNameArray.length == 3){
        if(firstNameValidate(fullNameArray[0]) && middleNameValidate(fullNameArray[1]) && lastNameValidate(fullNameArray[2])){
            alert("Name does not contains numbers.");
            document.getElementById("name").value = "";
        }
    } else {
        alert(" Invalid name.");
        document.getElementById("name").value = "";
    }
}

function firstNameValidate(firstName){
    if(nameValidation(firstName)){
        return true;
    } else {
        return false;
    }
}

function middleNameValidate(middleName){
    if(nameValidation(middleName)){
        return true;
    } else {
        return false;
    }
}

function lastNameValidate(lastName){
    if(nameValidation(lastName)){
        return true;
    } else {
        return false;
    }
}

function emailValidation(){
    var email = document.getElementById("emailid").value;
    var atpos = email.indexOf("@");
    var dotpos = email.lastIndexOf(".");
    if (atpos < 1 || dotpos < atpos+2 || dotpos+2 >= email.length) {
        alert("Not a valid e-mail address");
        document.getElementById("emailid").value = "";
        return false;
    }
}

function passwordValidation(){
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;
    var errorMsg = "";
    
    if(!(password == confirmPassword)){
        alert(" Password and confirm passwords are not same.");
        document.getElementById("password").value = "";
        document.getElementById("confirmPassword").value = "";
    }
}

function pincodeValidation(){
	var pat1=/^\d{6}$/;
	var pincode = document.getElementById("pincode").value; 
	if(!pat1.test(pincode)){
		alert("Pin code should be 6 digits ");
		return false;
		}
}

function clearInputs(){
    document.getElementById("name").value = "";
    document.getElementById("emailid").value = "";
	document.getElementById("mobile").value = "";
    document.getElementById("password").value = "";
    document.getElementById("confirmPassword").value = "";
}
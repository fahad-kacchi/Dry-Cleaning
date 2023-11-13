function nameValidation(name){
    var letters = /^[A-Za-z]+$/;
    if(!letters.test(name)){
        return true;
    }
    return false;
}

function fullNameValidation(){
    var name = document.getElementById("fullName").value;
    var fullNameArray = name.split(" ");

    if(fullNameArray.length == 2){
        if(firstNameValidate(fullNameArray[0]) || lastNameValidate(fullNameArray[2])){
            alert("Name does not contains numbers.");
            document.getElementById("fullName").value = "";
        }
        
    } else if(fullNameArray.length == 3){
        if(firstNameValidate(fullNameArray[0]) && middleNameValidate(fullNameArray[1]) && lastNameValidate(fullNameArray[2])){
            alert("Name does not contains numbers.");
            document.getElementById("FullName").value = "";
        }
    } else {
        alert(" Invalid name.");
        document.getElementById("fullName").value = "";
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

function addressValidation(){
    var address = document.getElementById("address").value;
    if(address.length < 20){
        alert(" Addresss must contains 20 characters");
        document.getElementById("address").value = "";
    }
}

// function numberValidation(name){
    // var letters = /^[0-9]+$/;
    // if(!letters.test(name)){
        // return true;
    // }
    // return false;
// }
// function pincodeValidation(){
	// var pincode = document.getElementById("pincode").value;
    // if(pincode.length != 6){
		// if(numberValidation(pincode)){
			// alert(" Pincode must contains 6 digits");
			// document.getElementById("pincode").value = "";
		// }
    // }
// }

function CheckIndianZipCode(pincode)
{
       var CheckCode = /(^\d{6}$)/;
       if(CheckCode.test(pincode))
       {
             return true;
       }
       else
       {
             alert("Your Entered Zip Code Is Not Valid.");
       }
}

function checkPickupTime(pickup)
{
	
	if(pickup && pickup!="Pickup Time")
		{
			return true;
		}
	else
		{
			alert("select pickup time");
			return false;
		}
}			
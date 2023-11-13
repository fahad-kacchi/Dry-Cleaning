function nameValidation(name){
    var letters = /^[A-Za-z]+$/;
    if(!letters.test(name)){
        return true;
    }
    return false;
}

function firstNameValidate(firstName){
    if(nameValidation(firstName)){
        return true;
    }
    return false;
}

function middleNameValidate(middleName){
    if(nameValidation(middleName)){
        return true;
    }
    return false;
}

function lastNameValidate(lastName){
    if(nameValidation(lastName)){
        return true;
    }
    return false;
}

function validateName(){
    var name = document.getElementById("name").value;
    var nameArray = name.split(" ");
    var arrayLength = nameArray.length;
    
    if(arrayLength == 2){
        if(firstNameValidate(nameArray[0]) || middleNameValidate(nameArray[1])){
            alert(" Name does not contains the numbers or special symbols.");
            document.getElementById("name").value = "";
        }
    } else if(arrayLength == 3){
        if(firstNameValidate(nameArray[0]) || middleNameValidate(nameArray[1]) || lastNameValidate(nameArray[2])){
            alert(" Name does not contains the numbers or special symbols.");
            document.getElementById("name").value = "";
        }
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

function emailValidation(){
    var email = document.getElementById("email").value;
    var atpos = email.indexOf("@");
    var dotpos = email.lastIndexOf(".");
    if (atpos < 1 || dotpos < atpos+2 || dotpos+2 >= email.length) {
        alert("Not a valid e-mail address");
        document.getElementById("email").value = "";
        return false;
    }
}

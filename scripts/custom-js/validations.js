function nameValidation(){
    var name = document.getElementById("name").value;
    var namePartition = name.split(" ");
    var partition = namePartition.length;
    
    if(partition == 2){
    } else if(partition == 3){
    } else {
        alert(" Please provide a valid name.");
        document.getElementById("name").value = "";
    }
    
}

function addressValidation(){
    var address = document.getElementById("address").value;
    if(address.length < 20){
        alert(" Addresss must contains 20 characters");
        document.getElementById("address").value = "";
    }
}

function validateName(name){
    var letters = /^[A-Za-z]+$/;
    if(!letters.test(name)){
        return true;
    }
    return false;
}


function cityValidation(){
    var city = document.getElementById("city").value;
    if(validateName(city)){
        alert("City does not contains numbers.");
        document.getElementById("city").value = "";
    }
}

function contactNoValidation(){
    var contactNo = document.getElementById("contact_no").value;
    var errMsg = "";
    var lengthOfContactNo = contactNo.length;
    
    if(lengthOfContactNo != 10){
        errMsg = "Contact no must be of 10 digits.";
    } else if(contactNo < 0){
        errMsg = "Please enter the valid contact no.";
    }
    
    if(errMsg != ""){
        alert(errMsg);
        document.getElementById("contact_no").value = "";
    }
}

/*
function quantityValidation(id){
    var smallSizeQuantity = document.getElementById(id).value;
    var errMsg = "";
    
    if(parseInt(smallSizeQuantity) < 0){
        errMsg = "Please enter valid number of quantity.";
    }
    
    if(errMsg != ""){
        alert(errMsg);
        document.getElementById(id).value = "";
    }    
}

function checkBoxChecked(checkBoxId, divId){
    var small = document.getElementById(checkBoxId);
    if(small.checked){
        document.getElementById(divId).style.display = "block";
    } else {
        document.getElementById(divId).style.display = "none";
    }
}*/
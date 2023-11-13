function isAlphanumericChars(name){
    var letters = /^[A-Za-z]+$/;
    if(letters.test(name)){
        return true;
    }
    return false;
}

function cardNumberValidation(){
    var cardNo = document.getElementById("cardNumber").value;
    if(isAlphanumericChars(cardNo)){
        alert(" Card Number does not contains alphanumeric characters.");
        document.getElementById("cardNumber").value = "";
    } else if(cardNo.length < 16 || cardNo.length > 16){
        alert(" Card no must be 16 digit");
        document.getElementById("cardNumber").value = "";
    }
}

function checkExpiryMonth(){
    var month = document.getElementById("expiryMonth").value;
    if(isAlphanumericChars(month)){
        alert(" Month does not contains alphanumeric characters.");
        document.getElementById("expiryMonth").value = "";
    } else if(month.length < 2 || month.length > 2){
        alert(" Invalid Month.");
        document.getElementById("expiryMonth").value = "";
    } else if(parseInt(month) < 0){
        alert(" Invalid Month");
        document.getElementById("expiryMonth").value = "";
    }
}

function checkExpiryYear(){
    var year = document.getElementById("expiryYear").value;
    if(isAlphanumericChars(year)){
        alert(" Year does not contains alphanumeric characters.");
        document.getElementById("expiryYear").value = "";
    } else if(year.length < 2 || year.length > 2){
        alert(" Invalid Year.");
        document.getElementById("expiryYear").value = "";
    } else if(parseInt(year) < 0){
        alert(" Invalid Year");
        document.getElementById("expiryYear").value = "";
    }
}

function checkCVVNo(){
    var cvvCode = document.getElementById("cvCode").value;
    if(isAlphanumericChars(cvvCode)){
        alert(" Card Number does not contains alphanumeric characters.");
        document.getElementById("cvCode").value = "";
    } else if(cvvCode.length < 3 || cvvCode.length > 3){
        alert(" Invalid CVV No.");
        document.getElementById("cvCode").value = "";
    } else if(parseInt(cvvCode) < 0){
        alert(" Invalid CVV No");
        document.getElementById("cvCode").value = "";
    }
}

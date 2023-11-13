function showSmallPizzaPriceInput(smallSizeCheckbox){
    var isChecked = smallSizeCheckbox.checked 
        ? document.getElementById("small-price").disabled = false
        : document.getElementById("small-price").disabled = true;
}

function showMediumPizzaPriceInput(mediumSizeCheckbox){
    var isChecked = mediumSizeCheckbox.checked 
        ? document.getElementById("medium-price").disabled = false
        : document.getElementById("medium-price").disabled = true;
}

function showLargePizzaPriceInput(largeSizeCheckbox){
    var isChecked = largeSizeCheckbox.checked 
        ? document.getElementById("large-price").disabled = false
        : document.getElementById("large-price").disabled = true;
}

function clearFields(){
    document.getElementById("pizza-name").value = "";
    document.getElementById('veg').checked = false;
    document.getElementById('non-veg').checked = false;

    document.getElementById("small-checkbox").checked = false;
    document.getElementById("medium-checkbox").checked = false;
    document.getElementById("large-checkbox").checked = false;

    document.getElementById("small-price").value = "";
    document.getElementById("medium-price").value = "";
    document.getElementById("large-price").value= "";

    document.getElementById("small-price").disabled = true;
    document.getElementById("medium-price").disabled = true;
    document.getElementById("large-price").disabled = true;
}

function logout(){
    window.location.href = "/online-pizza-shopping/index.html";
}
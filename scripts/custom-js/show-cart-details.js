function showCartDetails(){
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/online-pizza-shopping/jsp-pages/display-cart-details.jsp",false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    document.getElementById("show-cart-div").innerHTML = ""+output;        
}
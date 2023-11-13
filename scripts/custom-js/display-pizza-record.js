function displayPizzaRecord(){
    xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET","/online-pizza-shopping/jsp-pages/display-pizza-record.jsp",false);
    xmlhttp.send();
    output = xmlhttp.responseText;
    document.getElementById("display-pizza-table").innerHTML = ""+output;    
}
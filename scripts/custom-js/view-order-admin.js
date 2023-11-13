function viewOrderAdmin(storeId, customerId){
	xmlhttp = new XMLHttpRequest();
	xmlhttp.open("GET","/Dry-Cleaning/jsp-pages/view-order-admin.jsp?storeId="+storeId+"&customerId="+customerId,false);
	xmlhttp.send();
	output = xmlhttp.responseText;
	if(output.trim() == "NULL"){
		document.getElementById("fullName").value = "0";
		document.getElementById("address").value = "0";
		document.getElementById("pincode").value = "0";
		document.getElementById("sareeWashingQty").value = "0";
		document.getElementById("sareeIroningQty").value = "0";
		document.getElementById("jeansWashingQty").value = "0";
		document.getElementById("jeansIroningQty").value = "0";
		document.getElementById("suitWashingQty").value = "0";
		document.getElementById("suitIroningQty").value = "0";
		document.getElementById("topWashingQty").value = "0";
		document.getElementById("topIroningQty").value = "0";
	} else {
		var split = output.trim().split("$");
		
		document.getElementById("fullName").value = split[1];
		document.getElementById("address").value = split[2];
		document.getElementById("pincode").value = split[3];
		document.getElementById("sareeWashingQty").value = split[6];
		document.getElementById("sareeIroningQty").value = split[7];
		document.getElementById("jeansWashingQty").value = split[8];
		document.getElementById("jeansIroningQty").value = split[9];
		document.getElementById("suitWashingQty").value = split[10];
		document.getElementById("suitIroningQty").value = split[11];
		document.getElementById("topWashingQty").value = split[12];
		document.getElementById("topIroningQty").value = split[13];
	}	
}
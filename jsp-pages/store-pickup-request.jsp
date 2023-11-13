<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String customerId = request.getParameter("customerID");
	String storeId = request.getParameter("storeID");
	String fullName = request.getParameter("fullName");
	String pincode = request.getParameter("pincode");
	String address = request.getParameter("address");
	int intPickupTime = Integer.parseInt(request.getParameter("pickupTime").split("-")[0]);
	String pickupTime = LocalTime.of(intPickupTime, 0, 0).toString();
	String pickupDate = request.getParameter("date");
	double sareeWashingQty = Double.parseDouble(request.getParameter("sareeWashingQty"));
	double sareeIroningQty = Double.parseDouble(request.getParameter("sareeIroningQty"));
	double suitWashingQty =  Double.parseDouble(request.getParameter("suitWashingQty"));
	double suitIroningQty =  Double.parseDouble(request.getParameter("suitIroningQty"));
	double jeansWashingQty = Double.parseDouble(request.getParameter("jeansWashingQty"));
	double jeansIroningQty = Double.parseDouble(request.getParameter("jeansIroningQty"));
	double topWashingQty =   Double.parseDouble(request.getParameter("topWashingQty"));
	double topIroningQty =   Double.parseDouble(request.getParameter("topIroningQty"));
	int completedStatus = 0;
	try{
		List<KeyValue> data = new ArrayList<KeyValue>();
        String pickupId = generatePrimaryKey("P", "pickup_request", "pickup_id", out);
        data.add(new KeyValue(DTConstants.STRING, fullName));
        data.add(new KeyValue(DTConstants.STRING, pincode));
        data.add(new KeyValue(DTConstants.STRING, pickupTime));
        data.add(new KeyValue(DTConstants.STRING, pickupDate));
		data.add(new KeyValue(DTConstants.STRING, address));
		
		data.add(new KeyValue(DTConstants.INTEGER, sareeWashingQty));
		data.add(new KeyValue(DTConstants.INTEGER, sareeIroningQty));
		data.add(new KeyValue(DTConstants.INTEGER, jeansWashingQty));
		data.add(new KeyValue(DTConstants.INTEGER, jeansIroningQty));
		
		data.add(new KeyValue(DTConstants.INTEGER, suitWashingQty));
		data.add(new KeyValue(DTConstants.INTEGER, suitIroningQty));
		data.add(new KeyValue(DTConstants.INTEGER, topWashingQty));
		data.add(new KeyValue(DTConstants.INTEGER, topIroningQty));
		
		data.add(new KeyValue(DTConstants.INTEGER, completedStatus));
		data.add(new KeyValue(DTConstants.STRING, customerId));
		data.add(new KeyValue(DTConstants.STRING, storeId));
		
        boolean flag = insertData(data, pickupId, "pickup_request", out);
        if(flag){
            out.println(" Data successfully inserted.!");
            response.sendRedirect("../view-orders.html?customerId="+customerId);
        } else {
            out.println(" Error 404.!");
        }
	} catch(Exception e){
		out.println(" Customer login exception: " +e);
	}
%>
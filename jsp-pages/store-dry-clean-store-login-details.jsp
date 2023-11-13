<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
try{
        String storeName = request.getParameter("store_name");
	String email = request.getParameter("emailid");
	String password = request.getParameter("password");
    String storeAddress = request.getParameter("store_address");
	String mobile = request.getParameter("mobile");
	String pincode = request.getParameter("pincode");
    int approveFlag = 0;
    
    

	if(isNull(storeName) || isNull(email) || isNull(password) || isNull(storeAddress) || isNull(mobile) || isNull(pincode)){
		out.println(" Please fill all the details.");
		return;
	}
	
	
		List<KeyValue> data = new ArrayList<KeyValue>();
        String storeId = generatePrimaryKey("S", "store_login", "store_id", out);
       
        out.println("\n StoreId : "+storeId);
        out.println("\n StoreName : "+storeName);
        out.println("\n StoreEmail : "+email);
        data.add(new KeyValue(DTConstants.STRING, storeName));
        data.add(new KeyValue(DTConstants.STRING, email));
        data.add(new KeyValue(DTConstants.STRING, password));
        data.add(new KeyValue(DTConstants.STRING, storeAddress));
		data.add(new KeyValue(DTConstants.STRING, mobile));
		data.add(new KeyValue(DTConstants.STRING, pincode));
        data.add(new KeyValue(DTConstants.INTEGER, approveFlag));
        boolean flag = insertData(data, storeId, "store_login", out);
        if(flag){
            out.println(" Data successfully inserted.!");
            response.sendRedirect("../store-login-page.html");
        } else {
            out.println(" Error :   Error 404.!");
        }
	} catch(Exception e){
		out.println(" \n Store login exception: " +e);
	}
%>

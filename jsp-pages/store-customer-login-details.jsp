<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String fullName = request.getParameter("name");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
    String phoneNo = request.getParameter("phoneNo");
    
	if(isNull(fullName) || isNull(email) || isNull(password) || isNull(phoneNo)){
		out.println(" Please fill all the details.");
		return;
	}
	
	try{
		List<KeyValue> data = new ArrayList<KeyValue>();
        String customerId = generatePrimaryKey("C", "customer_login", "customer_id", out);
        data.add(new KeyValue(DTConstants.STRING, fullName));
        data.add(new KeyValue(DTConstants.STRING, email));
        data.add(new KeyValue(DTConstants.STRING, password));
        data.add(new KeyValue(DTConstants.STRING, phoneNo));
        boolean flag = insertData(data, customerId, "customer_login", out);
        if(flag){
            out.println(" Data successfully inserted.!");
            response.sendRedirect("../customer-login-page.html");
        } else {
            out.println(" Error 404.!");
        }
	} catch(Exception e){
		out.println(" Customer login exception: " +e);
	}
%>
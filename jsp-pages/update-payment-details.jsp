<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String customerId = request.getParameter("customerId");
	try{
		String paymentId = getPaymentId(customerId, out);
		if(paymentId == null){
			out.println("<center> <font size=5 color=red>Payment unsuccessful! </font> </center>");
		} else {
			boolean flag = updatePaymentStatus(paymentId, out);
			if(flag){
				out.println("<center> <font size=5 color=green>Payment successful! </font> </center>");
				response.sendRedirect("../remaining-payment.html?customerId="+customerId);
			} else {
				out.println("<center> <font size=5 color=red>Payment unsuccessful! </font> </center>");
			}
		}
	} catch(Exception e){
		out.println(" Update payment details exception: " +e);
	}
%>


<%!
	public static boolean updatePaymentStatus(String paymentId, JspWriter out) throws Exception{
		boolean flag = false;
		try{
            con = fetchConnection();
            stmt = con.createStatement();
			String currentDate = LocalDate.now().toString();
			String currentTime = LocalTime.now().toString();
            String query = "update payment set payment_date = '"+currentDate+"', payment_time = '"+currentTime+"', payment_status = 1 where payment_id = '"+paymentId+"'";
            stmt.executeUpdate(query);
			flag = true;
		} catch(Exception e){
			out.println(" Update payment status exception: " +e);
		} finally {
			closeConnection();
		}
		return flag;
	}
%>

<%!
	public static String getPaymentId(String customerId, JspWriter out) throws Exception{
		String paymentId = "";
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select payment_id from payment, pickup_request where payment.pickup_id = pickup_request.pickup_id"+
						   " and customer_id = '"+customerId+"' and payment_status = 0";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				paymentId = null;
			} else {
				paymentId = rs.getString("payment_id");
			}
		} catch(Exception e){
			out.println(" Get payment id exception: " +e);
		} finally {
			closeConnection();
		}
		return paymentId;
	}
%>
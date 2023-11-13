<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String customerId = request.getParameter("customerId");
	try{
		List<List<String>> records = getPaymentRecords(customerId, out);
		if(records == null){
			out.println(" Records not found!");
		} else {
			String printPaymentList = "";
			int i = 1;
			for(List<String> list: records){
				printPaymentList += ""+
							"<tr>"+
								"<th scope=\"row\">"+i+"</th>"+
								"<td>"+list.get(0)+"</td>"+
								"<td>"+list.get(1)+"</td>"+
								"<td>"+list.get(2)+"</td>"+
								"<td>"+list.get(3)+"</td>"+
								"<td>"+list.get(4)+"</td>"+
							"</tr>";
				++i;
			}
			out.println(printPaymentList);
		}
	} catch(Exception e){
		out.println(" Show payment records exception: " +e);
	}
%>

<%!
	public static List<List<String>> getPaymentRecords(String customerId, JspWriter out) throws Exception {
		List<List<String>> paymentRecords = new ArrayList<List<String>>();
		try{
			con = fetchConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String query = "select store_name, payment_amount, payment_date, payment_time, payment_status"+
						   " from pickup_request, payment, store_login"+
						   " where pickup_request.pickup_id = payment.pickup_id and"+
						   " store_login.store_id = pickup_request.store_id and"+
						   " payment_status = 1 and"+
						   " customer_id = '"+customerId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				paymentRecords = null;
			} else {
				rs.previous();
				while(rs.next()){
					List<String> record = new ArrayList<String>();
					record.add(rs.getString("store_name"));
					record.add(rs.getString("payment_amount"));
					record.add(rs.getString("payment_date"));
					record.add(rs.getString("payment_time"));
					int intPaymentStatus = rs.getInt("payment_status");
					String paymentStatus = (intPaymentStatus == 0) ? "UNPAID" : "PAID";
					record.add(paymentStatus);
					paymentRecords.add(record);
				}
			}
		} catch(Exception e){
			out.println(" Get payment records: " +e);
		} finally {
			closeConnection();
		}
		return paymentRecords;
	}
%>
<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String storeId = request.getParameter("storeId");
	try{
		List<List<String>> records = fetchPickupRequestRecord(storeId, out);
		if(records == null){
			out.println(" Records not found!");
		} else {
			String printRecordString = "";
			int i = 1;
			for(List<String> list : records){
				printRecordString = ""+
					"<tr>"+
						"<td>"+i+"</td>"+
						"<td>"+list.get(0)+"</td>"+
						"<td>"+list.get(1)+"</td>"+
						"<td>"+list.get(2)+"</td>"+
						"<td>"+list.get(3)+"</td>"+
					"</tr>";
				i++;
			}
			out.println(printRecordString);
		}
	} catch(Exception e){
		out.println(" Show completed requests exception: " +e);
	}
%>

<%!
	public static List<List<String>> fetchPickupRequestRecord(String storeId, JspWriter out) throws Exception{
		List<List<String>> recordList = new ArrayList<List<String>>();
		try{
			con = fetchConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String query = "select full_name, address, pincode, payment_status from pickup_request,payment where "+
							"pickup_request.pickup_id = payment.pickup_id and store_id = '"+storeId+"' and payment_status = 1";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				recordList = null;
			} else {
				rs.previous();
				while(rs.next()){
					List<String> record = new ArrayList<String>();
					record.add(rs.getString("full_name"));
					record.add(rs.getString("address"));
					record.add(rs.getString("pincode"));
					int intPaymentStatus = rs.getInt("payment_status");
					String paymentStatus = (intPaymentStatus == 0) ? "UNPAID" : "PAID" ;
					record.add(paymentStatus);
					recordList.add(record);
				}
			}
		} catch(Exception e){
			out.println(" Fetch pickup request record exception: " +e);
		} finally {
			closeConnection();
		}
		return recordList;
	}
%>
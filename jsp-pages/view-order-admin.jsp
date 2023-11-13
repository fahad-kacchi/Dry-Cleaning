<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>


<%
	String storeId = request.getParameter("storeId");
	try{
		List<List<String>> newRequestList = fetchNewRequestByStoreId(storeId, out);
		if(newRequestList == null){
			out.println("NULL");
		} else {
			String recordString = "";
			int i = 0;
			for(List<String> list : newRequestList){
				for(String record : list){
					recordString = recordString + record + "$";
					++i;
				}
			}
			out.println(recordString);
		}
	} catch(Exception e){
		out.println(" View new requests exception: " +e);
	}
%>

<%!
	public static List<List<String>> fetchNewRequestByStoreId(String storeId, JspWriter out) throws Exception {
		List<List<String>> newRequestList = new ArrayList<List<String>>();
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select * from pickup_request where completed_status = 0 and store_id = '"+storeId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				newRequestList = null;
			} else {
				List<String> record = new ArrayList<String>();
				record.add(rs.getString("pickup_id"));
				record.add(rs.getString("full_name"));
				record.add(rs.getString("address"));
				record.add(rs.getString("pincode"));
				record.add(rs.getString("pickup_date"));
				record.add(rs.getString("pickup_time"));

				record.add(rs.getString("saree_wash_qty"));
				record.add(rs.getString("saree_iron_qty"));
				record.add(rs.getString("jeans_wash_qty"));
				record.add(rs.getString("jeans_iron_qty"));

				record.add(rs.getString("suit_wash_qty"));
				record.add(rs.getString("suit_iron_qty"));
				record.add(rs.getString("top_wash_qty"));
				record.add(rs.getString("top_iron_qty"));

				record.add(rs.getString("store_id"));
				record.add(rs.getString("customer_id"));
				newRequestList.add(record);
			}
			
		} catch(Exception e){
			out.println(" Fetch new requests exception: " +e);
		} finally {
			closeConnection();
		}
		return newRequestList;
	}
%>
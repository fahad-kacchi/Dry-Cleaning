<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String customerId = request.getParameter("customerId");
	try{
		List<List<String>> storeList = loadAllStores(out);
		if(storeList == null){
			out.println(" Records not found! ");
		} else {
			String record = "";
			for(List<String> list : storeList){
				String URL = "pickup-request.html?customerId="+customerId+"&storeId="+list.get(0);
				 record += ""+
					"<div class=\"col-md-4 padding\">"+
						"<div class=\"card\">"+
							"<div class=\"card-body\">"+
								"<h4 class=\"card-title\"><b> Store Name:<br> "+list.get(1)+" </b></h4>"+
								"<p class=\"card-text\"> Address: "+list.get(2)+"</p>"+
								"<p class=\"card-text\"> Pincode: "+list.get(3)+"</p>"+
								"<p class=\"card-text\"> Phone No: "+list.get(4)+"</p>"+
								"<a href="+URL+" class=\"btn btn-primary\"> Select Store </a>"+
							"</div>"+
						"</div>"+
					"</div>";
			}
			out.println(record);
		}
	} catch(Exception e){
		out.println(" Load all stores exception: " +e);
	}
%>



<%!
	public static List<List<String>> loadAllStores(JspWriter out) throws Exception{
		List<List<String>> storeList = new ArrayList<List<String>>();
		try{
			con = fetchConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String query = "select * from store_login where admin_approve_flag = 1";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				return null;
			} else {
				rs.previous();
				while(rs.next()){
					List<String> record = new ArrayList<String>();
					record.add(rs.getString("store_id"));
					record.add(rs.getString("store_name"));
					record.add(rs.getString("store_address"));
					record.add(rs.getString("pincode"));
					record.add(rs.getString("mobile_no"));
					storeList.add(record);
				}
			}
		} catch(Exception e){
			out.println(" load all stores method exception: " +e);
		} finally {
			closeConnection();
		}
		return storeList;
	}
%>
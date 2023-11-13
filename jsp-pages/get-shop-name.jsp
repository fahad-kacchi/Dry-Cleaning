<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String storeId = request.getParameter("storeId");
	try{
		String shopName = getShopNameByStoreId(storeId, out);
		if(shopName != null){
			out.println(shopName);
		}
	} catch(Exception e){
		out.println(" Get shop name exception: " +e);
	}
%>

<%!
	public static String getShopNameByStoreId(String storeId,  JspWriter out) throws Exception{
		String shopName = "";
		if(storeId != null){
			try{
				con = fetchConnection();
				stmt = con.createStatement();
				String query = "select store_name from store_login where store_id = '"+storeId+"'";
				rs = stmt.executeQuery(query);
				if(!rs.next()){
					shopName = null;
				} else {
					shopName = rs.getString("store_name");
				}
			} catch(Exception e){
				out.println(" Get shop name by store id exception: " +e);
			}
		}
		return shopName;
	}
%>
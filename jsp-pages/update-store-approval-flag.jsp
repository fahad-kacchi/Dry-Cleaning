<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String storeId = request.getParameter("storeId");
	String approveOrReject = request.getParameter("approve");
	
	if(approveOrReject.equals("YES")){
		try{
			boolean isUpdated = updateStoreApprovalFlag(storeId, out);
			if(isUpdated){
				String SUCCESS = " <center> <font color=green size=5> Successfully Approved! "+
								"<a href=\"../admin-approval.html\">Click here to go back!</a></font> </center>";
				out.println(SUCCESS);
			} else {
				String ERROR = " <center> <font color=red size=5> ERROR 404! "+
								"<a href=\"../admin-approval.html\">Click here to go back!</a></font> </center>";
				out.println(ERROR);
			}
		} catch(Exception e){		
			out.println(" Update store approve flag exception: " +e);
		}
	}
%>

<%!
	public static boolean updateStoreApprovalFlag(String storeId, JspWriter out) throws Exception{
		boolean flag = false;
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "update store_login set admin_approve_flag = 1 where store_id = '"+storeId+"'";
			stmt.executeUpdate(query);
			flag = true;
		} catch(Exception e){
			out.println(" Update store approval flag exception: " +e);
		} finally {
			closeConnection();
		}
		return flag;
	}
%>
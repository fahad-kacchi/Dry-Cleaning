<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	try{
		List<List<String>> storeList = getListOfStore(out);
		if(storeList == null){
			out.println(" Records not found! ");
		} else {
			String record = "";
			for(List<String> list : storeList){
				String approveURL = "jsp-pages/update-store-approval-flag.jsp?storeId="+list.get(0)+"&approve=YES";
				String rejectURL = "jsp-pages/update-store-approval-flag.jsp?storeId="+list.get(0)+"&approve=NO";
				 record += ""+
					"<tr>"+
						"<th scope=\"col\" class=\"align-middle\">"+list.get(0)+"</th>"+
						"<th scope=\"col\" class=\"align-middle\">"+list.get(1)+"</th>"+
						"<th scope=\"col\" class=\"align-middle\">"+list.get(2)+"</th>"+
						"<th scope=\"col\" class=\"align-middle\">"+list.get(3)+"</th>"+
						"<th scope=\"col\">"+
							"<a href="+approveURL+" type=\"button\" class=\"btn btn-sm btn-primary\">Approve</a>"+
						"</th>"+
					"</tr>";
			}
			out.println(record);
		}
	} catch(Exception e){
		out.println(" Display store details to admin exception: " +e);
	}
%>

<%!
	public static List<List<String>> getListOfStore(JspWriter out) throws Exception{
		List<List<String>> storeList = new ArrayList<List<String>>();
		try{
			con = fetchConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String query = "select * from store_login where admin_approve_flag = 0";
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
					storeList.add(record);
				}
			}
		} catch(Exception e){
			out.println(" Get list of store exception: " +e);
		} finally {
			closeConnection();
		}
		return storeList;
	}
%>
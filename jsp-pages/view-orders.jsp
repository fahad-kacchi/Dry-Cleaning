<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String customerId = request.getParameter("customerId");
	try{
		List<List<String>> orderList = getOrdersByCustomerId(customerId, out);
		String storeId = getStoreId(customerId, out);
		if(orderList != null){
			List<Double> eachOrderAmount = getOrderAmountByOrderList(orderList, storeId, out);
			String shopName = getShopNameByStoreId(storeId, out);
			int i = 0;
			String printRecord = "";
			for(List<String> list : orderList){
				printRecord += ""+
				"<tr>"+
					"<th scope=\"row\">"+(i+1)+"</th>"+
					"<td>"+list.get(1)+"</td>"+
					"<td>"+shopName+"</td>"+
					"<td>"+list.get(4)+"</td>"+
					"<td> INR: "+eachOrderAmount.get(i)+"</td>"+
				"</tr>";
				++i;
			}
			out.println(printRecord);
		} else {
		}
		
	} catch(Exception e){
		out.println(" View orders exception: " +e);
	}
%>

<%!
	public static List<List<String>> getOrdersByCustomerId(String customerId, JspWriter out) throws Exception{
		List<List<String>> orderList = new ArrayList<List<String>>();
		
		try{
			con = fetchConnection();
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			String query = "select * from pickup_request where customer_id = '"+customerId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				orderList = null;
			} else {
				rs.previous();
				while(rs.next()){
					List<String> record = new ArrayList<String>();
					record.add(rs.getString("pickup_id"));
					record.add(rs.getString("full_name"));
					record.add(rs.getString("pincode"));
					record.add(rs.getString("pickup_time"));
					record.add(rs.getString("pickup_date"));
					
					record.add(rs.getInt("saree_wash_qty")+"");	//5
					record.add(rs.getInt("saree_iron_qty")+"");
					record.add(rs.getInt("jeans_wash_qty")+"");
					record.add(rs.getInt("jeans_iron_qty")+"");
					record.add(rs.getInt("suit_wash_qty")+"");
					record.add(rs.getInt("suit_iron_qty")+"");
					record.add(rs.getInt("top_wash_qty")+"");
					record.add(rs.getInt("top_iron_qty")+"");
					orderList.add(record);
				}
			}
		} catch(Exception e){
			out.println(" Get orders by customer exception: " +e);
		} finally {
			closeConnection();
		}
		return orderList;
	}
%>

<%!
	public static String getStoreId(String customerId, JspWriter out) throws Exception {
		String storeId = "";
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select store_id from pickup_request where customer_id = '"+customerId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				storeId = null;
			} else {
				storeId = rs.getString("store_id");
			}
		} catch(Exception e){
			out.println(" Get store id exception: " +e);
		} finally {
			closeConnection();
		}
		return storeId;
	}
%>

<%!
	public static List<Double> getRatesByStoreId(String storeId,  JspWriter out) throws Exception{
		List<Double> rates = new ArrayList<Double>();
		if(storeId != null){
			try{
				con = fetchConnection();
				stmt = con.createStatement();
				String query = "select * from rate where store_id = '"+storeId+"'";
				rs = stmt.executeQuery(query);
				if(!rs.next()){
					rates = null;
				} else {
					rates.add(rs.getDouble("saree_wash_amt"));
					rates.add(rs.getDouble("saree_iron_amt"));
					rates.add(rs.getDouble("jeans_wash_amt"));
					rates.add(rs.getDouble("jeans_iron_amt"));
					                
					rates.add(rs.getDouble("suit_wash_amt"));
					rates.add(rs.getDouble("suit_iron_amt"));
					rates.add(rs.getDouble("top_wash_amt"));
					rates.add(rs.getDouble("top_iron_amt"));
				}
			} catch(Exception e){
				out.println(" Get order amount by order list exception: " +e);
			}
		}
		return rates;
	}
%>

<%!
	public static List<Double> getOrderAmountByOrderList(List<List<String>> orderList, String storeId, JspWriter out) throws Exception{
		List<Double> orderAmount = new ArrayList<Double>();
		List<Double> rates = getRatesByStoreId(storeId, out);
		if(rates != null){
			try{
				for(List<String> list : orderList){
					double amount = Integer.parseInt(list.get(5))*rates.get(0)+ 
									Integer.parseInt(list.get(6))*rates.get(1)+ 
									Integer.parseInt(list.get(7))*rates.get(2)+ 
									Integer.parseInt(list.get(8))*rates.get(3)+ 
									
									Integer.parseInt(list.get(9))*rates.get(4)+ 
									Integer.parseInt(list.get(10))*rates.get(5)+
									Integer.parseInt(list.get(11))*rates.get(6)+ 
									Integer.parseInt(list.get(12))*rates.get(7);
					orderAmount.add(amount);
				}
			} catch(Exception e){
				out.println(" Get order amount by order list exception: " +e);
			}
		}
		return orderAmount;
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
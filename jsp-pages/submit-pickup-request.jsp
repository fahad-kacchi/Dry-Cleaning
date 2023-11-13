<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String customerId = request.getParameter("customerID");
	String storeId = request.getParameter("storeID");
	int sareeWashingQty = Integer.parseInt(request.getParameter("verifiedSareeWashingQty"));
	int sareeIroningQty = Integer.parseInt(request.getParameter("verifiedSareeIroningQty"));
	int suitWashingQty =  Integer.parseInt(request.getParameter("verifiedSuitWashingQty"));
	int suitIroningQty =  Integer.parseInt(request.getParameter("verifiedSuitIroningQty"));
	int jeansWashingQty = Integer.parseInt(request.getParameter("verifiedJeansWashingQty"));
	int jeansIroningQty = Integer.parseInt(request.getParameter("verifiedJeansIroningQty"));
	int topWashingQty =   Integer.parseInt(request.getParameter("verifiedTopWashingQty"));
	int topIroningQty =   Integer.parseInt(request.getParameter("verifiedTopIroningQty"));

	List<Integer> quantities = new ArrayList<Integer>();
	quantities.add(sareeWashingQty);
	quantities.add(sareeIroningQty);
	quantities.add(suitWashingQty);
	quantities.add(suitIroningQty);
	quantities.add(jeansWashingQty);
	quantities.add(jeansIroningQty);
	quantities.add(topWashingQty);
	quantities.add(topIroningQty);
	
	try{
		boolean flag = updatePickupRequestTable(storeId, customerId, quantities, out);
		if(flag){
			List<String> record = getOrdersByCustomerId(customerId, out);
			double finalAmount = getOrderAmountByOrderList(record, storeId, out);
			String pickupId = getPickupId(storeId, customerId, out);
			makeEntryToPaymentTable(pickupId, finalAmount, 0, out);
			out.println(" Updated successfully! ");
			response.sendRedirect("../completed-requests.html?storeId="+storeId);
		} else {
			out.println(" Error 404! ");
		}
	} catch(Exception e){
		out.println(" Submit pickup request exception: " +e);
	}
%>

<%!
	public static String getPickupId(String storeId, String customerId, JspWriter out) throws Exception{
		String pickupId = "";
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select pickup_id from pickup_request where store_id  = '"+storeId+"' and customer_id = '"+customerId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				pickupId = null;
			} else {
				pickupId = rs.getString("pickup_id");
			}
		} catch(Exception e){
			out.println(" Get pickup id exception: " +e);
		} finally {
			closeConnection();
		}
		return pickupId;
	}
%>

<%!
	public static boolean updatePickupRequestTable(String storeId, String customerId, List<Integer> quantities, JspWriter out) throws Exception {
		boolean flag = false;
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "update pickup_request set "+
								"saree_wash_qty = "+quantities.get(0)+""+
								", saree_iron_qty = "+quantities.get(1)+""+
								", jeans_wash_qty = "+quantities.get(2)+""+
								", jeans_iron_qty = "+quantities.get(3)+""+
								", suit_wash_qty = "+quantities.get(4)+""+
								", suit_iron_qty = "+quantities.get(5)+""+
								", top_wash_qty = "+quantities.get(6)+""+
								", top_iron_qty = "+quantities.get(7)+""+
								"where store_id = '"+storeId+"' and customer_id = '"+customerId+"'";
			stmt.executeUpdate(query);
			flag = true;
		} catch(Exception e){
			out.println(" Update pickup request table exception: " +e);
		} finally {
			closeConnection();
		}
		return flag;
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
	public static double getOrderAmountByOrderList(List<String> list, String storeId, JspWriter out) throws Exception{
		double finalAmount = 0.0;
		List<Double> rates = getRatesByStoreId(storeId, out);
		if(rates != null){
			try{
				finalAmount = Integer.parseInt(list.get(5))*rates.get(0)+ 
							  Integer.parseInt(list.get(6))*rates.get(1)+ 
							  Integer.parseInt(list.get(7))*rates.get(2)+ 
							  Integer.parseInt(list.get(8))*rates.get(3)+ 
							  Integer.parseInt(list.get(9))*rates.get(4)+ 
							  Integer.parseInt(list.get(10))*rates.get(5)+
							  Integer.parseInt(list.get(11))*rates.get(6)+ 
							  Integer.parseInt(list.get(12))*rates.get(7);
			} catch(Exception e){
				out.println(" Get order amount by order list exception: " +e);
			}
		}
		return finalAmount;
	}
%>


<%!
	public static List<String> getOrdersByCustomerId(String customerId, JspWriter out) throws Exception{
		List<String> record = new ArrayList<String>();
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select * from pickup_request where customer_id = '"+customerId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				record = null;
			} else {
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
			}
		} catch(Exception e){
			out.println(" Get orders by customer exception: " +e);
		} finally {
			closeConnection();
		}
		return record;
	}
%>

<%!
	public static void makeEntryToPaymentTable(String pickupId, double finalAmount, int paymentStatus, JspWriter out) throws Exception{
		String paymentId = generatePrimaryKey("PY", "payment", "payment_id", out);
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "insert into payment values('"+paymentId+"', "+finalAmount+", "+paymentStatus+", '"+pickupId+"')";
			stmt.executeUpdate(query);
		} catch(Exception e){
			out.println(" Make entry to payment table exception: " +e);
		} finally {
			closeConnection();
		}
	}
%>
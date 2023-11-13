<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String customerId = request.getParameter("customerId");
	try{
		List<String> rateDetails = getRateDetails(customerId, out);
		List<String> pickupDetails = getPickupRequestDetails(customerId, out);
		List<String> paymentDetails = getPaymentDetails(customerId, out);
		List<String> storeDetails = getStoreDetails(customerId, out);
		
		int sumOfWashingQty = Integer.parseInt(pickupDetails.get(5))+
							  Integer.parseInt(pickupDetails.get(7))+
							  Integer.parseInt(pickupDetails.get(9))+
							  Integer.parseInt(pickupDetails.get(11));
	
		int sumOfIroningQty = Integer.parseInt(pickupDetails.get(6))+
							  Integer.parseInt(pickupDetails.get(8))+
							  Integer.parseInt(pickupDetails.get(10))+
							  Integer.parseInt(pickupDetails.get(12));
		  
		int sumOfWashingRate = Integer.parseInt(rateDetails.get(0))+
		                       Integer.parseInt(rateDetails.get(2))+
			                   Integer.parseInt(rateDetails.get(4))+
                               Integer.parseInt(rateDetails.get(6));
							   
		int sumOfIroningRate = Integer.parseInt(rateDetails.get(1))+
		                       Integer.parseInt(rateDetails.get(3))+
			                   Integer.parseInt(rateDetails.get(5))+
                               Integer.parseInt(rateDetails.get(7));
							   
		String printInvoice = ""+
			"<div class=\"row\" id=\"mydiv\">"+
					"<div class=\"col-md-6\">"+
						"<table class=\"table table-bordered\" style=\"background-color:white\">"+
							"<thead>"+
								"<tr>"+
									"<th class=\"text-left\" scope=\"row\">"+
										"<p>Customer name:"+pickupDetails.get(0)+"</p>"+
										"<p>Address:      "+pickupDetails.get(4)+"</p>"+
										"<p>Pincode:      "+pickupDetails.get(2)+"</p>"+
										"<p>Final Amount: "+paymentDetails.get(0)+"</p>"+
									"</th>"+
								"</tr>"+
							"</thead>"+
						"</table>"+
					"</div>"+
					"<div class=\"col-md-6\">"+
						"<table class=\"table table-bordered\" style=\"background-color:white\">"+
							"<thead>"+
								"<tr>"+
									"<th class=\"text-left\" scope=\"row\">"+
										"<p>Store name:  "+storeDetails.get(0)+"</p>"+
										"<p>Address:    "+storeDetails.get(2)+"</p>"+
										"<p>Pincode:    "+storeDetails.get(4)+"</p>"+
										"<p>Contact No: "+storeDetails.get(3)+"</p>"+
									"</th>"+
								"</tr>"+
							"</thead>"+
						"</table>"+
					"</div>"+
				"</div>"+
				"<table class=\"table table-bordered\" style=\"background-color:white\">"+
					"<thead>"+
						"<tr>"+
							"<th scope=\"row\">Sr. No.</th>"+
							"<th scope=\"row\" colspan=4>Washing Quantity</th>"+
							"<th scope=\"row\" colspan=4>Washing Rate</th>"+
						"</tr>"+
						"<tr>"+
							"<th scope=\"row\"></th>"+
							"<th scope=\"row\">Saree</th>"+
							"<th scope=\"row\">Jeans</th>"+
							"<th scope=\"row\">Suit</th>"+
							"<th scope=\"row\">Top</th>"+
							"<th scope=\"row\">Saree</th>"+
							"<th scope=\"row\">Jeans</th>"+
							"<th scope=\"row\">Suit</th>"+
							"<th scope=\"row\">Top</th>"+
						"</tr>"+
					"</thead>"+
					"<tbody id=\"print-details-id\">"+
						"<tr>"+
							"<td>1</td>"+
							"<td>"+pickupDetails.get(5)+"</td>"+
							"<td>"+pickupDetails.get(7)+"</td>"+
							"<td>"+pickupDetails.get(9)+"</td>"+
							"<td>"+pickupDetails.get(11)+"</td>"+
							
							"<td>"+rateDetails.get(0)+"</td>"+
							"<td>"+rateDetails.get(2)+"</td>"+
							"<td>"+rateDetails.get(4)+"</td>"+
							"<td>"+rateDetails.get(6)+"</td>"+
						"</tr>"+
						
					"</tbody>"+
				"</table>"+
				
				"<table class=\"table table-bordered\" style=\"background-color:white\">"+
					"<thead>"+
						"<tr>"+
							"<th scope=\"row\">Sr. No.</th>"+
							"<th scope=\"row\" colspan=4>Ironing Quantity</th>"+
							"<th scope=\"row\" colspan=4>Ironing Rate</th>"+
						"</tr>"+
						"<tr>"+
							"<th scope=\"row\"></th>"+
							"<th scope=\"row\">Saree</th>"+
							"<th scope=\"row\">Jeans</th>"+
							"<th scope=\"row\">Suit</th>"+
							"<th scope=\"row\">Top</th>"+
							
							"<th scope=\"row\">Saree</th>"+
							"<th scope=\"row\">Jeans</th>"+
							"<th scope=\"row\">Suit</th>"+
							"<th scope=\"row\">Top</th>"+
						"</tr>"+
					"</thead>"+
					"<tbody id=\"print-details-id\">"+
						"<tr>"+
							"<td>1</td>"+
							"<td>"+pickupDetails.get(6)+"</td>"+
							"<td>"+pickupDetails.get(8)+"</td>"+
							"<td>"+pickupDetails.get(10)+"</td>"+
							"<td>"+pickupDetails.get(12)+"</td>"+
							
							
							"<td>"+rateDetails.get(1)+"</td>"+
							"<td>"+rateDetails.get(3)+"</td>"+
							"<td>"+rateDetails.get(5)+"</td>"+
							"<td>"+rateDetails.get(7)+"</td>"+
						"</tr>"+
					"</tbody>"+
				"</table>"+

				"<div class=\"row\">"+
					"<div class=\"col-md-12\">"+
						"<table class=\"table table-bordered\" style=\"background-color:white\">"+
							"<thead>"+
								"<tr>"+
									"<th class=\"text-right\" scope=\"row\">"+
										"<p>Total: "+paymentDetails.get(0)+"</p>"+
									"</th>"+
								"</tr>"+
							"</thead>"+
						"</table>"+
					"</div>"+
				"</div>"+
				
				"<div class=\"row\">"+
					"<div class=\"col-md-12\">"+
						"<td><a href=\"index.html\" class=\"btn btn-primary btn-sm\">Logout</a></td>"+
					"</div>"+
				"</div>"+
			"</div>";
		out.println(printInvoice);
 	} catch(Exception e){
		out.println(" Print details of invoice exception: " +e);
	}
%>

<%!
	public static List<String> getRateDetails(String customerId, JspWriter out)  throws Exception{
		List<String> rateDetails = new ArrayList<String>();
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = ""+
				"select *"+
				" from rate"+
				" where store_id = (select store_id from pickup_request"+
				" where pickup_id = (select pickup_id from payment"+
				" where payment_status = 1) and customer_id = '"+customerId+"')";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				rateDetails = null;
			} else {
				rateDetails.add(rs.getString("saree_wash_amt"));
				rateDetails.add(rs.getString("saree_iron_amt"));
				rateDetails.add(rs.getString("jeans_wash_amt"));
				rateDetails.add(rs.getString("jeans_iron_amt"));
				
				rateDetails.add(rs.getString("suit_wash_amt"));
				rateDetails.add(rs.getString("suit_iron_amt"));
				rateDetails.add(rs.getString("top_wash_amt"));
				rateDetails.add(rs.getString("top_iron_amt"));
			}
		} catch(Exception e){
			out.println(" Get invoice details exception: " +e);
		} finally {
			closeConnection();
		}
		return rateDetails;
	}
%>

<%!
	public static List<String> getPickupRequestDetails(String customerId, JspWriter out)  throws Exception{
		List<String> pickupDetails = new ArrayList<String>();
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = ""+
				"select *"+
				" from pickup_request"+
				" where pickup_id = (select pickup_id from payment"+
				" where payment_status = 1) and customer_id = '"+customerId+"'";

			rs = stmt.executeQuery(query);
			if(!rs.next()){
				pickupDetails = null;
			} else {
				pickupDetails.add(rs.getString("full_name"));
				pickupDetails.add(rs.getString("pincode"));
				pickupDetails.add(rs.getString("pickup_time"));
				pickupDetails.add(rs.getString("pickup_date"));
				
				pickupDetails.add(rs.getString("address"));
				pickupDetails.add(rs.getString("saree_wash_qty"));
				pickupDetails.add(rs.getString("saree_iron_qty"));
				pickupDetails.add(rs.getString("jeans_wash_qty"));
                
				pickupDetails.add(rs.getString("jeans_iron_qty"));
				pickupDetails.add(rs.getString("suit_wash_qty"));
				pickupDetails.add(rs.getString("suit_iron_qty"));
                
				pickupDetails.add(rs.getString("top_wash_qty"));
				pickupDetails.add(rs.getString("top_iron_qty"));
			}
		} catch(Exception e){
			out.println(" getPickupRequestDetails exception: " +e);
		} finally {
			closeConnection();
		}
		return pickupDetails;
	}
%>

<%!
	public static List<String> getPaymentDetails(String customerId, JspWriter out)  throws Exception{
		List<String> paymentDetails = new ArrayList<String>();
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = ""+
				"select *"+
				" from payment"+
				" where pickup_id = (select pickup_id from pickup_request"+
				" where customer_id = '"+customerId+"') and payment_status = 1";

			rs = stmt.executeQuery(query);
			if(!rs.next()){
				paymentDetails = null;
			} else {
				paymentDetails.add(rs.getString("payment_amount"));
				paymentDetails.add(rs.getString("payment_status"));
				paymentDetails.add(rs.getString("pickup_id"));
				paymentDetails.add(rs.getString("payment_date"));
				paymentDetails.add(rs.getString("payment_time"));
			}
		} catch(Exception e){
			out.println(" getPickupRequestDetails exception: " +e);
		} finally {
			closeConnection();
		}
		return paymentDetails;
	}
%>

<%!
	public static List<String> getStoreDetails(String customerId, JspWriter out)  throws Exception{
		List<String> storeDetails = new ArrayList<String>();
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = ""+					
				"select *"+
				" from store_login"+
				" where store_id = (select store_id from pickup_request"+
				" where customer_id = '"+customerId+"' and pickup_id in (select pickup_id from payment"+
				" where payment_status = 1))";

			rs = stmt.executeQuery(query);
			if(!rs.next()){
				storeDetails = null;
			} else {
				storeDetails.add(rs.getString("store_name"));
				storeDetails.add(rs.getString("email"));
				storeDetails.add(rs.getString("store_address"));
				storeDetails.add(rs.getString("mobile_no"));
				storeDetails.add(rs.getString("pincode"));
			}
		} catch(Exception e){
			out.println(" getStoreDetails exception: " +e);
		} finally {
			closeConnection();
		}
		return storeDetails;
	}
%>
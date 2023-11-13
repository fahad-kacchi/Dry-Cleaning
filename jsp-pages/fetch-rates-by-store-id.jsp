<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String storeId = request.getParameter("storeId");
	try{
		List<Double> listOfRates = fetchRatesListByStoreId(storeId, out);
		if(listOfRates != null){
			int i = 1;
			String rateString = "";
			for(double rate : listOfRates){
				rateString = rateString + rate + "$";
				i++;
			}
			out.println(rateString);
		} else {
			out.println("NULL");
		}
	} catch(Exception e){
		out.println(" Fetch rates by store id exception: " +e);
	}
%>

<%!
	public static List<Double> fetchRatesListByStoreId(String storeId, JspWriter out) throws Exception{
		List<Double> listOfRates = new ArrayList<Double>();
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select * from rate where store_id = '"+storeId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				listOfRates = null;
			} else {
				listOfRates.add(rs.getDouble("saree_wash_amt"));
				listOfRates.add(rs.getDouble("saree_iron_amt"));
				listOfRates.add(rs.getDouble("jeans_wash_amt"));
				listOfRates.add(rs.getDouble("jeans_iron_amt"));
				listOfRates.add(rs.getDouble("suit_wash_amt"));
				listOfRates.add(rs.getDouble("suit_iron_amt"));
				listOfRates.add(rs.getDouble("top_wash_amt"));
				listOfRates.add(rs.getDouble("top_iron_amt"));
			}
		} catch(Exception e){
			out.println(" Fetch rates list by store id exception: " +e);
		} finally {
			closeConnection();
		}
		return listOfRates;
	}
%>
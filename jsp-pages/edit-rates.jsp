<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String storeId = request.getParameter("storeId");
	double sareeWashingRate = Double.parseDouble(request.getParameter("sareeWashing"));
	double sareeIroningRate = Double.parseDouble(request.getParameter("sareeIroning"));
	double suitWashingRate = Double.parseDouble(request.getParameter("suitWashing"));
	double suitIroningRate = Double.parseDouble(request.getParameter("suitIroning"));
	double jeansWashingRate = Double.parseDouble(request.getParameter("jeansWashing"));
	double jeansIroningRate = Double.parseDouble(request.getParameter("jeansIroning"));
	double topWashingRate = Double.parseDouble(request.getParameter("topWashing"));
	double topIroningRate = Double.parseDouble(request.getParameter("topIroning"));
	
	List<Double> ratesList = new ArrayList<Double>();
	ratesList.add(sareeWashingRate);
	ratesList.add(sareeIroningRate);
	ratesList.add(suitWashingRate);
	ratesList.add(suitIroningRate);
	ratesList.add(jeansWashingRate);
	ratesList.add(jeansIroningRate);
	ratesList.add(topWashingRate);
	ratesList.add(topIroningRate);
	
	try{
		String URL = "";
		boolean flag = editRatesDetails(storeId, ratesList, out);
		if(flag){
			URL = "../store-home.html?storeId="+storeId;
			String SUCCESS = " <center> <font color=green size=5> Successfully Updated! "+
							"<a href="+URL+">Click here to go back!</a></font> </center>";
			out.println(SUCCESS);
		} else {
			URL = "../add-store.html?storeId="+storeId;
			String ERROR = " <center> <font color=red size=5> ERROR 404! "+
							"<a href="+URL+">Click here to go back!</a></font> </center>";
			out.println(ERROR);
		}
	} catch(Exception e){
		out.println(" Store rates exception: " +e);
	}
%>

<%!
	public static boolean editRatesDetails(String storeId, List<Double> ratesList, JspWriter out) throws Exception{
		boolean flag = false;
		try{
			String rateId = generatePrimaryKey("R", "rate", "rate_id", out);
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "update rate set saree_wash_amt = "+ratesList.get(0)+", saree_iron_amt = "+ratesList.get(1)+", jeans_wash_amt = "+ratesList.get(2)+", jeans_iron_amt =  "+ratesList.get(3)+", suit_wash_amt = "+ratesList.get(4)+", suit_iron_amt = "+ratesList.get(5)+", top_wash_amt = "+ratesList.get(6)+", top_iron_amt = "+ratesList.get(7)+" where store_id = '"+storeId+"'";
			stmt.executeUpdate(query);
			flag = true;
		} catch(Exception e){
			out.println(" Edit store rates details exception: " +e);
		} finally {
			closeConnection();
		}
		return flag;
	}
%>
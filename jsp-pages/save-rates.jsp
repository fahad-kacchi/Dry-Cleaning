<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/database-operations.jsp" %>
<%@include file="utils/string-operations.jsp" %>

<%
	String storeId = request.getParameter("storeId");
	String URL = "";
	boolean isAlreadyRecord = isRatesAlreadyAdded(storeId, out);
	if(isAlreadyRecord){
		URL = "../store-home.html?storeId="+storeId;
		String MSG = " <center> <font color=red size=5> ERROR 404! Record already added! You cannot add more record! "+
						"<a href="+URL+">Click here to go back!</a></font> </center>";
		out.println(MSG);
	} else {
		double sareeWashingRate = Double.parseDouble(request.getParameter("sareeWashing"));
		double sareeIroningRate = Double.parseDouble(request.getParameter("sareeIroning"));
		double suitWashingRate = Double.parseDouble(request.getParameter("suitWashing"));
		double suitIroningRate = Double.parseDouble(request.getParameter("suitIroning"));
		double jeansWashingRate = Double.parseDouble(request.getParameter("jeansWashing"));
		double jeansIroningRate = Double.parseDouble(request.getParameter("jeansIroning"));
		double topWashingRate = Double.parseDouble(request.getParameter("topWashing"));
		double topIroningRate = Double.parseDouble(request.getParameter("topIroning"));
		
		//out.println(storeId + " " + sareeWashingRate + " " + sareeIroningRate + " " + suitWashingRate + " " + suitIroningRate + " " + jeansWashingRate + " " + jeansIroningRate + " " + topWashingRate  + " " + topIroningRate);
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
			boolean flag = storeRatesDetails(storeId, ratesList, out);
			if(flag){
				URL = "../store-home.html?storeId="+storeId;
				String SUCCESS = " <center> <font color=green size=5> Successfully Approved! "+
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
	}
%>

<%!
	public static boolean storeRatesDetails(String storeId, List<Double> ratesList, JspWriter out) throws Exception{
		boolean flag = false;
		try{
			String rateId = generatePrimaryKey("R", "rate", "rate_id", out);
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "insert into rate values('"+rateId+"', "+ratesList.get(0)+", "+ratesList.get(1)+", "+ratesList.get(2)+", "+ratesList.get(3)+", "+ratesList.get(4)+", "+ratesList.get(5)+", "+ratesList.get(6)+", "+ratesList.get(7)+", '"+storeId+"')";
			stmt.executeUpdate(query);
			flag = true;
		} catch(Exception e){
			out.println(" Store rates details exception: " +e);
		} finally {
			closeConnection();
		}
		return flag;
	}
%>

<%!
	public static boolean isRatesAlreadyAdded(String storeId, JspWriter out) throws Exception{
		boolean flag = false;
		try{
			con = fetchConnection();
			stmt = con.createStatement();
			String query = "select * from rate where store_id = '"+storeId+"'";
			rs = stmt.executeQuery(query);
			if(!rs.next()){
				flag = false;
			} else {
				flag = true;
			}
		} catch(Exception e){
			out.println(" Store rates details exception: " +e);
		} finally {
			closeConnection();
		}
		return flag;
	}
%>
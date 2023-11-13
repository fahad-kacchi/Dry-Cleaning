<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="common-database.jsp" %>
<%@include file="../utils/Constants.jsp" %>
<%@include file="../utils/key-value-class.jsp" %>

<%
    /*
	try{
		List<KeyValue> data = new ArrayList<KeyValue>();
		//data.add(new KeyValue(DTConstants.STRING, new String("fullname")));
		//data.add(new KeyValue(DTConstants.STRING, new String("email")));
		//data.add(new KeyValue(DTConstants.STRING, new String("password")));
		//data.add(new KeyValue(DTConstants.STRING, new String("confirmpass")));
		
		data.add(new KeyValue(DTConstants.INTEGER, new Integer(10)));
		data.add(new KeyValue(DTConstants.STRING, new String("ABCD")));
		data.add(new KeyValue(DTConstants.DOUBLE, new Double(20.9)));
		
		boolean isInsertFlag = insertData(data, "type1", out);
		if(isInsertFlag){
			out.println(" Data inserted successfully!");
		} else {
			out.println(" Error occurred!");
		}
	} catch(Exception e){
		out.println(" EXCEPTION: " +e);
	}
    */
%>

<%!
	public static boolean insertData(List<KeyValue> data, String tableName, JspWriter out) throws Exception{
		boolean flag = false;
		try{
			String query = generateInsertQuery(data, tableName, out);
			con = fetchConnection();
			stmt = con.createStatement();
			stmt.executeUpdate(query);
			flag = true;
		} catch(Exception e){
			out.println(" INSERT DATA EXCEPTION: " +e);
		} finally {
			closeConnection();
		}
		return flag;
	}
%>

<%!
	public static String generateInsertQuery(List<KeyValue> data, String tableName, JspWriter out) throws Exception{
		String query = "";
		try{
			query = "insert into "+tableName+" values(";
			for(KeyValue kv : data){  
				String key = kv.getKey();
				Object value = kv.getValue();
				out.println(key + " => " + value);

				if(key.equals(DTConstants.INTEGER)){
					query += ","+value;
				} else if(key.equals(DTConstants.STRING)){
					query += ",'"+value.toString()+"'";
				} else if(key.equals(DTConstants.FLOAT)){
					query += ","+value;
				} else if(key.equals(DTConstants.DOUBLE)){
					query += ","+value;
				}
			}  
			query += ")";
			String split[] = query.split("values");
			String firstPart = split[0];
			String secondPart = split[1].substring(2,split[1].length());
			query = firstPart + "values(" + secondPart;
		} catch(Exception e){
			out.println(" INSERT DATA EXCEPTION: " +e);
		} finally {
		}
		return query;
	}
%>

<!--
	create database demo;
	\c demo;
	create table type1(type_1 int, type_2 varchar(30), type_3 float);
-->
<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/common-database.jsp" %>

<%
    String email = request.getParameter("email-id");
    String password = request.getParameter("password");
    
    try{
        boolean isValid = checkLoginValidity(email, password, out);
        if(isValid){
            String customerId = getCurrentUsercustomerId(email, password, out);
            response.sendRedirect("../customer-homepage.html?customerId="+customerId);
        } else {
            String ERROR_MSG = "<center>"+
                                    "<font size=5 color=red>"+
                                        "<br><br>Invalid credentials!<br><br>"+
                                        "<a href=\"../customer-login-page.html\"> Click here to go back... </a>"+
                                    "</font>"+
                               "</center>";
            out.println(ERROR_MSG);
        }
    } catch(Exception e){
        out.println(" Competitor login exception: " +e);
    }
%>

<%!
    public static boolean checkLoginValidity(String email, String password, JspWriter out) throws Exception{
        boolean isValid = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select * from customer_login where email = '"+email+"' and password = '"+password+"'";
            rs = stmt.executeQuery(query);
            if(!rs.next()){
                isValid = false;
            } else {
                isValid = true;
            }
        } catch(Exception e){
            out.println(" Customer login validity exception: " +e);
        } finally {
            closeConnection();
        }
        return isValid;
    }
%>

<%!
    public static String getCurrentUsercustomerId(String email, String password, JspWriter out) throws Exception {
        String customerId = "";
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String query = "select customer_id from customer_login where email = '"+email+"' and password = '"+password+"'";
            rs = stmt.executeQuery(query);
            rs.next();
            customerId = rs.getString("customer_id");
        } catch(Exception e){
            out.println(" Get current customer id exception: " +e);
        } finally {
            closeConnection();
        }
        return customerId;
    }
%>
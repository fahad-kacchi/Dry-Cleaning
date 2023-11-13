<%@ page language="java" import="java.sql.*,javax.servlet.*,javax.servlet.http.*,java.io.*"%>

<%
    String emailId = request.getParameter("adminEmailId");
    String password = request.getParameter("adminPassword");
    
    try{
        if(emailId.equals("admin@123") && password.equals("admin")){
            response.sendRedirect("../admin-approval.html");
        } else {
            String ERROR_MSG = "<center>"+
                                    "<font size=5 color=red>"+
                                        "<br><br>Invalid credentials!<br><br>"+
                                        "<a href=\"../admin-login-page.html\"> Click here to go back... </a>"+
                                    "</font>"+
                               "</center>";
            out.println(ERROR_MSG);
        }
    } catch(Exception e){
        out.println(" Admin Login Exception: " +e);
    }
%>

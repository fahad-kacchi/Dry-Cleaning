<%@ page language="java" import="java.sql.*, java.util.*, java.time.*"%>
<%@include file="database-files/common-database.jsp" %>

<%
    String loginId = request.getParameter("loginId");
    int loginFlag = 0;
    
    boolean isUpdated = updateloginFlag(loginId, loginFlag, out);
    if(isUpdated){
        String MESSAGE = "<center>"+
                            "<font size=5 color=green>"+
                                "Logout successfully!!!<br><br>"+
                                "<a href=\"../index.html\">Click here login again.!!!</a>"+
                            "</font>"+
                         "<center>";
        out.println(MESSAGE);
    }
%>

<%!
    public static boolean updateloginFlag(String loginId, int loginFlag, JspWriter out) throws Exception{
        boolean isUpdatedFlag = false;
        try{
            con = fetchConnection();
            stmt = con.createStatement();
            String updateQuery = "update login set login_flag = "+loginFlag+" where login_id = '"+loginId+"'";
            stmt.executeUpdate(updateQuery);
            isUpdatedFlag = true;
        } catch(Exception e){
            out.println(" Update login status exception: " +e);
        } finally {
            closeConnection();
        }
        return isUpdatedFlag;
    }
%>
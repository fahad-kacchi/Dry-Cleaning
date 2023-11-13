<%@page language="java"%>

<%!
	public static boolean isNull(String str){
		if(str == null || str.equals("")){
			return true;
		}
		return false;
	}
%>
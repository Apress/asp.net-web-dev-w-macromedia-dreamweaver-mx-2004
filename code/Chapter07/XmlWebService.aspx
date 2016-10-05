<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@ Import Namespace="DeadOrAlive" %>
<%@ Import Namespace="System.Web.Services.Protocols"%>
<%@ Import Namespace="System.IO"%>
<script runat="server">

Sub Page_Load()
        Dim proxy As New DeadOrAlive()
		dim aDeadOrAlive as System.Data.DataSet = proxy.getDeadOrAlive("Fred Astair")

        mygrid.Datasource = aDeadOrAlive
		mygrid.Databind()

End Sub
</script>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form runat="server" action="xmlwebservice.aspx">
<asp:DataGrid id="mygrid" AutoGenerateColumns="true" runat="server"></asp:DataGrid>

</form>
</body>
</html>

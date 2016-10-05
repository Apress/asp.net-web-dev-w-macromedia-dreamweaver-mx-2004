<%@ Page Language="VB" Debug="true" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script runat="server">
Dim filepath As String
Dim strConn As String
Dim conn As OleDbConnection

Sub OpenConn()
	filePath = Server.MapPath("wines.mdb")
	strConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & filepath & ";"
	conn = new OleDbConnection(strConn) 
	conn.Open
End Sub

Sub Page_myError()
	Server.ClearError
	Response.Write("<FONT face=""Tahoma"" size=""2"" color=""#FF0000""><b>There has been an error! The database is unavailable at this time.</b></FONT>")
	Response.End
End Sub

Sub Page_Load()
' data binding to controls needs to be done before the page is formed
	Dim sqlCommand As OleDbDataAdapter
	Dim dsWines As Dataset

' open the connection
	If (conn Is Nothing) Then
	  Call OpenConn()
	End If
	dsWines = new DataSet()

' form the SQL command
	sqlCommand = new OleDbDataAdapter("SELECT tblPurchases.PurchaseShop, tblPurchases.PurchaseDate, tblWines.WineName, tblPurchases.PurchasePrice FROM tblWines INNER JOIN tblPurchases ON tblWines.WineID = tblPurchases.WineID WHERE (((tblPurchases.PurchaseShop)=""Ye Olde Wine Shoppe"") AND ((tblPurchases.PurchasePrice) Between 5 And 10)) ORDER BY tblPurchases.PurchaseShop, tblPurchases.PurchaseDate DESC , tblWines.WineName;", conn) 

	sqlCommand.Fill(dsWines)

' bind the dataset to the datalist
	harrodswines.DataSource = dsWines
	harrodswines.DataBind()
	dsWines.Dispose()
	
' close the connection 
	Call TidyUp()
	sqlCommand = Nothing
End Sub

Sub TidyUp()
	filepath=Nothing
	strConn=Nothing
	conn.Close
	conn.Dispose()
	conn=Nothing
End Sub

</script>
<html>
<head>
<title>Testing db</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form runat="server">
Here are the results of our query:<br>
<asp:datagrid ID="YeOldewines" runat="server"></asp:datagrid>
</form>
</body>
</html>

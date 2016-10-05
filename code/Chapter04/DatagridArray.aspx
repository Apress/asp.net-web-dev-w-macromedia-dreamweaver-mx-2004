<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" debug="true" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
If Not IsPostBack Then
Dim values As New HashTable()

values.Add("Microsoft","MSFT")
values.Add("Intel","INTL")
values.Add("Qualcomm","QCOM")
simpleDG.DataSource=values
simpleDG.DataBind()
End If
End Sub
</script></head>
<body>
<form runat="server">
<asp:DataGrid AutoGenerateColumns="false" ID="simpleDG" runat="server">
<Columns>
    <asp:BoundColumn DataField="<%# values.values %>" 
        HeaderText="WineID" 
        ReadOnly="true" 
        Visible="True"/>
    <asp:BoundColumn DataField="<%# values.keys %>" 
        HeaderText="WineName" 
        ReadOnly="true" 
        Visible="True"/>
</Columns></asp:DataGrid>
</form>
</body>
</html>

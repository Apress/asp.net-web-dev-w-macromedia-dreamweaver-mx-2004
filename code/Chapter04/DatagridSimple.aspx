<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" debug="true" %>
<html>
<head>
<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
	If Not IsPostBack Then
	Dim values As New ArrayList()
	values.Add("Microsoft")
	values.Add("Intel")
	values.Add("Dell")
	simpleDG.DataSource=values
	simpleDG.DataBind()
End If
End Sub

Sub ItemsGrid_Command(sender As Object, e As DataGridCommandEventArgs)
Select (CType(e.CommandSource, LinkButton)).CommandName
	Case "Select"
		sender.selectedIndex=e.Item.DataSetIndex
	Case Else
		' Do nothing.
End Select
End Sub
</script></head><body>
<form runat="server">
<asp:DataGrid AutoGenerateColumns="true" ID="simpleDG" OnItemCommand="ItemsGrid_Command" EditItemIndex="2" selectedIndex="1" runat="server">
<selecteditemstyle BackColor="#FF0000" ForeColor="#3300FF"></selecteditemstyle>
	<Columns>
		<asp:ButtonColumn HeaderText="Select item" ButtonType="LinkButton" Text="Select" CommandName="Select"/>
	</Columns>
</asp:DataGrid>
</form>
</body>
</html>

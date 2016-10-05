<%@ Page Language="VB" ContentType="text/html"  ResponseEncoding="iso-8859-1" inherits="ColorPage" src="ColorPageUI.vb"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form method="post" runat="server">
	<asp:Label id="welcomeMessage" runat="server"></asp:Label>
	<br><br> Day background color:
	<asp:DropDownList AutoPostBack="true" ID="ColorList" runat="server">
		<asp:ListItem Selected="True" Value="White">White</asp:ListItem>
		<asp:ListItem Value="Red">Red</asp:ListItem>
		<asp:ListItem Value="Green">Green</asp:ListItem>
		<asp:ListItem Value="Yellow">Yellow</asp:ListItem>
	</asp:DropDownList>
	<br><br> Weekend background color:
		<asp:DropDownList AutoPostBack="true" ID="ColorList2" runat="server">
		<asp:ListItem Selected="True" Value="White">White</asp:ListItem>
		<asp:ListItem Value="Red">Red</asp:ListItem>
		<asp:ListItem Value="Green">Green</asp:ListItem>
		<asp:ListItem Value="Yellow">Yellow</asp:ListItem>
	</asp:DropDownList>
	<br><br>
		<asp:Calendar id="Calendar1" ShowGridLines="True" ShowTitle="True" runat="server"/>
	</form>
</body>
</html>

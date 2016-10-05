<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<html>
<body>
   <form runat="server">
	Type anything to avoid the error message: <br>
	<asp:TextBox id="Text1" Text="" runat="server"/>
	<asp:RequiredFieldValidator id="RequiredFieldValidator1" ControlToValidate="Text1"  Text="You have not filled in this required field!"  runat="server"/>
	<br><asp:Button id="Button1" runat="server" Text="Validate"/>
   </form>
</body>
</html>

<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><!-- InstanceBegin template="/Templates/sampleTemplate.dwt.aspx" codeOutsideHTMLIsLocked="false" -->
<head>
<!-- InstanceBeginEditable name="doctitle" -->
<title>Untitled Document</title>
<!-- InstanceEndEditable -->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->
<style type="text/css">
<!--
.style1 {color: #FF0000}
.style2 {color: #00CCFF}
-->
</style>
</head>
<body>
<form runat="server">
<table width="400" border="1">
  <tr>
    <th bgcolor="#000000" scope="row"><div align="right" class="style2"><!-- InstanceBeginEditable name="AskForUsername" -->Benutzername<!-- InstanceEndEditable --></div></th>
    <td width="50%" bgcolor="#D6D3CE">
      <asp:TextBox ID="txtUNAME" TextMode="SingleLine" runat="server" />   </td>
  </tr>
  <tr>
    <th bgcolor="#000000" scope="row"><div align="right"><span class="style1"><!-- InstanceBeginEditable name="AskForPassword" -->Kennwort<!-- InstanceEndEditable --></span></div></th>
    <td width="50%" bgcolor="#D6D3CE">
      <asp:TextBox ID="txtPWD" TextMode="Password" runat="server" />    </td>
  </tr>
</table>
</body>
</form><!-- InstanceEnd --></html>

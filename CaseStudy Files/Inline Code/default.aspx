<%@ Page Language="VB" %>
<%@ Register TagPrefix="CaseStudy" TagName="Header" Src="Header.ascx" %>
<%@ Register TagPrefix="CaseStudy" TagName="Menu" Src="Menu.ascx" %>
<%@ Register TagPrefix="CaseStudy" TagName="Footer" Src="Footer.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Apress Hotel Home Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<CaseStudy:Header id="Header1" Text="Welcome" runat="server"></CaseStudy:Header>
<table width="750"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="130" align="center" valign="top" bgcolor="#CCCCCC"><CaseStudy:Menu id="Menu1" runat="server"></CaseStudy:Menu></td>
    <td width="620" valign="top"><br>      <table width="600" border="0" align="center">
      <tr>
        <td><p>Welcome to the home page of Apress Accommodations, here you will be able to browse all the lovely rooms and facilities our hotel has to offer, from top quality rooms such our Wedding Suite to our award winning restaurant the “Publishers Pantry” the quality speaks for itself, just like the cutting edge design of our site. </p></td>
      </tr>
    </table></td>
  </tr>
</table>
<CaseStudy:Footer id="Footer1" runat="server"></CaseStudy:Footer>
</body>
</html>
<%@ Page Language="vb" Debug="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<html>
<head>
<title>NATIVE Language School</title>

<script language="javascript" >
<!--
function checkSubmit()
{
	var sDay = document.examform.startday.options[document.examform.startday.selectedIndex].value 
	var sMonth = document.examform.startmonth.options[document.examform.startmonth.selectedIndex].value 
	var sYear = document.examform.startyear.options[document.examform.startyear.selectedIndex].value 

	if ((sDay==0)||(sMonth==0)||(sYear==0))
	{
		alert("\nPlease make sure that you have selected all date elements.\n")
	} else {
		document.examform.submit() 
	}
}

if ((navigator.appName == "Microsoft Internet Explorer") && (parseInt(navigator.appVersion) >= 4)) {
	document.write("<link REL='stylesheet' HREF='ie.css' TYPE='text/css'>");
} else {
	document.write("<link REL='stylesheet' HREF='std.css' TYPE='text/css'>");
} 
-->
</script><noscript><link REL='stylesheet' HREF='std.css' TYPE='text/css'></noscript>
</head>

<body TEXT="#000000" LINK="#FF0000" VLINK="#00EE00" ALINK="#FF0000" BGCOLOR="#FFFFFF" >
<div align="center">
<table BORDER="0" CELLSPACING="0" CELLPADDING="5" width="100%" >
  <tr>
     <td align="center" valign="middle" width="100%" height="20" >
	<table BORDER="0" bordercolor="#000000" CELLSPACING="0" CELLPADDING="0" width="600">
	  <tr>
	     <td bordercolor="#000000" valign="top" align="center" >
		<img src="header.gif" border="0" />
             </td>
	     <td bordercolor="#000000" valign="bottom" align="right" >
		<a href="someurl1.asp" >sitemap</a>&nbsp;|&nbsp;<a href="someurl2.asp" >contact</a><br><br>
             </td>
	  </tr>
	</table>
     </td>
  </tr>
  <tr>
     <td align="center" bgcolor="#3A529C" width="100%" >
	<table BORDER="1" bordercolor="#000000" CELLSPACING="0" CELLPADDING="0" width="600">
	  <tr>
	     <td bordercolor="#000000" valign="top" ><a href="someurl3.asp" ><img src="menuhome.gif" border="0" /></a></td>
	     <td bordercolor="#000000" valign="top" ><a href="someurl4.asp" ><img src="menucourses.gif" border="0" /></a></td>
	     <td bordercolor="#000000" valign="top" ><a href="someurl5.asp" ><img src="menujoin.gif" border="0" /></a></td>
	     <td bordercolor="#000000" valign="top" ><a href="someurl6.asp" ><img src="menumap.gif" border="0" /></a></td>
	  </tr>
	</table>
     </td>
  </tr>
  <tr>
     <td align="center" bgcolor="#FFFFFF" width="100%" >
	<table BORDER="0" bordercolor="#000000" CELLSPACING="0" CELLPADDING="5" width="600">
	  <tr>
	     <td bordercolor="#000000" align="center" valign="top"><img src="lingo1.jpg" border="0" /></td>
	     <td bordercolor="#000000" align="center" valign="top"><img src="lingo2.jpg" border="0" /></td>
	  </tr>
	</table>
     </td>
  </tr>
  <tr>
     <td align="center" bgcolor="#FFFFFF" width="100%" >
	<table BORDER="0" bordercolor="#000000" CELLSPACING="0" CELLPADDING="10" width="600">
	  <tr>
	     <td bgcolor="#3A529C" align="center" valign="top" class="content-wht">
		<b>Exam date availability</b><br><br>Use this form to check how many seats are available for your preferred testing date.</td>
	  </tr>
	  <tr>
	     <td bgcolor="#00FFFF" align="center" valign="top" class="content-blk">

<script runat="server">
Sub Page_Load()

Dim mystring as String
myString = Request.QueryString("course")

If (myString<>Nothing) Then

    Dim conn As OleDbConnection
    Dim sqlCommand As OleDbDataAdapter
    Dim strConn As String
    Dim rs As Dataset
    Dim filepath as String
    Dim stillFree as String
    Dim rr as Datarow
    Dim rt as Datatable
    Dim rc as Datacolumn

    Dim lblString As String

    filePath = Server.MapPath("LanguageSchool.mdb")
    strConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & filepath & ";"
    conn = new OleDbConnection(strConn) 
    conn.Open
    sqlCommand = new OleDbDataAdapter("SELECT stillfree FROM qryResults WHERE (Course=""" & Request.QueryString("course") & _
	""" AND examDate=#" & Request.QueryString("startday") & "/" & Request.QueryString("startmonth") & "/" & Request.QueryString("startyear") & "#)", conn) 
    rs = new DataSet()
    sqlCommand.Fill(rs)

' display results

    For Each rt In rs.Tables
      For Each rr In rt.Rows
        stillFree=rr(rt.Columns("stillfree"))
      Next
    Next
    If (stillFree <> Nothing) Then
      lblString="There are " & stillFree & " remaining places for this exam. "
      If (stillFree>0) Then
        lblString=lblString & "Click <a href=booking.asp>here</a> to book."
      End If
    Else
      lblString="There are 5 places available for this exam. Click <a href=booking.asp>here</a> to book."
    End If

    message.Text = lblString

    rs.Dispose
    conn.Close
    conn.Dispose

End If
End Sub

</script>
		<asp:Label runat="server" id="message"></asp:Label>
		<br><FORM name="examform" action="homeasp1.aspx" method="get">

		<SELECT name="course"><OPTION value="0" >_Select a Course_</OPTION>
		<OPTION value="English" >English</OPTION><OPTION value="French" >French</OPTION>
		<OPTION value="Italian" >Italian</OPTION><OPTION value="Spanish" >Spanish</OPTION></SELECT><br><br>
		<SELECT name="startday"><OPTION value="0">_Starting day_</OPTION>
<%
    Dim i As Integer
    For i=1 To 31
	Response.Write("<OPTION value=""" & i & """ >" & i & "</OPTION>")
    Next
    i=Nothing
%>
		</SELECT>
		<SELECT name="startmonth"><OPTION value="0">_Starting month_</OPTION><OPTION value="01">January</OPTION><OPTION value="02">February</OPTION><OPTION value="03">March</OPTION><OPTION value="04">April</OPTION></SELECT>
		<SELECT name="startyear"><OPTION value="0">_Starting year_<OPTION value="2002">2002</OPTION><OPTION value="2003">2003</OPTION><OPTION value="2004">2004</OPTION></SELECT>

		<br><br><INPUT type="button" value="Submit" onClick="checkSubmit()" />
		</FORM></td>
	  </tr>
	</table>
     </td>
  </tr>
</table>
</div>
</body>
</html>

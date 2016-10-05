<%@ Page Language="vb" Debug="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>

<script runat="server">
Sub Page_Load()

Dim strConn As String
Dim conn As OleDbConnection
Dim filepath as String

filePath = Server.MapPath("LanguageSchool.mdb")
strConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & filepath & ";"
conn = new OleDbConnection(strConn) 
conn.Open
message.Text = ""

If (Not IsPostback) Then

    Dim coursesCommand As OleDbDataAdapter
    Dim ds As Dataset

    coursesCommand = new OleDbDataAdapter("SELECT * FROM tblCourses", conn)
    ds = new DataSet()
    coursesCommand.Fill(ds)

' bind the courses table to the course drop down list
    course.DataSource = ds
    course.DataBind()
    ds.Dispose

End If

If ((Request.Form("course")<> Nothing) And (Request.Form("examDate")<> Nothing)) Then

    Dim sqlCommand As OleDbDataAdapter
    Dim rs As Dataset
    Dim stillFree as String
    Dim rr as Datarow
    Dim rt as Datatable
    Dim rc as Datacolumn

    Dim lblString As String

    sqlCommand = new OleDbDataAdapter("SELECT stillfree FROM qryResults WHERE (Course=""" & Request.Form("course") & _
	""" AND examDate=#" & Request.Form("examDate") & "#)", conn) 

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

' assign our message string to the label
    message.Text = lblString

    rs.Dispose

End If


' cleanup
conn.Close
conn.Dispose

End Sub

' upon date selection run this subroutine to assign the date to a form input box
Sub SelectionChange(sender As Object, e As System.EventArgs)

    message.Text = ""
    examDate.Text = Left(examDates.SelectedDate.toString(),10)

End Sub

' upon month navigation run this subroutine to clear the date from the form input box
Sub MonthChange(sender As Object, e As System.Web.UI.WebControls.MonthChangedEventArgs)

    message.Text = ""
    examDate.Text = ""

End Sub

</script>

<html>
<head>
<title>NATIVE Language School</title>

<script language="javascript" >
<!--
if ((navigator.appName == "Microsoft Internet Explorer") && (parseInt(navigator.appVersion) >= 4)) {
	document.write("<link REL='stylesheet' HREF='ie.css' TYPE='text/css'>");
} else {
	document.write("<link REL='stylesheet' HREF='std.css' TYPE='text/css'>");
} 
-->
</script><noscript><link REL='stylesheet' HREF='std.css' TYPE='text/css'></noscript>
</head>

<body TEXT="#000000" LINK="#FF0000" VLINK="#00EE00" ALINK="#FF0000" BGCOLOR="#FFFFFF" >
<FORM name="examform" id="examform" action="homeasp4.aspx" method="post" runat="server">
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


		<asp:Label runat="server" id="message" EnableViewState="True"></asp:Label>
		<br><br>
		<asp:DropDownList runat="server" id="course" name="course" width="138px" DataTextField="Course" DataValueField="Course" >
		</asp:DropDownList>
		<br><br>

		<asp:Calendar id="examDates" name="examDates" runat="server" Width="220px" Height="200px" BorderWidth="1px" 
			BackColor="White" DayNameFormat="FirstLetter" ForeColor="#003399" Font-Size="8pt" 
			Font-Names="Verdana" BorderColor="#3366CC" CellPadding="1" EnableViewState="True" 
			OnSelectionChanged="SelectionChange" OnVisibleMonthChanged="MonthChange">
			<TodayDayStyle ForeColor="White" BackColor="#99CCCC"></TodayDayStyle>
			<SelectorStyle ForeColor="#336666" BackColor="#99CCCC"></SelectorStyle>
			<NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF"></NextPrevStyle>
			<SelectedDayStyle Font-Bold="True" ForeColor="#CCFF99" BackColor="#009999"></SelectedDayStyle>
			<DayHeaderStyle Height="1px" ForeColor="#336666" BackColor="#99CCCC"></DayHeaderStyle>
			<TitleStyle Font-Size="10pt" Font-Bold="True" Height="25px" BorderWidth="1px" ForeColor="#CCCCFF" BorderStyle="Solid" BorderColor="#3366CC" BackColor="#003399"></TitleStyle>
			<WeekendDayStyle BackColor="#CCCCFF"></WeekendDayStyle>
			<OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>
		</asp:calendar>
		<br><br>Your selected date:<br>
		<asp:Textbox runat="server" name="examDate" id="examDate"  ></asp:Textbox><br>
		<asp:RequiredFieldValidator runat="server" id="checkdata" Text="* Please select a date." ControlToValidate="examDate" 
			ErrorMessage="Please select a date." />
		<br><br><asp:Button runat="server" Text="Submit" ></asp:Button>
		</td>
	  </tr>
	</table>
     </td>
  </tr>
</table>
</div>
</FORM>
</body>
</html>

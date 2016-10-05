<%@ Page Language="vb" Debug="true" %>


<script runat="server">
Sub Page_Load()
	Dim intSample As Integer
	Dim strSample As String
	intSample=2
	strSample="12"
	Call somesub(intSample, strSample)
End Sub

Sub somesub(password As String, loopnum As Integer)
	Dim i As Integer
	For i = 1 To loopnum
		password &= password
	Next
	message.Text = password
End Sub

</script>

<html>
<head>
<title>test</title>
</head>

<body TEXT="#000000" LINK="#FF0000" VLINK="#0066CC" ALINK="#FF0000" BGCOLOR="#FFFFFF" >
<FORM name="examform" id="examform" runat="server">
<div align="center">
<asp:Label runat="server" id="message" EnableViewState="True" Font-Names="Tahoma" ForeColor="#000000" Font-Size="Smaller" ></asp:Label>
</div>
</FORM>
</body>
</html>
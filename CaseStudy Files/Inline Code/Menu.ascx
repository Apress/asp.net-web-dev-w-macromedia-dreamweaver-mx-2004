<%@ Control Language="VB" %>
<script runat="server">
Sub Page_Load(Src As Object, E As EventArgs)
	Dim Ctl As Control
	For Each Ctl In Me.Controls
		If Ctl.GetType() Is GetType(System.Web.UI.HtmlControls.HtmlAnchor) Then
			Dim TheLink As System.Web.UI.HtmlControls.HtmlAnchor = Ctl
			Dim PageName As String = Request.Path()
			PageName = PageName.Substring(PageName.LastIndexOf("/") + 1)
			Dim LinkPage As String = TheLink.Href
			LinkPage = LinkPage.Substring(LinkPage.LastIndexOf("/") + 1)
			If LinkPage.ToLower().Equals(PageName.ToLower()) Then
				TheLink.Href = ""
				Exit For
			End If
		End If
	Next
End Sub
</script>
<table border="0">
  <tr>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="left"><a href="default.aspx" runat="server">Home</a></td>
  </tr>
  <tr>
    <td align="left"><a href="BrowseRooms.aspx" runat="server">Browse Rooms</a></td>
  </tr>
  <tr>
    <td align="left"><a href="BookRoom.aspx" runat="server">Book A Room</a></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
  </tr>
</table>

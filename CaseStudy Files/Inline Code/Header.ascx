<%@ Control Language="VB" %>
<script runat="server">

Public Property Text() As String
	Get
		Return Me.lblHeaderText.Text
	End Get
	Set(ByVal Value As String)
		Me.lblHeaderText.Text = Value
	End Set
End Property

</script>

 <table width="750"  border="0" cellpadding="0" cellspacing="0">
   <tr bgcolor="#CCCCCC">
     <td align="center" bgcolor="#CCCCCC"><strong>Apress Accommodation -</strong><asp:Label ID="lblHeaderText" runat="server" /></td>
   </tr>
</table>

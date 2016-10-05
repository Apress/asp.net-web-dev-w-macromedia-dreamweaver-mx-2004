<%@ Page Language="vb" AutoEventWireup="True" Debug="True"  %>
<script runat="server" >
Sub Page_Load()
   ' Produce division by 0 error
   On Error Resume Next
   Dim zero As Integer = 0
   Dim result As Integer
   result = 8 / zero
   ' error has occurred but we are resuming at this next statement
   Select Case Err.Number
      Case 0
      ' no error
      Case 6, 11
         Response.Write("Some variable must have been 0")
         result = 12
      Case Else
         Response.Write(Err.Description)
         result = 12
   End Select
   'Err.Clear()
   ' second Err.Description call prints empty strings if above is uncommented
   Response.Write(Err.Description)
End Sub
</script>


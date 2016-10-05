<%@ Page Language="vb" AutoEventWireup="True" Debug="True"  %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.IO" %>
<script runat="server" >

Sub Page_Load()
	Debug.Listeners.Remove("mynewlog")
	Debug.Listeners.Add(new TextWriterTraceListener("C:\Inetpub\wwwroot\dreamw\ch9\debug.log", "mynewlog"))
	Debug.WriteLine("I am in Sub Page_Load")
	' some code execution here
	Debug.WriteLine("Everything still fine")
	' some more risky actions here
	Debug.WriteLine("Continuing...")
	' a more direct debugging method
	Response.Write("I am in Sub Page_Load")
	anothersub()
End Sub
Sub anothersub()
	Debug.WriteLine("I am in Sub anothersub")
	Debug.Close
End Sub
</script>


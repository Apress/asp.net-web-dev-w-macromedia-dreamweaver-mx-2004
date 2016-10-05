<%@ Page Language="VB" ContentType="text/xml" ResponseEncoding="iso-8859-1" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.IO" %>
<%
' Create an XmlTextWriter that outputs to a StringWriter object
Dim sw As StringWriter = New StringWriter()
' Step 1
Dim w As XmlTextWriter = New XmlTextWriter(sw)
' Step 2
w.Formatting = Formatting.Indented
' Step 3
w.WriteStartDocument(true)
' Step 5
w.WriteComment("Price from a fictional real-estate agent")
w.WriteStartElement("estate")
w.WriteStartAttribute("type",String.Empty)
w.WriteString("PLOT")
w.WriteEndAttribute()
w.WriteElementString("area","160")
w.WriteElementString("price","34000")
w.WriteEndElement()
w.WriteEndDocument()
' Step 6
w.Close()
Response.Write(sw.toString())
%>

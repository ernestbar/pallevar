<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ingreso.aspx.cs" Inherits="GoChasquiAdmin.ingreso" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>  
            Ingrese su codigo <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><asp:Button ID="Ingresar" OnClick="Ingresar_Click" runat="server" Text="Button" />
        </div>
    </form>
</body>
</html>

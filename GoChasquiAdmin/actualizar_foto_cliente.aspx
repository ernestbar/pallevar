<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="actualizar_foto_cliente.aspx.cs" Inherits="GoChasquiAdmin.actualizar_foto_cliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsCliente" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaClienteIndividual">
        <SelectParameters>
            <%--<asp:Parameter Name="id_cliente" DefaultValue="2" />--%>
            <asp:ControlParameter ControlID="lblClienteID" Name="id_cliente" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsClienteUsuario" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaClienteUsuarioXUsuario">
        <SelectParameters>
            <%--<asp:Parameter Name="id_cliente" DefaultValue="2" />--%>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblIdUsuario" runat="server" Text="0" Visible="false"></asp:Label>
    <asp:Label ID="lblClienteID" runat="server" Text="0" Visible="false"></asp:Label>
    <div class="container">
        <!-- BEGIN #page-header -->
        <div id="page-header" class="section-container page-header-container">
            <asp:Repeater ID="Repeater2" DataSourceID="odsCliente" runat="server">
                <ItemTemplate>
                    <!-- BEGIN page-header-cover -->
                    <div class="page-header-cover no repeat">
                        <img src='<%# Eval("ruta_imagen") %>' alt="" />
                    </div>
                    <!-- END page-header-cover -->
                    <!-- BEGIN container -->
                    <div class="container">
                        <h1 class="page-header"><b>
                            <asp:Label ID="lblTitulo" runat="server" Text='<%# Eval("razon_social") %>'></asp:Label></b></h1>
                    </div>
                    <!-- END container -->
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <!-- BEGIN #page-header -->
        <div class="form-group row">
            <label class="col-form-label col-md-3">Comercios del usuario:</label>
            <div class="col-md-7">
                <asp:DropDownList ID="ddlCliente" DataSourceID="odsClienteUsuario" class="btn btn-light dropdown-toggle" DataTextField="nombre_cliente" DataValueField="id_cliente" AutoPostBack="true" OnSelectedIndexChanged="ddlCliente_SelectedIndexChanged" runat="server"></asp:DropDownList>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-form-label col-md-3">Foto de portada</label>
            <div class="col-md-7">
                <asp:FileUpload ID="fuImagen" class="btn btn-sm col-8 btn-default" runat="server" AllowMultiple="True" />
            </div>
        </div>
        <div class="form-group row">
            <label class="col-form-label col-md-3"></label>
            <div class="col-md-7">
                <asp:Button ID="btnGrabar" OnClick="btnGrabar_Click" class="btn btn-inverse btn-lg" runat="server" Text="Grabar" />
            </div>
        </div>
    </div>
</asp:Content>

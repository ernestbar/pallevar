<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="login_usuario.aspx.cs" Inherits="GoChasquiAdmin.login_usuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsCiudad" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaCiudadTodos">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblIdUsuario" runat="server" Text="0" Visible="false"></asp:Label>
    <div class="container align-content-center p-2">
        <!-- begin login -->
        <div class="login bg-white animated fadeInDown col-md-6 p-20 m-2">
            <!-- begin brand -->
            <div class="login-header">
                <div class="brand">
                    <span class="logo"></span><b>Inicio </b>de Sesion
					<small>si no estas registrado, registrate</small>
                </div>
                <div class="icon">
                    <i class="fa fa-lock"></i>
                </div>
                <asp:Label ID="lblAviso" runat="server" Text="" ForeColor="Blue"></asp:Label>
            </div>
            <!-- end brand -->
            <!-- begin login-content -->
            <div class="login-content align-content-md-5">
                <div class="form-group m-b-20">
                    <asp:TextBox ID="txtEmail" class="form-control form-control-lg inverse-mode" placeholder="Email Address" runat="server"></asp:TextBox>
                    <%--<input type="text" class="form-control form-control-lg inverse-mode" placeholder="Email Address"  />--%>
                </div>
                <div class="form-group m-b-20">
                    <asp:TextBox ID="txtPassword" class="form-control form-control-lg inverse-mode" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                    <%--<input type="password" class="form-control form-control-lg inverse-mode" placeholder="Password"  />--%>
                </div>
                <div class="form-group m-b-20">
                    <asp:DropDownList ID="ddlCiudad" OnDataBound="ddlCiudad_DataBound" class="form-control form-control-lg inverse-mode" DataSourceID="odsCiudad" DataTextField="nombre" DataValueField="id_ciudad" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCiudad_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="checkbox checkbox-css m-b-20">
                    <input type="checkbox" id="remember_checkbox" />
                    <label for="remember_checkbox">
                        Remember Me
                    </label>
                </div>

                <div class="form-group m-b-20">
                    <asp:Button ID="btnIngresar" CssClass="btn-sm btn-primary btn-block" OnClick="btnIngresar_Click" runat="server" Text="Ingresar" />
                </div>
                <div class="form-group">
                    <asp:Button ID="btnRegistrar" CssClass="btn-sm btn-primary btn-block" OnClick="btnRegistrar_Click" runat="server" Text="Registrarse" />
                </div>
                <div class="form-group m-b-20">
                    <asp:Button ID="btnReset" CssClass="btn-sm btn-danger btn-block" OnClick="btnReset_Click" runat="server" Text="Resetear contraseña" />
                </div>
                <div class="row form-group" style="margin-top: 40px;">
                    <div class="col-md-12">
                        <asp:Button CssClass="btn-sm btn-default btn-block" ID="GoogleBtn" CausesValidation="false" runat="server" Text="Login with Google account" OnClick="GoogleBtnClick"></asp:Button>
                        <asp:Button CssClass="btn-sm btn-default btn-block" ID="FacebookBtn" CausesValidation="false" runat="server" Text="Login with Facebook account" OnClick="FacebookBtnClick"></asp:Button>
                    </div>
                </div>
                <div class="row form-group hide">
                    <h3 class="col-md-12">User Info:
                    </h3>
                    <div class="col-md-12">
                        <asp:Literal ID="txtResponse" runat="server">External user info will populate here in json format.</asp:Literal>
                    </div>
                </div>
            </div>
            <!-- end login-content -->
        </div>
        <!-- end login -->
    </div>
</asp:Content>

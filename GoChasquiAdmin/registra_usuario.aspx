<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="registra_usuario.aspx.cs" Inherits="GoChasquiAdmin.registra_usuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }

        function validarDatos() {
            var txtNombre = document.getElementById('<%=txtNombre.ClientID %>');
            var txtPaterno = document.getElementById('<%=txtPaterno.ClientID %>');
            var txtMaterno = document.getElementById('<%=txtMaterno.ClientID %>');
            var txtCelular = document.getElementById('<%=txtCelular.ClientID %>');
            var ddlDia = document.getElementById('<%=ddlDia.ClientID %>');
            var ddlMes = document.getElementById('<%=ddlMes.ClientID %>');
            var ddlAnio = document.getElementById('<%=ddlAnio.ClientID %>');
            var txtEmail = document.getElementById('<%=txtEmail.ClientID %>');
            var email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
            var txtPassword = document.getElementById('<%=txtPassword.ClientID %>');

            if (txtNombre.value == "") {
                mostrarMensaje("Debe ingresar un nombre");
                txtNombre.focus();
                return false;
            }

            if (txtPaterno.value == "") {
                mostrarMensaje("Debe ingresar un apellido paterno");
                txtPaterno.focus();
                return false;
            }

            if (txtMaterno.value == "") {
                mostrarMensaje("Debe ingresar un apellido materno");
                txtMaterno.focus();
                return false;
            }

            if (txtCelular.value == "") {
                mostrarMensaje("Debe ingresar un número de celular");
                txtCelular.focus();
                return false;
            }

            if (ddlDia.value == "Dia" || ddlMes.value == "Mes" || ddlAnio.value == "Años") {
                mostrarMensaje("Debe seleccionar una fecha de nacimiento válida");
                ddlDia.focus();
                return false;
            }

            if (!email_regex.test(txtEmail.value)) {
                mostrarMensaje("Debe ingresar un correo electrónico válido");
                txtEmail.focus();
                return false;
            }

            if (txtPassword.value == "") {
                mostrarMensaje("Debe ingresar un password");
                txtPassword.focus();
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsCiudad" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaCiudadTodos">
        <SelectParameters>
            <%--<asp:Parameter Name="id_usuario" DefaultValue="0"  />--%>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblIdUsuario" runat="server" Text="0" Visible="false"></asp:Label>
    <div class="container">
        <!-- begin login -->
        <div class="login bg-white animated fadeInDown p-20 m-2">
            <!-- begin brand -->
            <div class="login-header">
                <div class="brand">
                    <span class="logo"></span><b>Registro </b>de usuario
					<small>rapido y sencillo</small>
                </div>
                <div class="icon">
                    <i class="fa fa-lock"></i>
                </div>
            </div>
            <!-- end brand -->
            <!-- begin login-content -->
            <div class="login-content align-content-md-5 w-auto">
                <div class="form-group m-b-20">
                    <asp:TextBox ID="txtNombre" class="form-control form-control-lg inverse-mode" placeholder="Nombre" runat="server" MaxLength="200"></asp:TextBox>
                </div>
                <div class="form-group m-b-20">
                    <asp:TextBox ID="txtPaterno" class="form-control form-control-lg inverse-mode" placeholder="Paterno" runat="server" MaxLength="200"></asp:TextBox>
                </div>
                <div class="form-group m-b-20">
                    <asp:TextBox ID="txtMaterno" class="form-control form-control-lg inverse-mode" placeholder="Materno" runat="server" MaxLength="200"></asp:TextBox>
                </div>
                <div class="form-group m-b-20">
                    <asp:TextBox ID="txtCelular" class="form-control form-control-lg inverse-mode" placeholder="Nro. Celular" runat="server" MaxLength="20"></asp:TextBox>
                </div>
                <div class="form-group m-b-20">
                    <label for="fecha_nac">
                        Fecha Nacimiento
                    </label>
                    <br />
                    <asp:DropDownList ID="ddlDia" class="btn-sm btn-light dropdown-toggle small" runat="server"></asp:DropDownList>
                    <asp:DropDownList ID="ddlMes" class="btn-sm btn-light btn-sm dropdown-toggle" runat="server"></asp:DropDownList>
                    <asp:DropDownList ID="ddlAnio" class="btn-sm btn-light btn-sm dropdown-toggle" runat="server"></asp:DropDownList>
                </div>

                <div class="form-group m-b-20">
                    <asp:TextBox ID="txtEmail" class="form-control form-control-lg inverse-mode" placeholder="Email Address" runat="server" MaxLength="500"></asp:TextBox>
                </div>
                <div class="form-group m-b-20">
                    <asp:TextBox ID="txtPassword" class="form-control form-control-lg inverse-mode" placeholder="Password" runat="server" MaxLength="500"></asp:TextBox>
                </div>
                <div class="form-group m-b-20">
                    <asp:DropDownList ID="ddlCiudad" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsCiudad" DataTextField="nombre" DataValueField="id_ciudad" runat="server"></asp:DropDownList>
                </div>
                <div class="checkbox checkbox-css m-b-20">
                    <input type="checkbox" id="remember_checkbox" />
                    <label for="remember_checkbox">
                        Remember Me
                    </label>
                </div>
                <div class="form-group m-b-20">
                    <asp:Button ID="btnRegistrar" CssClass="btn btn-primary btn-block" OnClick="btnRegistrar_Click" OnClientClick="javascript:return validarDatos();" runat="server" Text="Registrarse" />
                </div>
            </div>
            <!-- end login-content -->
        </div>
        <!-- end login -->
    </div>
</asp:Content>

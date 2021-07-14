<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="cliente_usuarios.aspx.cs" Inherits="GoChasquiAdmin.cliente_usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }

        function validarDatos() {
            var txtEmail = document.getElementById('<%=txtEmail.ClientID %>');
            var txtNombre = document.getElementById('<%=txtNombre.ClientID %>');
            var txtPaterno = document.getElementById('<%=txtPaterno.ClientID %>');
            var txtMaterno = document.getElementById('<%=txtMaterno.ClientID %>');
            var txtCelular = document.getElementById('<%=txtCelular.ClientID %>');
            var ddlDia = document.getElementById('<%=ddlDia.ClientID %>');
            var ddlMes = document.getElementById('<%=ddlMes.ClientID %>');
            var ddlAnio = document.getElementById('<%=ddlAnio.ClientID %>');
            var ddlDesdeDia = document.getElementById('<%=ddlDesdeDia.ClientID %>');
            var ddlDesdeMes = document.getElementById('<%=ddlDesdeMes.ClientID %>');
            var ddlDesdeAnio = document.getElementById('<%=ddlDesdeAnio.ClientID %>');
            var ddlHastaDia = document.getElementById('<%=ddlHastaDia.ClientID %>');
            var ddlHastaMes = document.getElementById('<%=ddlHastaMes.ClientID %>');
            var ddlHastaAnio = document.getElementById('<%=ddlHastaAnio.ClientID %>');
            var email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;

            if (!email_regex.test(txtEmail.value)) {
                mostrarMensaje("Debe ingresar un correo electrónico válido");
                txtEmail.focus();
                return false;
            }

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

            if (ddlDesdeDia.value == "Dia" || ddlDesdeMes.value == "Mes" || ddlDesdeAnio.value == "Años") {
                mostrarMensaje("Debe seleccionar una fecha desde válida");
                ddlDesdeDia.focus();
                return false;
            }

            if (ddlHastaDia.value == "Dia" || ddlHastaMes.value == "Mes" || ddlHastaAnio.value == "Años") {
                mostrarMensaje("Debe seleccionar una fecha hasta válida");
                ddlHastaDia.focus();
                return false;
            }

            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsClienteUsuario" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaClienteUsuarioXCliente">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdCliente" Name="Id_cliente" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsListaUsuarios" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaUsuarioTodos">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="Id_usuario" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCiudad" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaCiudadTodos">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblTipoOperacion" runat="server" Visible="false" Text=""></asp:Label>
    <asp:Label ID="lblIdCliente" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="lblIdUs" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="lblIdUsuario" runat="server" Text="" Visible="false"></asp:Label>
    <div id="content" class="content">
        <!-- begin page-header -->
        <h1 class="page-header">Usuarios <small>del Cliente</small></h1>
        <!-- end page-header -->
        <!-- begin panel -->
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <asp:Button ID="btnNuevo" class="btn-sm btn-success" OnClick="btnNuevo_Click" runat="server" Text="Nuevo Usuario" />
                <div class="panel panel-inverse">
                    <div class="table-responsive">
                        <!-- begin panel-body -->
                        <div class="panel-body">
                            <table id="data-table-default" class="table table-striped table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <td style="width: 5%; text-align: center;">ID</td>
                                        <td style="width: 60%; text-align: center;">NOMBRE</td>
                                        <td style="width: 5%; text-align: center;">ACTIVO</td>
                                        <td style="width: 10%; text-align: center;" data-orderable="false"></td>
                                        <td style="width: 10%; text-align: center;" data-orderable="false"></td>
                                        <td style="width: 10%; text-align: center;" data-orderable="false"></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="Repeater1" DataSourceID="odsClienteUsuario" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("id_usuario") %></td>
                                                <td><%# Eval("nombre_usuario") %></td>
                                                <td style="text-align: center; vertical-align: middle; padding: 2px">
                                                    <input type="checkbox" <%# Convert.ToBoolean(Eval("activo")) ? "checked" : "" %> onclick="return false;" onkeydown="return false;" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAsignar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_clienteusuario") %>' OnClick="btnAsignar_Click" runat="server" Text="Asignar/Quitar" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnRoles" class="btn-sm btn-info" CommandArgument='<%# Eval("id_clienteusuario") %>' OnClick="btnRoles_Click" runat="server" Text="Roles" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnEditar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_clienteusuario") %>' OnClick="btnEditar_Click" runat="server" Text="Editar" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </asp:View>
            <asp:View ID="View2" runat="server">
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Correo Electrónico:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtEmail" class="form-control m-b-5" runat="server" MaxLength="500"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Nombre:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtNombre" class="form-control m-b-5" runat="server" MaxLength="200"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Paterno:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtPaterno" class="form-control m-b-5" runat="server" MaxLength="200"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Materno:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtMaterno" class="form-control m-b-5" runat="server" MaxLength="200"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Celular:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtCelular" class="form-control m-b-5" runat="server" MaxLength="20"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Fecha Nacimiento:</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlDia" class="btn-sm btn-light dropdown-toggle small" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlMes" class="btn-sm btn-light btn-sm dropdown-toggle" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlAnio" class="btn-sm btn-light btn-sm dropdown-toggle" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Ciudad:</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlCiudad" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsCiudad" DataTextField="nombre" DataValueField="id_ciudad" runat="server"></asp:DropDownList>
                    </div>
                </div>


                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Fecha Desde:</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlDesdeDia" class="btn-sm btn-light dropdown-toggle small" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlDesdeMes" class="btn-sm btn-light btn-sm dropdown-toggle" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlDesdeAnio" class="btn-sm btn-light btn-sm dropdown-toggle" runat="server"></asp:DropDownList>
                    </div>
                </div>


                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Fecha Hasta:</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlHastaDia" class="btn-sm btn-light dropdown-toggle small" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlHastaMes" class="btn-sm btn-light btn-sm dropdown-toggle" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlHastaAnio" class="btn-sm btn-light btn-sm dropdown-toggle" runat="server"></asp:DropDownList>
                    </div>
                </div>

                <div class="form-group row m-b-15">
                    <asp:Button ID="btnRegresar" class="btn btn-primary" OnClick="btnRegresar_Click" runat="server" Text="Volver" />

                    <div class="col-md-9">
                        <asp:Button ID="btnGuardar" class="btn btn-primary" OnClick="btnGuardar_Click" OnClientClick="javascript:return validarDatos();" runat="server" Text="Guardar" />
                    </div>
                </div>
                <asp:Label ID="lblUrlFoto" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="lblActivo" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="lblTokenRedes" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="lblPass" runat="server" Text="" Visible="false"></asp:Label>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>

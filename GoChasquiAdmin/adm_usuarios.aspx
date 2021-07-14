<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="adm_usuarios.aspx.cs" Inherits="GoChasquiAdmin.adm_usuarios" %>

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

            return true;
        }

        function validarDatosPassword() {
            var txtNewClave = document.getElementById('<%=txtNewClave.ClientID %>');

            if (txtNewClave.value == "") {
                mostrarMensaje("Debe ingresar un nuevo password");
                txtNewClave.focus();
                return false;
            }

            return true;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsUsuarios" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaUsuarioTodos">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="1" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCiudad" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaCiudadTodos">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblClienteID" runat="server" Text="0" Visible="false"></asp:Label>
    <asp:Label ID="lblIdPedido" runat="server" Text="0" Visible="false"></asp:Label>
    <asp:Label ID="lblIdUsuario" runat="server" Text="1" Visible="false"></asp:Label>
    <div id="content" class="content">
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <!-- begin page-header -->
                <h1 class="page-header">Administrador <small>de usuarios</small></h1>
                <!-- end page-header -->
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <!-- begin panel-heading -->
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-redo"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">Usuarios registrados</h4>
                    </div>
                    <!-- end panel-heading -->

                    <div class="table-responsive">
                        <!-- begin panel-body -->
                        <div class="panel-body">
                            <table id="data-table-default" class="table table-striped table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <td style="width: 5%; text-align: center;">ID</td>
                                        <td style="width: 20%; text-align: center;">EMAIL</td>
                                        <td style="width: 30%; text-align: center;">NOMBRE</td>
                                        <td style="width: 5%; text-align: center;">ACTIVO</td>
                                        <td style="width: 10%" data-orderable="false"></td>
                                        <td style="width: 10%" data-orderable="false"></td>
                                        <td style="width: 10%" data-orderable="false"></td>
                                        <td style="width: 10%" data-orderable="false"></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="Repeater1" DataSourceID="odsUsuarios" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("id_usuario") %></td>
                                                <td><%# Eval("email") %></td>
                                                <td><%# Eval("nombre") %></td>
                                                <td style="text-align: center; vertical-align: middle; padding: 2px">
                                                    <input type="checkbox" <%# Convert.ToBoolean(Eval("activo")) ? "checked" : "" %> onclick="return false;" onkeydown="return false;" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnRoles" class="btn-sm btn-info" CommandArgument='<%# Eval("id_usuario") %>' OnClick="btnRoles_Click" runat="server" Text="Roles" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnResetPass" class="btn-sm btn-info" CommandArgument='<%# Eval("id_usuario") %>' OnClick="btnResetPass_Click" runat="server" Text="Cambiar Password" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnEstado" class="btn-sm btn-info" CommandArgument='<%# Eval("id_usuario") %>' OnClick="btnEstado_Click" runat="server" Text="Dar de baja/alta" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnEditar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_usuario") %>' OnClick="btnEditar_Click" runat="server" Text="Editar" />
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
                <div class="col-lg-6">
                    <asp:Label ID="lblIdUsrCP" runat="server" Text="" Visible="false"></asp:Label>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Nuevo password:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtNewClave" class="form-control m-b-5" runat="server" TextMode="Password" MaxLength="500"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <asp:Button ID="btnCancelar" class="btn btn-primary col-form-label col-md-3" OnClick="btnCancelar_Click" runat="server" Text="Volver" />

                        <div class="col-md-9">
                            <asp:Button ID="btnCambiar" class="btn btn-primary" OnClick="btnCambiar_Click" OnClientClick="javascript:return validarDatosPassword();" runat="server" Text="Cambiar" />
                        </div>
                    </div>
                </div>
            </asp:View>
            <asp:View ID="View3" runat="server">
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Correo Electrónico:</label>
                    <div class="col-md-3">
                        <asp:Label ID="lblEmail" class="form-control m-b-5" runat="server" Text=""></asp:Label>
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
                    <label class="col-form-label col-md-3">Ciudad:</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlCiudad" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsCiudad" DataTextField="nombre" DataValueField="id_ciudad" runat="server"></asp:DropDownList>
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
                    <asp:Button ID="btnCancelar2" class="btn btn-primary col-md-3" OnClick="btnCancelar2_Click" runat="server" Text="Volver" />

                    <div class="col-md-9">
                        <asp:Button ID="btnActualizar" class="btn btn-primary col-md-3" OnClick="btnActualizar_Click" OnClientClick="javascript:return validarDatos();" runat="server" Text="Actualizar" />
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

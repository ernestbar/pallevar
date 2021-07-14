<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="adm_drivers.aspx.cs" Inherits="GoChasquiAdmin.adm_drivers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }

        function abrirAdjunto(url) {
            window.open(url, '_target')
        }

        function validarDatosMotorizado() {
            var txtPlaca = document.getElementById('<%=txtPlaca.ClientID %>');
            var txtColor = document.getElementById('<%=txtColor.ClientID %>');
            var txtMarca = document.getElementById('<%=txtMarca.ClientID %>');
            var txtModelo = document.getElementById('<%=txtModelo.ClientID %>');

            if (txtPlaca.value == "") {
                mostrarMensaje("Debe ingresar una placa");
                txtPlaca.focus();
                return false;
            }

            if (txtColor.value == "") {
                mostrarMensaje("Debe ingresar un color");
                txtColor.focus();
                return false;
            }

            if (txtMarca.value == "") {
                mostrarMensaje("Debe ingresar una marca");
                txtMarca.focus();
                return false;
            }

            if (txtModelo.value == "") {
                mostrarMensaje("Debe ingresar un modelo");
                txtModelo.focus();
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

        function validarDatos() {
            var txtEmail = document.getElementById('<%=txtEmail.ClientID %>');
            var txtNombre = document.getElementById('<%=txtNombre.ClientID %>');
            var txtPaterno = document.getElementById('<%=txtPaterno.ClientID %>');
            var txtMaterno = document.getElementById('<%=txtMaterno.ClientID %>');
            var txtCelular = document.getElementById('<%=txtCelular.ClientID %>');
            var ddlDia = document.getElementById('<%=ddlDia.ClientID %>');
            var ddlMes = document.getElementById('<%=ddlMes.ClientID %>');
            var ddlAnio = document.getElementById('<%=ddlAnio.ClientID %>');
            var txtCI = document.getElementById('<%=txtCI.ClientID %>');
            var txtNroLicencia = document.getElementById('<%=txtNroLicencia.ClientID %>');
            var ddlVLDia = document.getElementById('<%=ddlVLDia.ClientID %>');
            var ddlVLMes = document.getElementById('<%=ddlVLMes.ClientID %>');
            var ddlVLAnio = document.getElementById('<%=ddlVLAnio.ClientID %>');
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

            if (txtCI.value == "") {
                mostrarMensaje("Debe ingresar un número de carnet de identidad");
                txtCI.focus();
                return false;
            }

            if (txtNroLicencia.value == "") {
                mostrarMensaje("Debe ingresar un número de licencia");
                txtNroLicencia.focus();
                return false;
            }

            if (ddlVLDia.value == "Dia" || ddlVLMes.value == "Mes" || ddlVLAnio.value == "Años") {
                mostrarMensaje("Debe seleccionar una fecha de vencimiento de licencia válida");
                ddlVLDia.focus();
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

        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgImagen.ClientID%>').prop('src', e.target.result)
                        .width(300)
                        .height(300);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsDrivers" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaDriverTodos">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuarioAudit" Name="Id_usuario" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTipoDriver" runat="server" SelectMethod="ListaTipoDriverTodos" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuarioAudit" Name="Id_usuario" PropertyName="Text" Type="Int32" DefaultValue="1" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCiudad" runat="server" SelectMethod="ListaCiudadTodos" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuarioAudit" Name="Id_usuario" PropertyName="Text" Type="Int32" DefaultValue="4" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTipoMotorizado" runat="server" SelectMethod="ListaTipoMotorizadoTodos" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuarioAudit" Name="Id_usuario" PropertyName="Text" Type="Int32" DefaultValue="2" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblIdDriver" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblIdUsuario" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblIdUsuarioAudit" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblIdMotorizado" runat="server" Visible="false"></asp:Label>
    <div id="content" class="content">
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <!-- begin page-header -->
                <h1 class="page-header">Administrador <small>de Drivers</small></h1>
                <!-- end page-header -->
                <div class="form-group row m-b-15">
                    <div class="col-md-9">
                        <asp:Button ID="btnNuevo" class="btn btn-primary col-form-label col-md-3" runat="server" OnClick="btnNuevo_Click" Text="Nuevo Driver" />
                    </div>
                </div>
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
                        <h4 class="panel-title">Drivers registrados</h4>
                    </div>
                    <!-- end panel-heading -->

                    <div class="table-responsive">
                        <!-- begin panel-body -->
                        <div class="panel-body">
                            <table id="data-table-default" class="table table-striped table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <td style="width: 5%; text-align: center;">ID</td>
                                        <td style="width: 10%; text-align: center;">NOMBRE</td>
                                        <td style="width: 10%; text-align: center;">PATERNO</td>
                                        <td style="width: 10%; text-align: center;">MATERNO</td>
                                        <td style="width: 10%; text-align: center;">CI</td>
                                        <td style="width: 10%; text-align: center;">ESTADO</td>
                                        <td style="width: 10%; text-align: center;">NRO.LICENCIA</td>
                                        <td style="width: 5%; text-align: center;">GENERO</td>
                                        <td style="width: 5%; text-align: center;">DISPONIBLE</td>
                                        <td style="width: 5%" data-orderable="false"></td>
                                        <td style="width: 5%" data-orderable="false"></td>
                                        <td style="width: 5%" data-orderable="false"></td>
                                        <td style="width: 5%" data-orderable="false"></td>
                                        <td style="width: 5%" data-orderable="false"></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="Repeater1" DataSourceID="odsDrivers" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("id_driver") %></td>
                                                <td><%# Eval("nombre") %></td>
                                                <td><%# Eval("paterno") %></td>
                                                <td><%# Eval("materno") %></td>
                                                <td><%# Eval("ci") %></td>
                                                <td style="text-align: center; vertical-align: middle; padding: 2px">
                                                    <input type="checkbox" <%# Convert.ToBoolean(Eval("activo")) ? "checked" : "" %> onclick="return false;" onkeydown="return false;" />
                                                </td>
                                                <td><%# Eval("nro_licencia") %></td>
                                                <td><%# Convert.ToString(Eval("genero")) == "M" ? "Maculino" : "Femenino" %></td>
                                                <td style="text-align: center; vertical-align: middle; padding: 2px">
                                                    <input type="checkbox" <%# Convert.ToBoolean(Eval("disponible")) ? "checked" : "" %> onclick="return false;" onkeydown="return false;" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnDocumento" class="btn-sm btn-info" CommandArgument='<%# Eval("id_driver") %>' OnClick="btnDocumento_Click" runat="server" Text="Documentos" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnMotorizado" class="btn-sm btn-info" CommandArgument='<%# Eval("id_driver") %>' OnClick="btnMotorizado_Click" runat="server" Text="Motorizado" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnResetPass" class="btn-sm btn-info" CommandArgument='<%# Eval("id_driver") %>' OnClick="btnResetPass_Click" runat="server" Text="Cambiar Clave" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnEstado" class="btn-sm btn-info" CommandArgument='<%# Eval("id_driver") %>' OnClick="btnEstado_Click" runat="server" Text="Dar baja/alta" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnEditar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_driver") %>' OnClick="btnEditar_Click" runat="server" Text="Editar" />
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
                    <label class="col-form-label col-md-3">Placa:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtPlaca" class="form-control m-b-5" runat="server" MaxLength="20"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Tipo:</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlTipoMotorizado" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsTipoMotorizado" DataTextField="nombre" DataValueField="id_tipomotorizado" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Color:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtColor" class="form-control m-b-5" runat="server" MaxLength="100"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Marca:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtMarca" class="form-control m-b-5" runat="server" MaxLength="200"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Modelo:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtModelo" class="form-control m-b-5" runat="server" MaxLength="200"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Seleccionar Imagen:</label>
                    <div class="col-md-3">
                        <asp:FileUpload ID="fuArchivo" class="form-control m-b-5" runat="server" onchange="ImagePreview(this);"/>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Imagen:</label>
                    <div class="col-md-3">
                        <asp:Image ID="imgImagen" runat="server" Width="300" Height="300" />
                        <asp:Button ID="btnVer" class="btn btn-green col-md-3" runat="server" Text="Ver" OnClick="btnVer_Click" />
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <asp:Button ID="btnCancelarM" class="btn btn-primary col-md-3" OnClick="btnCancelarM_Click" runat="server" Text="Volver" />
                    <div class="col-md-9">
                        <asp:Button ID="btnGuardarM" class="btn btn-primary col-md-3" OnClick="btnGuardarM_Click" OnClientClick="javascript:return validarDatosMotorizado();" runat="server" Text="Guardar" />
                    </div>
                </div>
            </asp:View>

            <asp:View ID="View3" runat="server">
                <div class="col-lg-6">
                    <asp:Label ID="lblIdUsrCP" runat="server" Text="" Visible="false"></asp:Label>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Nuevo password:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtNewClave" class="form-control m-b-5" runat="server" MaxLength="500" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <asp:Button ID="btnCancelarCP" class="btn btn-primary col-form-label col-md-3" OnClick="btnCancelarCP_Click" runat="server" Text="Volver" />

                        <div class="col-md-9">
                            <asp:Button ID="btnCambiarCP" class="btn btn-primary" OnClick="btnCambiarCP_Click" OnClientClick="javascript:return validarDatosPassword();" runat="server" Text="Cambiar" />
                        </div>
                    </div>
                </div>
            </asp:View>

            <asp:View ID="View4" runat="server">
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
                    <label class="col-form-label col-md-3">Tipo de Driver:</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlTipoDriver" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsTipoDriver" DataTextField="nombre" DataValueField="id_tipodriver" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Carnet Identidad:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtCI" class="form-control m-b-5" runat="server" MaxLength="20"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Nro. de Licencia:</label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtNroLicencia" class="form-control m-b-5" runat="server" MaxLength="20"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Fecha Vencimiento Licencia:</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlVLDia" class="btn-sm btn-light dropdown-toggle small" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlVLMes" class="btn-sm btn-light btn-sm dropdown-toggle" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlVLAnio" class="btn-sm btn-light btn-sm dropdown-toggle" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Género:</label>
                    <div class="col-md-3">
                        <asp:RadioButton ID="rbtnMasculino" runat="server" Text="Masculino" GroupName="genero" />
                        <asp:RadioButton ID="rbtnFemenino" runat="server" Text="Femenino" GroupName="genero" />
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <asp:Button ID="btnCancelar" class="btn btn-primary col-md-3" OnClick="btnCancelar_Click" runat="server" Text="Volver" />

                    <div class="col-md-9">
                        <asp:Button ID="btnGuardar" class="btn btn-primary col-md-3" OnClick="btnGuardar_Click" OnClientClick="javascript:return validarDatos();" runat="server" Text="Guardar" />
                    </div>
                </div>
                <asp:Label ID="lblUrlFoto" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="lblActivo" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="lblTokenRedes" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="lblPass" runat="server" Text="" Visible="true"></asp:Label>
            </asp:View>
        </asp:MultiView>

    </div>
</asp:Content>

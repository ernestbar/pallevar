<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="adm_clientes.aspx.cs" Inherits="GoChasquiAdmin.adm_clientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje)
        {
            alert(mensaje);
        }

        function validarDatos() {
            var txtRazonSocial = document.getElementById('<%=txtRazonSocial.ClientID %>');
            var txtNit = document.getElementById('<%=txtNit.ClientID %>');
            var txtNombreCon = document.getElementById('<%=txtNombreCon.ClientID %>');
            var txtPaternoCon = document.getElementById('<%=txtPaternoCon.ClientID %>');
            var txtMaternoCon = document.getElementById('<%=txtMaternoCon.ClientID %>');
            var txtDireccionCon = document.getElementById('<%=txtDireccionCon.ClientID %>');
            var txtTel1Con = document.getElementById('<%=txtTel1Con.ClientID %>');
            var txtTel2Con = document.getElementById('<%=txtTel2Con.ClientID %>');
            var txtCel1Con = document.getElementById('<%=txtCel1Con.ClientID %>');
            var txtCel2Con = document.getElementById('<%=txtCel2Con.ClientID %>');

            if (txtRazonSocial.value == "") {
                mostrarMensaje("Debe ingresar una razón social");
                txtRazonSocial.focus();
                return false;
            }

            if (txtNit.value == "") {
                mostrarMensaje("Debe ingresar un NIT");
                txtNit.focus();
                return false;
            }

            if (txtNombreCon.value == "") {
                mostrarMensaje("Debe ingresar un nombre de contacto");
                txtNombreCon.focus();
                return false;
            }

            if (txtPaternoCon.value == "") {
                mostrarMensaje("Debe ingresar un apellido paterno de contacto");
                txtPaternoCon.focus();
                return false;
            }

            if (txtDireccionCon.value == "") {
                mostrarMensaje("Debe ingresar una dirección");
                txtDireccionCon.focus();
                return false;
            }

            if (txtTel1Con.value == "") {
                mostrarMensaje("Debe ingresar un número de teléfono");
                txtTel1Con.focus();
                return false;
            }

            if (txtCel1Con.value == "") {
                mostrarMensaje("Debe ingresar un número de celular");
                txtCel1Con.focus();
                return false;
            }

            return true;
        }

        window.onload = mostrarUbicacion();

        function mostrarUbicacion() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(obtenerUbicacion);
            }
            else {
                alert("La característica de Geo Localización no está disponible en este navegador");
            }
        }

        function mostrarUbicacionActual() {
            document.getElementById('<%= lblLatitud.ClientID %>').value = "";
            document.getElementById('<%= lblLongitud.ClientID %>').value = "";
            document.getElementById('<%= hfLatitud.ClientID %>').value = "";
            document.getElementById('<%= hfLongitud.ClientID %>').value = "";
            mostrarUbicacion();
        }

        function obtenerUbicacion(position) {
            // Obtener posición actual
            var latitud = 0;
            var longitud = 0;

            // Obtener datos de controles
            var hfLatitud = document.getElementById('<%=hfLatitud.ClientID%>');
            var hfLongitud = document.getElementById('<%=hfLongitud.ClientID%>');
            var lblLatitud = document.getElementById('<%=lblLatitud.ClientID%>');
            var lblLongitud = document.getElementById('<%=lblLongitud.ClientID%>');

            if (hfLatitud == null) {
                return;
            }

            if (hfLongitud == null) {
                return;
            }

            // Si no hay latitud o longitud registrada tomar la actual
            if (hfLatitud.value == "" && hfLongitud.value == "") {
                latitud = position.coords.latitude;
                longitud = position.coords.longitude;

                lblLatitud.innerHTML = latitud;
                lblLongitud.innerHTML = longitud;
                hfLatitud.innerHTML = latitud;
                hfLongitud.innerHTML = longitud;

                document.getElementById('<%= lblLatitud.ClientID %>').value = latitud;
                document.getElementById('<%= lblLongitud.ClientID %>').value = longitud;
                document.getElementById('<%= hfLatitud.ClientID %>').value = latitud;
                document.getElementById('<%= hfLongitud.ClientID %>').value = longitud;
            }
            else {
                latitud = hfLatitud.value;
                longitud = hfLongitud.value;
                lblLatitud.innerHTML = latitud;
                lblLongitud.innerHTML = longitud;

                document.getElementById('<%= lblLatitud.ClientID %>').value = latitud;
                document.getElementById('<%= lblLongitud.ClientID %>').value = longitud;
            }

            // Inicializar el Mapa
            var LatLng = new google.maps.LatLng(latitud, longitud);
            var mapOpciones = {
                center: LatLng,
                zoom: 13,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            var mapa = new google.maps.Map(document.getElementById("mapa"), mapOpciones);

            var currentMarkerPos;

            var marker = new google.maps.Marker({
                position: LatLng,
                map: mapa,
                title: "Mi ubicación",
                draggable: true
            });

            google.maps.event.addListener(marker, "dragstart",
                function (event) {
                    currentMarkerPos = event.latLng;
                }
            );

            google.maps.event.addListener(marker, "dragend",
                function (event) {
                    var latitud = event.latLng.lat();
                    var longitud = event.latLng.lng();

                    var lblLatitud = document.getElementById('<%=lblLatitud.ClientID%>');
                    lblLatitud.innerHTML = latitud;
                    var lblLongitud = document.getElementById('<%=lblLongitud.ClientID%>');
                    lblLongitud.innerHTML = longitud;

                    var hfLatitud = document.getElementById('<%=hfLatitud.ClientID%>');
                    hfLatitud.innerHTML = latitud;
                    var hfLongitud = document.getElementById('<%=hfLongitud.ClientID%>');
                    hfLongitud.innerHTML = longitud;

                    document.getElementById('<%= lblLatitud.ClientID %>').value = latitud;
                    document.getElementById('<%= lblLongitud.ClientID %>').value = longitud;
                    document.getElementById('<%= hfLatitud.ClientID %>').value = latitud;
                    document.getElementById('<%= hfLongitud.ClientID %>').value = longitud;
                }
            );
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsClientes" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaClienteTodos">
        <SelectParameters>
            <%--<asp:Parameter Name="id_cliente" DefaultValue="2" />--%>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="1" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTipoNegocio" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaTipoNegocioTodos">
        <SelectParameters>
            <%--<asp:Parameter Name="id_usuario" DefaultValue="0"/>--%>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCiudad" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaCiudadTodos">
        <SelectParameters>
            <%--<asp:Parameter Name="id_usuario" DefaultValue="0"  />--%>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="hfLatitud" runat="server" EnableViewState="true" />
    <asp:HiddenField ID="hfLongitud" runat="server" EnableViewState="true" />
    <asp:Label ID="lblIdDireccion" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="lblIdPedido" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="lblIdUsuario" runat="server" Text="1" Visible="false"></asp:Label>
    <div id="content" class="content">
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <!-- begin page-header -->
                <h1 class="page-header">Administrador <small>de clientes</small></h1>
                <!-- end page-header -->
                <div class="form-group row m-b-15">
                    <div class="col-md-9">
                        <asp:Button ID="btnNuevo" class="btn btn-primary col-form-label col-md-3" runat="server" OnClick="btnNuevo_Click" Text="Nuevo cliente" />
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
                        <h4 class="panel-title">Usuarios registrados</h4>
                    </div>
                    <!-- end panel-heading -->

                    <div class="table-responsive">
                        <!-- begin panel-body -->
                        <div class="panel-body">
                            <table id="data-table-default" class="table table-striped table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <td style="width: 10%; text-align: center;">ID</td>
                                        <td style="width: 30%; text-align: center;">RAZON SOCIAL</td>
                                        <td style="width: 20%; text-align: center;">NIT</td>
                                        <td style="width: 10%; text-align: center;">ACTIVO</td>
                                        <td style="width: 10%" data-orderable="false"></td>
                                        <td style="width: 10%" data-orderable="false"></td>
                                        <td style="width: 10%" data-orderable="false"></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="Repeater1" DataSourceID="odsClientes" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("id_cliente") %></td>
                                                <td><%# Eval("razon_social") %></td>
                                                <td><%# Eval("nit") %></td>
                                                <td style="text-align: center; vertical-align: middle; padding: 2px">
                                                    <input type="checkbox" <%# Convert.ToBoolean(Eval("activo")) ? "checked" : "" %> onclick="return false;" onkeydown="return false;" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnUsuarios" class="btn-sm btn-info" CommandArgument='<%# Eval("id_cliente") %>' OnClick="btnUsuarios_Click" runat="server" Text="Usuarios" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnEstado" class="btn-sm btn-info" CommandArgument='<%# Eval("id_cliente") %>' OnClick="btnEstado_Click" runat="server" Text="Dar de baja/alta" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnEditar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_cliente") %>' OnClick="btnEditar_Click" runat="server" Text="Editar" />
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
                <div class="col-lg-10">
                    <asp:Label ID="lblIdCliente" runat="server" Text="" Visible="false"></asp:Label>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Razon social:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtRazonSocial" class="form-control m-b-5" runat="server" MaxLength="500"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">NIT:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtNit" class="form-control m-b-5" runat="server" MaxLength="100"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Nombre contacto:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtNombreCon" class="form-control m-b-5" runat="server" MaxLength="200"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Paterno contacto:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtPaternoCon" class="form-control m-b-5" runat="server" MaxLength="200"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Materno contacto:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtMaternoCon" class="form-control m-b-5" runat="server" MaxLength="200"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Telefono 1:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtTel1Con" class="form-control m-b-5" runat="server" MaxLength="10"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Telefono 2:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtTel2Con" class="form-control m-b-5" runat="server" MaxLength="10"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Celular 1:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtCel1Con" class="form-control m-b-5" runat="server" MaxLength="10"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Celular 2:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtCel2Con" class="form-control m-b-5" runat="server" MaxLength="10"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Direccion:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtDireccionCon" class="form-control m-b-5" runat="server" MaxLength="500"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Ciudad:</label>
                        <div class="col-md-3">
                            <asp:DropDownList ID="ddlCiudad" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsCiudad" DataTextField="nombre" DataValueField="id_ciudad" runat="server"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Tipo negocio:</label>
                        <div class="col-md-3">
                            <asp:DropDownList ID="ddlTipoNegocio" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsTipoNegocio" DataTextField="nombre" DataValueField="id_tiponegocio" runat="server"></asp:DropDownList>

                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">
                            Coordenadas:<br />
                            <input type="button" class="btn-sm btn-success btn-block" value="Buscar mi ubicacion" onclick="javascript: mostrarUbicacionActual()" /></label>
                        <div class="col-md-6">
                            <div id="mapa" style="width: 100%; height: 350px">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Latitud <span class="text-danger">*</span></label>
                        <div class="col-md-7">
                            <asp:Label ID="lblLatitud" runat="server" Text="Label"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Longitud <span class="text-danger">*</span></label>
                        <div class="col-md-7">
                            <asp:Label ID="lblLongitud" runat="server" Text="Label"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Foto portada:</label>
                        <div class="col-md-3">
                            <asp:FileUpload ID="fuImagen" class="form-control m-b-5" runat="server" AllowMultiple="True" />

                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <asp:Button ID="btnCancelar" class="btn btn-primary col-form-label col-md-3" OnClick="btnCancelar_Click" runat="server" Text="Volver" />

                        <div class="col-md-9">
                            <asp:Button ID="btnGuardarCliente" class="btn btn-primary" OnClick="btnGuardarCliente_Click" OnClientClick="javascript:return validarDatos();" runat="server" Text="Guardar" />
                        </div>
                    </div>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>

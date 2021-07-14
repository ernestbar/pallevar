<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="abmProducto.aspx.cs" Inherits="GoChasquiAdmin.abmProducto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }

        function validarDatos() {
            var txtNombre = document.getElementById('<%=txtNombre.ClientID %>');
            var txtPrecio = document.getElementById('<%=txtPrecio.ClientID %>');
            var txtCantidad = document.getElementById('<%=txtCantidad.ClientID %>');
            var txtDescripcion = document.getElementById('<%=txtDescripcion.ClientID %>');

            if (txtNombre.value == "") {
                mostrarMensaje("Debe ingresar un nombre");
                txtNombre.focus();
                return false;
            }

            if (!$.isNumeric(txtPrecio.value)) {
                mostrarMensaje("Debe ingresar un precio válido");
                txtPrecio.focus();
                return false;
            }

            if (!$.isNumeric(txtCantidad.value)) {
                mostrarMensaje("Debe ingresar una cantidad válida");
                txtCantidad.focus();
                return false;
            }

            if (txtDescripcion.value == "") {
                mostrarMensaje("Debe ingresar una descripción");
                txtDescripcion.focus();
                return false;
            }

            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblClienteID" runat="server" Text="2" Visible="false"></asp:Label>
    <asp:ObjectDataSource ID="odsProducto" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaProductoXCliente">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblClienteID" Name="id_cliente" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCliente" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaClienteIndividual">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblClienteID" Name="id_cliente" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTipoProducto" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaTipoProductoTodos">
        <SelectParameters>
            <asp:Parameter Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsClienteUsuario" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaClienteUsuarioXUsuario">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblTipoOperacion" runat="server" Visible="false" Text=""></asp:Label>
    <asp:Label ID="lblIdProducto" runat="server" Visible="false" Text=""></asp:Label>
    <asp:Label ID="lblIdUsuario" runat="server" Text="0" Visible="false"></asp:Label>
    <!-- BEGIN #page-header -->
    <div id="page-header" class="section-container page-header-container bg-black">
        <asp:Repeater ID="Repeater2" DataSourceID="odsCliente" runat="server">
            <ItemTemplate>
                <!-- BEGIN page-header-cover -->
                <div class="page-header-cover">
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

    <!-- BEGIN search-results -->
    <div id="search-results" class="section-container bg-silver">
        <!-- BEGIN container -->
        <div class="container">
            <!-- BEGIN search-container -->
            <div class="search-container">
                <!-- BEGIN search-content -->
                <div class="search-content">
                    <!-- BEGIN search-toolbar -->
                    <div class="search-toolbar">
                        <!-- BEGIN row -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Comercios de usuario:</label>
                                    <asp:DropDownList ID="ddlCliente" DataSourceID="odsClienteUsuario" class="btn btn-light dropdown-toggle" OnSelectedIndexChanged="ddlCliente_SelectedIndexChanged" DataTextField="nombre_cliente" DataValueField="id_cliente" runat="server" AutoPostBack="True"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <!-- END row -->
                    </div>
                    <!-- END search-toolbar -->
                    <!-- BEGIN search-item-container -->
                    <div class="search-item-container">
                        <!-- BEGIN item-row -->
                        <div class="item-row">
                            <!-- BEGIN item -->
                            <asp:Repeater ID="Repeater1" DataSourceID="odsProducto" runat="server">
                                <ItemTemplate>
                                    <div class="item item-thumbnail">
                                        <a href="home.aspx?=<%# Eval("id_producto") %>" class="item-image">
                                            <img src='<%# Eval("ruta_imagen") %>' alt="" />
                                        </a>
                                        <div class="item-info">
                                            <h4 class="item-title">
                                                <asp:Label ID="lblTitulo" runat="server" Text='<%# Eval("nombre") %>'></asp:Label>
                                            </h4>
                                            <p class="item-desc">
                                                <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("descripcion") %>'></asp:Label></p>
                                            <div class="item-price">
                                                <asp:Label ID="lblPrecio" runat="server" Text='<%# Eval("precio_unidad") %>'></asp:Label>
                                            </div>
                                            <asp:Button ID="btnEditar" class="btn-sm btn-success btn-block" CommandArgument='<%# Eval("id_producto") %>' OnClick="btnEditar_Click" runat="server" Text="EDITAR" />
                                            <asp:Button ID="btnEmilinar" class="btn-sm btn-success btn-block" CommandArgument='<%# Eval("id_producto") %>' OnClientClick="return confirm('Seguro que desea eliminar este item?');" OnClick="btnEmilinar_Click" runat="server" Text="ELIMINAR" />
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <!-- END item -->
                        </div>
                        <!-- END item-row -->
                    </div>
                </div>
                <!-- END search-content -->
                <!-- BEGIN search-sidebar -->
                <div class="search-sidebar">
                    <h4 class="title">Nuevo item</h4>

                    <div class="form-group">
                        <label class="control-label">Nombre:</label>
                        <asp:TextBox ID="txtNombre" class="form-control input-sm" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Precio:</label>
                        <asp:TextBox ID="txtPrecio" class="form-control input-sm" value="0" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Cantidad</label>
                        <div class="row row-space-0">
                            <div class="col-md-5">
                                <asp:TextBox ID="txtCantidad" class="form-control input-sm" value="0" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Breve descripcion:</label>
                        <asp:TextBox ID="txtDescripcion" TextMode="MultiLine" class="form-control input-sm" runat="server"></asp:TextBox>

                    </div>
                    <div class="form-group">
                        <label class="control-label">Tipo de producto:</label>
                        <asp:DropDownList ID="ddlTipoProducto" class="btn btn-light dropdown-toggle" DataSourceID="odsTipoProducto" DataTextField="nombre" DataValueField="id_tipoproducto" runat="server"></asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Foto del producto:</label>
                        <asp:FileUpload ID="fuImagen" class="btn btn-sm col-8 btn-default" runat="server" AllowMultiple="True" />
                    </div>
                    <div class="form-group">
                        <asp:Button ID="btnGrabar" class="btn btn-success" OnClick="btnGrabar_Click" OnClientClick="javascript:return validarDatos();" runat="server" Text="Grabar" />
                    </div>
                    <div class="form-group">
                        <asp:Button ID="btnNuevo" class="btn btn-success" OnClick="btnNuevo_Click" runat="server" Text="Nuevo" />
                    </div>
                </div>
                <!-- END search-sidebar -->
            </div>
            <!-- END search-container -->
        </div>
        <!-- END container -->
    </div>
    <!-- END search-results -->
</asp:Content>

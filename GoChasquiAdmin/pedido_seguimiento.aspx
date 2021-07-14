<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="pedido_seguimiento.aspx.cs" Inherits="GoChasquiAdmin.pedido_seguimiento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }

        function mostrarConfirmacion() {
            if (!confirm("¿Esta seguro de cancelar el pedido?")) {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsPedidos" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaPedidoXUsuario">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsPedidoDetalle" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaPedidoDetalleXPedido">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdPedido" Name="id_pedido" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsPedidoRuta" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaRutaXPedido">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdPedido" Name="id_pedido" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblClienteID" runat="server" Text="0" Visible="false"></asp:Label>
    <asp:Label ID="lblIdPedido" runat="server" Text="0" Visible="false"></asp:Label>
    <asp:Label ID="lblIdUsuario" runat="server" Text="0" Visible="false"></asp:Label>
    <div class="container">
        <!-- BEGIN #page-header -->
        <div id="page-header" class="section-container page-header-container bg-black">
            <!-- BEGIN container -->
            <div class="container">
                <h1 class="page-header"><b>REALICE EL SEGUIMIMENTO DE SUS PEDIDOS</b></h1>
            </div>
        </div>
        <!-- BEGIN checkout-header -->
        <div class="container-fluid">
            <asp:Label ID="lblAviso" runat="server" Text=""></asp:Label>
        </div>
        <!-- END checkout-header -->
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <div class="table-responsive2">
                    <table class="table table-payment-summary">
                        <thead>
                            <tr>
                                <td>TIPO</td>
                                <td>FECHA</td>
                                <td>MONTO</td>
                                <td>ESTADO</td>
                                <td>DETALLE</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptrPedidos" DataSourceID="odsPedidos" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("tipo_servicio") %></td>
                                        <td><%# Eval("fecha_pedido") %></td>
                                        <td><%# Eval("monto") %></td>
                                        <td><%# Eval("estado") %></td>
                                        <td>
                                            <asp:Button ID="btnDetalles" class="btn-sm btn-success btn-block" CommandArgument='<%# Eval("id_pedido") %>' OnClick="btnDetalles_Click" runat="server" Text="Detalles" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </asp:View>

            <asp:View ID="View2" runat="server">
                <div class="panel-body">
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Origen:</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblTranspOrigen" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Destino:</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblTranspDestino" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Costo (Bs.):</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblTranspCosto" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Distancia Aproximada (Km.):</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblTranspDistancia" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="row">
                        <div class="form-group row m-b-15">
                            <div class="col-md-4">
                                <asp:Button ID="btnVolverTransporte" class="btn-sm btn-success btn-block" OnClick="btnVolver_Click" runat="server" Text="Volver" Width="100px" />
                            </div>
                            <div class="col-md-4">
                                <asp:Button ID="btnPedidoPropuesta" class="btn-sm btn-success btn-block" OnClick="btnPedidoPropuesta_Click" runat="server" Text="Propuestas" Width="100px" />
                            </div>
                            <div class="col-md-4">
                                <asp:Button ID="btnCancelarTransporte" class="btn-sm btn-success btn-block" OnClick="btnCancelarTransporte_Click" OnClientClick="javascript:return mostrarConfirmacion();" runat="server" Text="Cancelar" Width="100px" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:View>

            <asp:View ID="View3" runat="server">
                <div class="table-responsive2">
                    <table class="table table-payment-summary">
                        <thead>
                            <tr>
                                <td>PRODUCTO</td>
                                <td>UNIDADES</td>
                                <td>MONTO</td>
                                <td>DETALLE EXTRA</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="Repeater3" DataSourceID="odsPedidoDetalle" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("producto") %></td>
                                        <td><%# Eval("unidades") %></td>
                                        <td><%# Eval("monto") %></td>
                                        <td><%# Eval("detalle_extra") %></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>

                        </tbody>
                    </table>

                    <div class="panel-body">
                        <div class="form-group row m-b-15">
                            <label class="col-form-label col-md-3">Total Productos:</label>
                            <div class="col-md-3">
                                <asp:Label ID="lblTotalProd" class="form-control m-b-5" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group row m-b-15">
                            <label class="col-form-label col-md-3">Costo Delivery (Bs.):</label>
                            <div class="col-md-3">
                                <asp:Label ID="lblCostoDelivery" class="form-control m-b-5" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group row m-b-15">
                            <label class="col-form-label col-md-3">Total a Pagar (Bs.):</label>
                            <div class="col-md-3">
                                <asp:Label ID="lblTotalPagar" class="form-control m-b-5" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="row">
                        <div class="form-group row m-b-15">
                            <div class="col-md-6">
                                <asp:Button ID="btnVolver" class="btn-sm btn-success btn-block" OnClick="btnVolver_Click" runat="server" Text="Volver" />
                            </div>
                            <div class="col-md-6">
                                <asp:Button ID="btnCancelar" class="btn-sm btn-success btn-block" OnClick="btnCancelar_Click" OnClientClick="javascript:return mostrarConfirmacion();" runat="server" Text="Cancelar" Width="100px" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:View>

            <asp:View ID="View4" runat="server">
                <div class="panel-body">
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Origen:</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblEnvOrigen" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Destino:</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblEnvDestino" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Costo (Bs.):</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblEnvCosto" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Distancia Aproximada (Km.):</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblEnvDistancia" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Nombre Destinatario:</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblEnvNombreDestinatario" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Celular Destinatario:</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblEnvCelularDestinatario" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Contenido:</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblEnvContenido" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Alto del Paquete (Cm.):</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblEnvAlto" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Ancho del Paquete (Cm.):</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblEnvAncho" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Recomendaciones:</label>
                        <div class="col-md-3">
                            <asp:Label ID="lblEnvRecomendaciones" class="form-control m-b-5" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="row">
                        <div class="form-group row m-b-15">
                            <div class="col-md-6">
                                <asp:Button ID="btnVolverEnvio" class="btn-sm btn-success btn-block" OnClick="btnVolverEnvio_Click" runat="server" Text="Volver" />
                            </div>
                            <div class="col-md-6">
                                <asp:Button ID="btnCancelarEnvio" class="btn-sm btn-success btn-block" OnClick="btnCancelarEnvio_Click" OnClientClick="javascript:return mostrarConfirmacion();" runat="server" Text="Cancelar" Width="100px" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>

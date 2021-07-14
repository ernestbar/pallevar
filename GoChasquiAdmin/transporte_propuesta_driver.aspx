<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="transporte_propuesta_driver.aspx.cs" Inherits="GoChasquiAdmin.transporte_propuesta_driver" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsPedidoPropuesta" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaPedidoPropuestaXPedido">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdPedido" Name="Id_pedido" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblIdPedido" runat="server" Text="" Visible="false"></asp:Label>

    <div class="container">
        <!-- BEGIN #page-header -->
        <div id="page-header" class="section-container page-header-container bg-black">
            <!-- BEGIN container -->
            <div class="container">
                <h4 class="page-header"><b>PROPUESTAS DE DRIVERS</b></h4>
            </div>
        </div>
        <!-- BEGIN checkout-header -->
        <div class="container-fluid">
            <asp:Label ID="lblAviso" runat="server" Text=""></asp:Label>
        </div>
        <!-- END checkout-header -->

        <div class="table-responsive">
            <!-- begin panel-body -->
            <div class="panel-body">
                <asp:Button ID="btnActualizar" runat="server" OnClick="btnActualizar_Click" CssClass="btn btn-primary" Width="120px" Text="Actualizar" />
                <table id="data-table-default" class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <td data-orderable="false">ID</td>
                            <td data-orderable="false">IMAGEN</td>
                            <td>DRIVER</td>
                            <td>COSTO</td>
                            <td>MOTORIZADO</td>
                            <td data-orderable="false"></td>
                            <td data-orderable="false"></td>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptrPedidoPropuesta" DataSourceID="odsPedidoPropuesta" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td><%# Eval("id_pedidopropuesta") %></td>
                                    <td class="with-img">
                                        <img src='<%# Eval("url_motorizado") %>' class="img-rounded height-30" />
                                    </td>
                                    <td><%# Eval("nombre_driver") %></td>
                                    <td><%# Eval("monto") %></td>
                                    <td><%# Eval("motorizado") %></td>
                                    <td>
                                        <asp:Button ID="btnAceptar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_pedidopropuesta") %>' OnClick="btnAceptar_Click" runat="server" Text="Aceptar" />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnRechazar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_pedidopropuesta") %>' OnClick="btnRechazar_Click" runat="server" Text="Rechazar" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

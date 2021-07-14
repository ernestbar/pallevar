<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="comercios.aspx.cs" Inherits="GoChasquiAdmin.comercios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblIdTipoNegocio" runat="server" Text="2" Visible="false"></asp:Label>
    <asp:Label ID="lblIdCiudad" runat="server" Text="4" Visible="false"></asp:Label>
    <asp:ObjectDataSource ID="odsClientes" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaClienteXTipoNegocio">
        <SelectParameters>
            <%--<asp:Parameter Name="id_cliente" DefaultValue="2" />--%>
            <asp:ControlParameter ControlID="lblIdTipoNegocio" Name="Id_negocio" DefaultValue="" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblIdCiudad" DefaultValue="4" Name="Id_ciudad" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <!-- begin #work -->
    <div id="work" class="content" data-scrollview="true">
        <!-- begin container -->
        <div class="container" data-animation="true" data-animation-type="fadeInDown">
            <h2 class="content-title">NUESTROS CLIENTES</h2>
            <p class="content-desc">
                <asp:Label ID="lblTitulo" runat="server" Text="Label"></asp:Label>
            </p>
            <!-- begin row -->
            <div class="row row-space-10">
                <asp:Repeater ID="Repeater2" DataSourceID="odsClientes" runat="server">
                    <ItemTemplate>
                        <!-- begin col-3 -->
                        <div class="col-md-3 col-sm-6">
                            <!-- begin work -->
                            <div class="work">
                                <!-- BEGIN page-header-cover -->
                                <div class="image">

                                    <img src='<%# Eval("ruta_imagen") %>' alt='<%# Eval("nombre_cliente") %>' style="width: 350px; height: 150px" />
                                </div>
                                <!-- END page-header-cover -->
                                <!-- BEGIN container -->
                                <div class="desc">
                                    <span class="desc-title">
                                        <asp:Label ID="lblTitulo" runat="server" Text='<%# Eval("nombre_cliente") %>'></asp:Label></span>
                                    <span class="desc-text">Direccion:<asp:Label ID="lblDireccion" runat="server" Text='<%# Eval("direccion") %>'></asp:Label>
                                        Estado:<asp:Label ID="lblEstado" runat="server" Text='<%# Eval("estado") %>'></asp:Label></span>
                                    <h1 class="page-header"><b></b></h1>
                                </div>

                                <!-- END container -->
                                <!-- end work -->
                            </div>
                            <asp:Button ID="btnComprar" class="btn-sm btn-success" CommandArgument='<%# Eval("id_cliente") %>' OnClick="btnComprar_Click" runat="server" Text="Ver productos" />
                        </div>

                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- end row -->
        </div>
        <!-- end container -->
    </div>
    <!-- end #work -->
</asp:Content>

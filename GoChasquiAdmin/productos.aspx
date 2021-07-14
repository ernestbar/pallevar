<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="productos.aspx.cs" Inherits="GoChasquiAdmin.productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript"> 
        window.onload = mostrarUbicacion();

        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }

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

    <script type="text/javascript">
        function totalizarArriba() {
            var valor1 = document.getElementById('<%= lblPrecio1.ClientID %>').innerHTML;
            var valor2 = document.getElementById('qty').value;
            var total_final = valor1 * (parseInt(valor2) + 1);
            var subtotal = parseInt(valor1 * (parseInt(valor2) + 1));
            document.getElementById('<%= lblTotal_final.ClientID %>').innerHTML = total_final;
            document.getElementById('<%= lblSubTotal.ClientID %>').innerHTML = subtotal;
            document.getElementById('<%= lblTotal1.ClientID %>').innerHTML = subtotal;
        }

        function totalizarAbajo() {
            var valor1 = document.getElementById('<%= lblPrecio1.ClientID %>').innerHTML;
            var valor2 = document.getElementById('qty').value;
            var total_final = valor1 * (parseInt(valor2) - 1);
            var subtotal = parseInt(valor1 * (parseInt(valor2) - 1));
            if (subtotal < 0) {
                document.getElementById('<%= lblSubTotal.ClientID %>').innerHTML = 0;
                document.getElementById('<%= lblTotal1.ClientID %>').innerHTML = 0;
            }
            else {
                document.getElementById('<%= lblSubTotal.ClientID %>').innerHTML = subtotal;
                document.getElementById('<%= lblTotal_final.ClientID %>').innerHTML = total_final;
            }
        }
        function recuperarTotal() {
            document.getElementById('<%=hfTotal.ClientID%>').value = document.getElementById('<%= lblTotal_final.ClientID %>').innerHTML;
            document.getElementById('<%=hfUnidades.ClientID%>').value = document.getElementById('qty').value;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblClienteID" runat="server" Text="2" Visible="false"></asp:Label>
    <asp:ObjectDataSource ID="odsProducto" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaProductoXCliente">
        <SelectParameters>
            <%--<asp:Parameter Name="id_cliente" DefaultValue="2" />--%>
            <asp:ControlParameter ControlID="lblClienteID" Name="id_cliente" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCliente" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaClienteIndividual">
        <SelectParameters>
            <%--<asp:Parameter Name="id_cliente" DefaultValue="2" />--%>
            <asp:ControlParameter ControlID="lblClienteID" Name="id_cliente" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTipoProducto" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaTipoProductoTodos">
        <SelectParameters>
            <asp:Parameter Name="id_usuario" DefaultValue="0" />
            <%-- <asp:ControlParameter ControlID="lblClienteID" Name="id_cliente" DefaultValue="0" />--%>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <!-- BEGIN #page-header -->
            <div id="page-header" class="section-container page-header-container">
                <asp:Repeater ID="Repeater2" DataSourceID="odsCliente" runat="server">
                    <ItemTemplate>
                        <!-- BEGIN page-header-cover -->
                        <div class="page-header-cover no repeat">
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

                    <!-- BEGIN search-item-container -->
                    <div class="search-item-container">
                        <!-- BEGIN item-row -->
                        <div class="item-row col-md-12">
                            <!-- BEGIN item -->
                            <asp:Repeater ID="Repeater1" DataSourceID="odsProducto" runat="server">
                                <ItemTemplate>
                                    <div class="item item-thumbnail">
                                        <a href="#" class="item-image">
                                            <img src='<%# Eval("ruta_imagen") %>' style="background: url(assets/img/slider/slider-2-cover.jpg) center 0 / cover no-repeat;" alt="" width="96" height="96" />
                                            <br></br>
                                            <asp:Button ID="btnComprar" class="btn-sm btn-success btn-block" CommandArgument='<%# Eval("id_producto") %>' OnClick="btnComprar_Click" runat="server" Text="COMPRAR" />
                                        </a>
                                        <div class="item-info">
                                            <h4 class="item-title">
                                                <asp:Label ID="lblTitulo" runat="server" Text='<%# Eval("nombre") %>'></asp:Label>
                                            </h4>
                                            <p class="item-desc">
                                                <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("descripcion") %>'></asp:Label>
                                            </p>
                                            <div class="item-price">
                                                <asp:Label ID="lblPrecio" runat="server" Text='<%# Eval("precio_unidad") %>'></asp:Label>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <!-- END item -->
                        </div>
                        <!-- END item-row -->
                    </div>
                    <!-- END search-item-container -->

                </div>
                <!-- END search-content -->
            </div>
            <!-- END search-container -->
            <%--		</div>
			<!-- END container -->
		</div>--%>
            <!-- END search-results -->
        </asp:View>
        <asp:View ID="View2" runat="server">
            <!-- BEGIN #checkout-cart -->
            <div class="section-container" id="checkout-cart">
                <!-- BEGIN container -->
                <div class="container">
                    <!-- BEGIN checkout -->
                    <div class="checkout">
                        <!-- BEGIN checkout-header -->
                        <div class="checkout-header">
                            <!-- BEGIN row -->
                            <div class="row">
                                <!-- BEGIN col-3 -->
                                <div class="col-md-3 col-sm-3">
                                    <div class="step active">
                                        <a href="#">
                                            <div class="number">1</div>
                                            <div class="info">
                                                <div class="title">Carrito de compra</div>
                                                <div class="desc">Elije tus productos</div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- END col-3 -->
                                <!-- BEGIN col-3 -->
                                <div class="col-md-3 col-sm-3">
                                    <div class="step">
                                        <a href="#">
                                            <div class="number">2</div>
                                            <div class="info">
                                                <div class="title">Datos de entrega</div>
                                                <div class="desc">Donde te lo llevamos?</div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- END col-3 -->

                                <!-- BEGIN col-3 -->
                                <div class="col-md-3 col-sm-3">
                                    <div class="step">
                                        <a href="#">
                                            <div class="number">3</div>
                                            <div class="info">
                                                <div class="title">Confirmacion de compra</div>
                                                <div class="desc">Confirma tu compra</div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- END col-3 -->
                            </div>
                            <!-- END row -->
                        </div>
                        <!-- END checkout-header -->
                        <!-- BEGIN checkout-body -->
                        <div class="checkout-body">
                            <div class="table-responsive2">
                                <table class="table table-payment-summary">
                                    <tbody>
                                        <tr>
                                            <td class="field">Producto:</td>
                                            <td class="value">
                                                <div class="product-img">
                                                    <asp:Image ID="imgProducto1" runat="server" />
                                                </div>
                                                <div class="product-info">
                                                    <asp:Label ID="lblIdProducto1" runat="server" Text='<%# Eval("id_producto") %>' Visible="false"></asp:Label>
                                                    <div class="title">
                                                        <asp:Label ID="lblTitulo1" runat="server" Text=""></asp:Label>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="field">Precio Bs.:</td>
                                            <td class="value">
                                                <asp:Label ID="lblPrecio1" runat="server" Text="1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="field">Cantidad:</td>
                                            <td class="value">
                                                <%--<div class="cart-qty-input">--%>
                                                <a href="#" onclick="totalizarArriba()" class="qty-control right disabled" data-click="increase-qty" data-target="#qty"><i class="fa fa-plus"></i></a>
                                                <input type="text" name="qty" value="1" class="form-control width-50" id="qty" />
                                                <a href="#" onclick="totalizarAbajo()" class="qty-control left disabled" data-click="decrease-qty" data-target="#qty"><i class="fa fa-minus"></i></a>
                                                <%--</div>--%>
                                                <div class="qty-desc">1 al máximo pedido</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="field">Sub total Bs.:</td>
                                            <td class="value">
                                                <asp:Label ID="lblSubTotal" runat="server" Text="0"></asp:Label>
                                                <asp:Label ID="lblTotal1" runat="server" Visible="false" Text="0"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="field">Total a pagar Bs.:</td>
                                            <td class="value">
                                                <asp:Label ID="lblTotal_final" runat="server" Text="0"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="field">Detalle extra:</td>
                                            <td class="value">
                                                <asp:TextBox ID="txtExtra" class="form-control" TextMode="MultiLine" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="field">
                                                <asp:LinkButton ID="lbtnCancelarP" class="btn btn-white btn-lg pull-rigth" OnClick="lbtnCancelarP_Click" runat="server">Cancelar</asp:LinkButton>
                                            </td>
                                            <td class="value">
                                                <asp:LinkButton ID="lbtnAgregar" class="btn btn-white btn-lg pull-left" OnClick="lbtnAgregar_Click" OnClientClick="recuperarTotal()" runat="server">Agregar</asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="field">Productos añadidos:</td>
                                            <td class="value product-summary">
                                                <asp:Label ID="lblProductosComprados" runat="server" Text="" required></asp:Label>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <!-- END checkout-body -->

                        <!-- end card -->
                        <!-- BEGIN checkout-footer -->
                        <div class="checkout-footer">
                            <asp:LinkButton ID="lbtnSeguirComprando" class="btn btn-white btn-lg pull-left" OnClick="lbtnSeguirComprando_Click" OnClientClick="recuperarTotal()" runat="server">Continuar comprando</asp:LinkButton>
                            <%--<a href="#" class="btn btn-white btn-lg pull-left">Continue Shopping</a>--%>
                            <%--<asp:LinkButton ID="lbtnNextUbicacion" class="btn btn-inverse btn-lg p-l-30 p-r-30 m-l-10" OnClientClick="recuperarTotal();" OnClick="lbtnNextUbicacion_Click"  runat="server">Siguiente paso</asp:LinkButton>--%>
                            <asp:Button ID="btnSiguiente" class="btn btn-inverse btn-lg p-l-30 p-r-30 m-l-10" OnClick="btnSiguiente_Click" OnClientClick="recuperarTotal()" runat="server" Text="Siguiente paso" />
                            <%--<button type="submit"  class="btn btn-inverse btn-lg p-l-30 p-r-30 m-l-10">Checkout</button>--%>
                        </div>
                        <!-- END checkout-footer -->
                    </div>
                    <!-- END checkout -->
                </div>
                <!-- END container -->
            </div>
            <asp:HiddenField ID="hfTotal" runat="server" />
            <asp:HiddenField ID="hfUnidades" runat="server" />
            <!-- END #checkout-cart -->
        </asp:View>
        <asp:View ID="View3" runat="server">
            <div class="section-container" id="checkout-cart2">
                <!-- BEGIN container -->
                <div class="container">
                    <!-- BEGIN checkout -->
                    <div class="checkout">

                        <!-- BEGIN checkout-header -->
                        <div class="checkout-header">
                            <!-- BEGIN row -->
                            <div class="row">
                                <!-- BEGIN col-3 -->
                                <div class="col-md-3 col-sm-3">
                                    <div class="step">
                                        <a href="#">
                                            <div class="number">1</div>
                                            <div class="info">
                                                <div class="title">Carrito de compra</div>
                                                <div class="desc">Elije tus productos</div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- END col-3 -->
                                <!-- BEGIN col-3 -->
                                <div class="col-md-3 col-sm-3">
                                    <div class="step active">
                                        <a href="#">
                                            <div class="number">2</div>
                                            <div class="info">
                                                <div class="title">Datos de entrega</div>
                                                <div class="desc">Donde te lo llevamos?</div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- END col-3 -->

                                <!-- BEGIN col-3 -->
                                <div class="col-md-3 col-sm-3">
                                    <div class="step">
                                        <a href="#">
                                            <div class="number">3</div>
                                            <div class="info">
                                                <div class="title">Confirmacion de compra</div>
                                                <div class="desc">Confirma tu compra</div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- END col-3 -->
                            </div>
                            <!-- END row -->
                        </div>
                        <!-- END checkout-header -->
                        <div class="col-md-10">
                            <input type="button" class="btn-sm btn-success btn-block" value="Buscar mi ubicacion" onclick="javascript: mostrarUbicacionActual()" />
                            <asp:HiddenField ID="hfLatitud" runat="server" EnableViewState="true" />
                            <asp:HiddenField ID="hfLongitud" runat="server" EnableViewState="true" />
                            <div class="form-group row">
                                <label class="col-form-label col-md-3 text-lg-right">Latitud <span class="text-danger">*</span></label>
                                <asp:Label ID="lblLatitud" runat="server" Text="Label"></asp:Label>
                                <label class="col-form-label col-md-3 text-lg-right">Longitud <span class="text-danger">*</span></label>
                                <asp:Label ID="lblLongitud" runat="server" Text="Label"></asp:Label>
                            </div>

                            <div class="form-group row">
                                <label class="col-form-label col-md-3 text-lg-right">Direccion <span class="text-danger">*</span></label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtDireccion" class="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col">
                                    <div id="mapa" style="width: 100%; height: 350px">
                                    </div>
                                </div>
                            </div>

                            <%--</div>--%>
                        </div>
                        <!-- BEGIN checkout-footer -->
                        <div class="checkout-footer">
                            <asp:LinkButton ID="lbtnPaso2anterior" class="btn btn-white btn-lg pull-left" OnClick="lbtnPaso2anterior_Click" OnClientClick="recuperarTotal()" runat="server">Ir atras</asp:LinkButton>
                            <%--<a href="#" class="btn btn-white btn-lg pull-left">Continue Shopping</a>--%>
                            <asp:LinkButton ID="lbtnPaso2siguiente" class="btn btn-inverse btn-lg p-l-30 p-r-30 m-l-10" OnClick="lbtnPaso2siguiente_Click" runat="server">Siguiente paso</asp:LinkButton>
                            <%--<button type="submit"  class="btn btn-inverse btn-lg p-l-30 p-r-30 m-l-10">Checkout</button>--%>
                        </div>
                        <!-- END checkout-footer -->

                    </div>
                    <!-- END checkout -->
                </div>
                <!-- END container -->
            </div>
        </asp:View>
        <asp:View ID="View4" runat="server">
            <!-- BEGIN #checkout-cart -->
            <div class="section-container" id="checkout-cart">
                <!-- BEGIN container -->
                <div class="container">
                    <!-- BEGIN checkout -->
                    <div class="checkout">

                        <!-- BEGIN checkout-header -->
                        <div class="checkout-header">
                            <!-- BEGIN row -->
                            <div class="row">
                                <!-- BEGIN col-3 -->
                                <div class="col-md-3 col-sm-3">
                                    <div class="step">
                                        <a href="#">
                                            <div class="number">1</div>
                                            <div class="info">
                                                <div class="title">Carrito de compra</div>
                                                <div class="desc">Elije tus productos</div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- END col-3 -->
                                <!-- BEGIN col-3 -->
                                <div class="col-md-3 col-sm-3">
                                    <div class="step">
                                        <a href="#">
                                            <div class="number">2</div>
                                            <div class="info">
                                                <div class="title">Datos de entrega</div>
                                                <div class="desc">Donde te lo llevamos?</div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- END col-3 -->

                                <!-- BEGIN col-3 -->
                                <div class="col-md-3 col-sm-3">
                                    <div class="step active">
                                        <a href="#">
                                            <div class="number">3</div>
                                            <div class="info">
                                                <div class="title">Confirmacion de compra</div>
                                                <div class="desc">Confirma tu compra</div>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- END col-3 -->
                            </div>
                            <!-- END row -->
                        </div>
                        <!-- END checkout-header -->
                        <!-- BEGIN checkout-body -->
                        <div class="checkout-body">
                            <!-- BEGIN checkout-message -->
                            <div class="checkout-message">
                                <h1>Gracias! <small>Por favor confirma tu pedido para terminar.</small></h1>
                                <div class="table-responsive2">
                                    <table class="table table-payment-summary">
                                        <tbody>
                                            <tr>
                                                <td class="field">Total productos</td>
                                                <td class="value">
                                                    <asp:Label ID="lblTotalProdConf" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="field">Costo Delivery</td>
                                                <td class="value">
                                                    <asp:Label ID="lblCostoDeliveryConf" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="field">Direccion:</td>
                                                <td class="value">
                                                    <asp:Label ID="lblDireccionConf" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="field">Resumen pedido</td>
                                                <td class="value product-summary">
                                                    <asp:Label ID="lblProductosConf" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="field">Total a pagar:</td>
                                                <td class="value">
                                                    <asp:Label ID="lblTotalPagarConf" runat="server" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="field">
                                                    <asp:Button ID="btnCancelar" runat="server" OnClick="btnCancelar_Click" class="btn btn-danger btn-lg p-l-30 p-r-30 m-l-10" Text="Cancelar" /></td>
                                                <td class="value">
                                                    <asp:Button ID="btnConfirmar" runat="server" OnClick="btnConfirmar_Click" class="btn btn-success btn-lg p-l-30 p-r-30 m-l-10" Text="Confirmar" /></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <p class="text-muted text-center m-b-0">
                                    <asp:Label ID="lblAsistencia1" runat="server" Text="Label"></asp:Label>
                                </p>
                            </div>
                            <!-- END checkout-message -->
                        </div>
                        <!-- END checkout-body -->
                        <!-- BEGIN checkout-footer -->
                        <div class="checkout-footer text-center">
                            <asp:LinkButton ID="lbtnPaso3anterior" class="btn btn-white btn-lg pull-left" OnClick="lbtnPaso3anterior_Click" runat="server">Ir atras</asp:LinkButton>
                            <asp:Label ID="lblAvisoFinal" class="btn text-red btn-lg p-l-30 p-r-30 m-l-10" runat="server" Text=""></asp:Label>
                        </div>
                        <!-- END checkout-footer -->

                    </div>
                    <!-- END checkout -->
                </div>
                <!-- END container -->
            </div>
            <!-- END #checkout-cart -->
        </asp:View>
        <asp:View ID="View5" runat="server">
            <div class="section-container" id="checkout-cart">
                <!-- BEGIN container -->
                <div class="container">
                    <!-- BEGIN checkout -->
                    <div class="checkout">
                        <!-- BEGIN checkout-message -->
                        <div class="checkout-message">
                            <h1>Gracias! <small>Se registró tu pedido.</small></h1>
                            <p class="text-muted text-center m-b-0">
                                <asp:Label ID="lblAsistencia2" runat="server" Text="Label"></asp:Label>
                            </p>
                        </div>
                        <!-- END checkout-message -->
                    </div>
                </div>
            </div>
        </asp:View>
    </asp:MultiView>
</asp:Content>

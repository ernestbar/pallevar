<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="transporte.aspx.cs" Inherits="GoChasquiAdmin.transporte" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript"> 
        window.onload = mostrarUbicacion();

        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }

        function mostrarUbicacion() {
            mostrarUbicacion1();
            mostrarUbicacion2();
        }

        function mostrarUbicacion1() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(obtenerUbicacion1);
            }
            else {
                alert("La característica de Geo Localización no está disponible en este navegador");
            }
        }

        function mostrarUbicacion2() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(obtenerUbicacion2);
            }
            else {
                alert("La característica de Geo Localización no está disponible en este navegador");
            }
        }

        function mostrarUbicacionActual1() {
            document.getElementById('<%= lblLatitud.ClientID %>').value = "";
            document.getElementById('<%= lblLongitud.ClientID %>').value = "";
            document.getElementById('<%= hfLatitud.ClientID %>').value = "";
            document.getElementById('<%= hfLongitud.ClientID %>').value = "";
            mostrarUbicacion1();
        }

        function mostrarUbicacionActual2() {
            document.getElementById('<%= lblLat2.ClientID %>').value = "";
            document.getElementById('<%= lblLon2.ClientID %>').value = "";
            document.getElementById('<%= hfLat2.ClientID %>').value = "";
            document.getElementById('<%= hfLon2.ClientID %>').value = "";
            mostrarUbicacion2();
        }

        function obtenerUbicacion1(position) {
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

            var mapa = new google.maps.Map(document.getElementById("mapa1"), mapOpciones);

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

        function obtenerUbicacion2(position) {
            // Obtener posición actual
            var latitud = 0;
            var longitud = 0;

            // Obtener datos de controles
            var hfLat2 = document.getElementById('<%=hfLat2.ClientID%>');
            var hfLon2 = document.getElementById('<%=hfLon2.ClientID%>');
            var lblLat2 = document.getElementById('<%=lblLat2.ClientID%>');
            var lblLon2 = document.getElementById('<%=lblLon2.ClientID%>');

            if (hfLat2 == null) {
                return;
            }

            if (hfLon2 == null) {
                return;
            }

            // Si no hay latitud o longitud registrada tomar la actual
            if (hfLat2.value == "" && hfLon2.value == "") {
                latitud = position.coords.latitude;
                longitud = position.coords.longitude;

                lblLat2.innerHTML = latitud;
                lblLon2.innerHTML = longitud;
                hfLat2.innerHTML = latitud;
                hfLon2.innerHTML = longitud;

                document.getElementById('<%= lblLat2.ClientID %>').value = latitud;
                document.getElementById('<%= lblLon2.ClientID %>').value = longitud;
                document.getElementById('<%= hfLat2.ClientID %>').value = latitud;
                document.getElementById('<%= hfLon2.ClientID %>').value = longitud;
            }
            else {
                latitud = hfLat2.value;
                longitud = hfLon2.value;

                lblLat2.innerHTML = latitud;
                lblLon2.innerHTML = longitud;

                document.getElementById('<%= lblLat2.ClientID %>').value = latitud;
                document.getElementById('<%= lblLon2.ClientID %>').value = longitud;
            }

            // Inicializar el Mapa
            var LatLng = new google.maps.LatLng(latitud, longitud);
            var mapOpciones = {
                center: LatLng,
                zoom: 13,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            var mapa = new google.maps.Map(document.getElementById("mapa2"), mapOpciones);

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

                    var lblLat2 = document.getElementById('<%=lblLat2.ClientID%>');
                    lblLat2.innerHTML = latitud;
                    var lblLon2 = document.getElementById('<%=lblLon2.ClientID%>');
                    lblLon2.innerHTML = longitud;

                    var hfLat2 = document.getElementById('<%=hfLat2.ClientID%>');
                    hfLat2.innerHTML = latitud;
                    var hfLon2 = document.getElementById('<%=hfLon2.ClientID%>');
                    hfLon2.innerHTML = longitud;

                    document.getElementById('<%= lblLat2.ClientID %>').value = latitud;
                    document.getElementById('<%= lblLon2.ClientID %>').value = longitud;
                    document.getElementById('<%= hfLat2.ClientID %>').value = latitud;
                    document.getElementById('<%= hfLon2.ClientID %>').value = longitud;
                }
            );
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                            <div id="dOrigen" class="step active" runat="server">
                                <div class="number">1</div>
                                <div class="info">
                                    <div class="title">Origen</div>
                                    <div class="desc">Dinos donde te encuentras</div>
                                </div>
                            </div>
                        </div>
                        <!-- END col-3 -->
                        <!-- BEGIN col-3 -->
                        <div class="col-md-3 col-sm-3">
                            <div id="dDestino" class="step" runat="server">
                                <a href="#">
                                    <div class="number">2</div>
                                    <div class="info">
                                        <div class="title">Destino</div>
                                        <div class="desc">Donde te llevamos?</div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <!-- END col-3 -->

                        <!-- BEGIN col-3 -->
                        <div class="col-md-3 col-sm-3">
                            <div id="dFinal" class="step" runat="server">
                                <a href="#">
                                    <div class="number">3</div>
                                    <div class="info">
                                        <div class="title">Confirmacion y precio</div>
                                        <div class="desc">Confirma el movil</div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <!-- END col-3 -->
                    </div>
                    <!-- END row -->
                </div>
                <!-- END checkout-header -->
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="View1" runat="server">
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Direccion de origen: <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:TextBox ID="txtDireccion1" class="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">

                            <label class="col-form-label col-md-3 text-lg-right">
                                <input type="button" class="btn-sm btn-success btn-block" value="Buscar mi ubicacion" onclick="javascript: mostrarUbicacionActual1()" /><span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <div id="mapa1" style="width: 100%; height: 350px">
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Latitud <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:Label ID="lblLatitud" runat="server" Text="Label"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Longitud <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:Label ID="lblLongitud" runat="server" Text="Label"></asp:Label>
                            </div>
                        </div>
                        <asp:HiddenField ID="hfLatitud" runat="server" />
                        <asp:HiddenField ID="hfLongitud" runat="server" />
                    </asp:View>

                    <asp:View ID="View2" runat="server">
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Direccion de destino: <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:TextBox ID="txtDireccion2" class="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">

                            <label class="col-form-label col-md-3 text-lg-right">
                                <input type="button" class="btn-sm btn-success btn-block" value="Buscar mi ubicacion" onclick="javascript: mostrarUbicacionActual2()" /><span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <div id="mapa2" style="width: 100%; height: 350px">
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Latitud <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:Label ID="lblLat2" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Longitud <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:Label ID="lblLon2" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <asp:HiddenField ID="hfLat2" runat="server" />
                        <asp:HiddenField ID="hfLon2" runat="server" />
                    </asp:View>
                    <asp:View ID="View3" runat="server">
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Direccion de origen: <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:Label ID="lblDir1" class="form-control" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Direccion de destino: <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:Label ID="lblDir2" class="form-control" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Costo Calculado (Bs.): <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:Label ID="lblCosto" class="form-control" runat="server" Text="50"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Distancia Aproximada(Km.): <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:Label ID="lblDistancia" class="form-control" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-form-label col-md-3 text-lg-right">Costo Propuesto (Bs.): <span class="text-danger">*</span></label>
                            <div class="col-md-7">
                                <asp:TextBox ID="txtCostoPropuesto" class="form-control" runat="server" Width="50%"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-7">
                                <asp:LinkButton ID="lbtnConfirmar" class="btn btn-default btn-md pull-right" OnClick="lbtnConfirmar_Click" runat="server">Confirmar</asp:LinkButton>
                            </div>
                        </div>
                    </asp:View>
                    <asp:View ID="View4" runat="server">
                        <div class="section-container">
                            <!-- BEGIN container -->
                            <div class="container">
                                <!-- BEGIN checkout -->
                                <div class="checkout">
                                    <!-- BEGIN checkout-message -->
                                    <div class="checkout-message">
                                        <h1>Felicidades! <small>Tu ruta fue registrada correctamente. En breve tendras el transporte en tu destino.</small></h1>
                                        <p class="text-muted text-center m-b-0">
                                             <asp:Label ID="lblAsistencia" runat="server" Text="Label"></asp:Label>
                                        </p>
                                    </div>
                                    <!-- END checkout-message -->
                                </div>
                            </div>
                        </div>
                    </asp:View>
                </asp:MultiView>

                <!-- BEGIN checkout-footer -->
                <div class="checkout-footer" style="height: 100px">
                    <div class="col-md-13">
                        <asp:LinkButton ID="lbtnAnterior" class="btn btn-default btn-md pull-left" OnClick="lbtnAnterior_Click" runat="server"><---Anterior</asp:LinkButton>
                    </div>
                    <div class="col-md-13">
                        <asp:LinkButton ID="lbtnSiguiente" class="btn btn-default btn-md pull-right" OnClick="lbtnSiguiente_Click" runat="server">Siguiente--></asp:LinkButton>
                    </div>
                    <!-- END checkout-footer -->
                </div>
            </div>
        </div>
    </div>

    <!-- BEGIN #registro -->
    <div class="section-container">
        <!-- BEGIN container -->
        <div class="container">
            <div class="row">
                <div class="col-12" style="text-align: center">
                    <img alt="" src="assets/img/gochasqui/GORRA PALLEVAR.png" width="250" height="266">
                </div>
            </div>
        </div>
        <!-- END container -->
    </div>
    <!-- END #registro -->
</asp:Content>

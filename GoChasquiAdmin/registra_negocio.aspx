<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="registra_negocio.aspx.cs" Inherits="GoChasquiAdmin.registra_negocio" %>

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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfLatitud" runat="server" EnableViewState="true" />
    <asp:HiddenField ID="hfLongitud" runat="server" EnableViewState="true" />
    <asp:Label ID="lblAviso" runat="server" Text="" ForeColor="Blue"></asp:Label>
    <asp:ObjectDataSource ID="odsTipoNegocio" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaTipoNegocioTodos">
        <SelectParameters>
            <%--<asp:Parameter Name="id_usuario" DefaultValue="0" />--%>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCiudad" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaCiudadTodos">
        <SelectParameters>
            <%--<asp:Parameter Name="id_usuario" DefaultValue="0"  />--%>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblIdUsuario" runat="server" Text="0" Visible="false"></asp:Label>
    <div class="container">
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <!-- BEGIN #page-header -->
                <div id="page-header" class="section-container page-header-container bg-black">
                    <!-- BEGIN page-header-cover -->
                    <div class="page-header-cover">
                        <img src="../assets/img/cover/cover-15.jpg" alt="" />
                    </div>
                    <!-- END page-header-cover -->
                    <!-- BEGIN container -->
                    <div class="container">
                        <h1 class="page-header"><b>Registra</b> tu negocio</h1>
                    </div>
                    <!-- END container -->
                </div>
                <!-- BEGIN #page-header -->

                <!-- BEGIN #product -->
                <div id="product" class="section-container p-t-20">
                    <!-- BEGIN container -->
                    <div class="container">
                        <!-- BEGIN breadcrumb -->
                        <ul class="breadcrumb m-b-10 f-s-12">
                            <%--<li class="breadcrumb-item"><a href="#">Home</a></li>
											<li class="breadcrumb-item"><a href="#">Support</a></li>--%>
                            <li class="breadcrumb-item active">REGISTRA TU NEGOCIO</li>
                        </ul>
                        <!-- END breadcrumb -->
                        <!-- BEGIN row -->
                        <div class="row row-space-30">
                            <!-- BEGIN col-8 -->
                            <div class="col-md-8">
                                <h4 class="m-t-0">FORMA PARTE DE NUESTRA FAMILIA</h4>
                                <p class="m-b-30 f-s-13">
                                    Gracias por fomar parte de nuestro emprendimiento, a continuacion deberas llenar algunos datos para que tu negocio, pueda administrar y publicar sus productos al publico.<br />
                                    Si no tienes una razon social puedes registrar con tu datos personales y tu carnet de identidad.
                                </p>

                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Razon social <span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtRazonSocial" class="form-control" runat="server"></asp:TextBox>
                                        <%--<input type="text" class="form-control"  name="name" />--%>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">NIT/CI <span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtNitCi" class="form-control" runat="server"></asp:TextBox>
                                        <%--<input type="text" class="form-control" name="email" />--%>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Paterno <span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtPaterno" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Materno <span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtMaterno" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Nombres <span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtNombres" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Ciudad <span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:DropDownList ID="ddlCiudad" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsCiudad" DataTextField="nombre" DataValueField="id_ciudad" runat="server"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Tipo negocio <span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:DropDownList ID="ddlTipoNegocio" OnDataBound="ddlTipoNegocio_DataBound" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsTipoNegocio" DataTextField="nombre" DataValueField="id_tiponegocio" runat="server"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Telefono de contacto 1<span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtTelefono1" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Telefono de contacto 2<span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtTelefono2" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Celular de contacto 1<span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtCelular1" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Celular de contacto 2<span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtCelular2" class="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">Direccion <span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <asp:TextBox ID="txtDireccion" class="form-control" runat="server"></asp:TextBox>
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
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3 text-lg-right">
                                        <input type="button" class="btn-sm btn-success btn-block" value="Buscar mi ubicacion" onclick="javascript: mostrarUbicacionActual()" /><span class="text-danger">*</span></label>
                                    <div class="col-md-7">
                                        <div id="mapa" style="width: 100%; height: 350px">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">Foto de portada:</label>
                                    <asp:FileUpload ID="fuImagen" class="btn btn-sm col-8 btn-default" runat="server" AllowMultiple="True" />

                                </div>
                                <div class="form-group row">
                                    <label class="col-form-label col-md-3"></label>
                                    <div class="col-md-7">
                                        <asp:Button ID="btnGrabar" OnClick="btnGrabar_Click" class="btn btn-inverse btn-lg" runat="server" Text="Grabar" />
                                        <%--<button type="submit" class="btn btn-inverse btn-lg">Send Message</button>--%>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- END row -->
                    </div>
                    <!-- END row -->
                </div>
                <!-- END #product -->
            </asp:View>
            <asp:View ID="View2" runat="server">
                <div class="section-container" id="checkout-cart">
                    <!-- BEGIN container -->
                    <div class="container">
                        <!-- BEGIN checkout -->
                        <div class="checkout">
                            <!-- BEGIN checkout-message -->
                            <div class="checkout-message">
                                <h1>Felicidades! <small>Tu registro se completo satisfactoriamente. Se te habilitaran opciones en el menú para administrar tu negocio.</small></h1>

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
    </div>
</asp:Content>

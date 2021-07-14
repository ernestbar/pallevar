<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="GoChasquiAdmin.home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- BEGIN #slider -->
    <div id="slider" class="section-container p-0 bg-black-darker align-content-center" style="height: 540px;">
        <%--style="background-image:url(assets/img/gochasqui/fondo_mosaico.jpg)"--%>
        <!-- BEGIN carousel -->
        <div id="main-carousel" class="carousel slide" data-ride="carousel">
            <!-- BEGIN carousel-inner -->
            <div class="carousel-inner">
                <!-- BEGIN item -->
                <div class="carousel-item active align-content-lg-stretch" data-paroller="true" data-paroller-factor="0.3" data-paroller-factor-sm="0.01" data-paroller-factor-xs="0.01" style="background: url('assets/img/gochasqui/Banner-1.jpg') center 0 / cover no-repeat; height: 540px">
                    <%--<div class="container">
							<img src="" class="product-img right bottom fadeInRight animated" alt="" />
						</div>--%>
                    <div class="carousel-caption carousel-caption-center align-bottom  text-blue">
                        <%--<a href="#" class="btn btn-outline-dark btn-lg fadeInRightBig animated text-blue">Hazlo ahora</a>--%>
                        <div class="container text-yellow">
                            <%--<h3 class="title m-b-5 fadeInLeftBig animated text-yellow">Aplicaciones Android y IOS</h3>
								<p class="m-b-15 fadeInLeftBig animated">Descarga nuestra aplicacion en tu celular</p>
								<div class="price m-b-30 fadeInLeftBig animated"><small>Sin costo</small> <span>Gratuito!!!</span></div>--%>
                        </div>
                    </div>
                </div>
                <!-- END item -->
                <!-- BEGIN item -->
                <div class="carousel-item" data-paroller="true" data-paroller-factor="-0.3" data-paroller-factor-sm="0.01" data-paroller-factor-xs="0.01" style="background: url(assets/img/gochasqui/Banner-2.jpg) center 0 / cover no-repeat; height: 540px">
                    <div class="container">
                        <img src="assets/img/slider/slider-2-product.png" class="product-img left bottom fadeInLeft animated" alt="" />
                    </div>
                    <div class="carousel-caption carousel-caption-right">
                        <div class="container">
                            <%--<h3 class="title m-b-5 fadeInRightBig animated">Riders</h3>
								<p class="m-b-15 fadeInRightBig animated">Quieres trabajar con nosotros</p>
								<div class="price m-b-30 fadeInRightBig animated"><small>Registro</small> <span>Gratuito!!!</span></div>--%>
                            <%--<a href="product_detail.html" class="btn btn-outline btn-lg fadeInRightBig animated">Hazlo ahora</a>--%>
                        </div>
                    </div>
                </div>
                <!-- END item -->
                <!-- BEGIN item -->
                <div class="carousel-item" data-paroller="true" data-paroller-factor="-0.3" data-paroller-factor-sm="0.01" data-paroller-factor-xs="0.01" style="background: url(assets/img/gochasqui/Banner-3.jpg) center 0 / cover no-repeat; height: 540px">
                    <div class="carousel-caption">
                        <div class="container">
                            <%--<h3 class="title m-b-5 fadeInDownBig animated">Taxis</h3>
								<p class="m-b-15 fadeInRightBig animated">Quieres trabajar con nosotros</p>
								<div class="price m-b-30 fadeInRightBig animated"><small>Registro</small> <span>Gratuito!!!</span></div>--%>
                            <%--<a href="product_detail.html" class="btn btn-outline btn-lg fadeInRightBig animated">Hazlo ahora</a>--%>
                        </div>
                    </div>
                </div>
                <!-- END item -->
            </div>
            <!-- END carousel-inner -->
            <a class="carousel-control-prev" href="#main-carousel" data-slide="prev">
                <i class="fa fa-angle-left"></i>
            </a>
            <a class="carousel-control-next" href="#main-carousel" data-slide="next">
                <i class="fa fa-angle-right"></i>
            </a>
        </div>
        <!-- END carousel -->
    </div>
    <!-- END #slider -->

    <!-- BEGIN #registro -->
    <div id="registro" class="section-container">
        <%--style="background-image:url(assets/img/gochasqui/fondo_mosaico.jpg)"--%>
        <!-- BEGIN container -->
        <div class="container">
            <table style="margin: auto;">
                <tr>
                    <td rowspan="2">
                        <a href="registra_negocio.aspx" style="margin: auto; vertical-align:central;">
                            <img alt="Registra tu negocio" src="assets/img/gochasqui/REGISTRO.png" width="250" height="266"></a>
                    </td>
                    <td>
                        <a href="https://play.google.com/store/apps/details?id=com.gochasqui.pallevar" style="margin: auto; vertical-align:bottom;">
                            <img alt="Playstore" src="assets/img/gochasqui/PLAYSTORE.png" width="250" height="166"></a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="https://apps.apple.com/bo/app/pa-llevar/id1563955218" style="margin: auto; vertical-align:top;">
                            <img alt="Appstore" src="assets/img/gochasqui/APPSTORE.png" width="250" height="166"></a>
                    </td>
                </tr>
            </table>
        </div>
    <!-- END container -->
    </div>
    <!-- END #registro -->

    <!-- BEGIN #trending-items -->
    <div id="trending-items" class="section-container">
        <%--style="background-image:url(assets/img/gochasqui/fondo_mosaico.jpg)"--%>
        <!-- BEGIN container -->
        <div class="container">
            <!-- BEGIN section-title -->
            <h4 class="section-title clearfix">
                <%--<a href="#" class="pull-right m-l-5"><i class="fa fa-angle-right f-s-18"></i></a>
					<a href="#" class="pull-right"><i class="fa fa-angle-left f-s-18"></i></a>--%>
                Nuestros Servicios
                <%--<small>Shop and get your favourite items at amazing prices!</small>--%>
            </h4>
            <!-- END section-title -->
            <!-- BEGIN row -->
            <div class="row row-space-10">
                <!-- BEGIN col-2 -->
                <div class="col-md-2 col-sm-4">
                    <!-- BEGIN item -->
                    <div class="item item-thumbnail">
                        <a href="transporte.aspx" class="item-image">
                            <img src="assets/img/gochasqui/transporte b.png" onmouseover="this.src='assets/img/gochasqui/transporte.png'" onmouseout="this.src='assets/img/gochasqui/transporte b.png'" alt="" />
                            <%--<div class="discount">15% OFF</div>--%>
                        </a>
                        <div class="item-info">
                            <h4 class="item-title">
                                <a href="transporte.aspx">Servicio Transporte<br />
                                </a>
                            </h4>
                            <p class="item-desc">Solicita tu movil</p>
                        </div>
                    </div>
                    <!-- END item -->
                </div>
                <!-- END col-2 -->
                <!-- BEGIN col-2 -->
                <div class="col-md-2 col-sm-4">
                    <!-- BEGIN item -->
                    <div class="item item-thumbnail">
                        <a href="restaurantes.aspx" class="item-image">
                            <img src="assets/img/gochasqui/restauranteb.png" onmouseover="this.src='assets/img/gochasqui/restaurantes.png'" onmouseout="this.src='assets/img/gochasqui/restauranteb.png'" alt="" />
                            <%--<div class="discount">32% OFF</div>--%>
                        </a>
                        <div class="item-info">
                            <h4 class="item-title">
                                <a href="restaurantes.aspx">Servicio Restaurantes<br />
                                </a>
                            </h4>
                            <p class="item-desc">Variedad de menus</p>
                        </div>
                    </div>
                    <!-- END item -->
                </div>
                <!-- END col-2 -->
                <!-- BEGIN col-2 -->
                <div class="col-md-2 col-sm-4">
                    <!-- BEGIN item -->
                    <div class="item item-thumbnail">
                        <a href="comercios.aspx?Id_tiposervicio=3" class="item-image">

                            <img src="assets/img/gochasqui/mercadob.png" alt="" />
                            <%--<li></li>--%>
                            <%--<div class="discount">20% OFF</div>--%>
                        </a>
                        <div class="item-info">
                            <h4 class="item-title">
                                <a href="comercios.aspx?Id_tiposervicio=3">Servicio Mercado<br />
                                </a>
                            </h4>
                            <p class="item-desc">Te llevamos tus compras del hogar</p>
                        </div>
                    </div>
                    <!-- END item -->
                </div>
                <!-- END col-2 -->
                <!-- BEGIN col-2 -->
                <div class="col-md-2 col-sm-4">
                    <!-- BEGIN item -->
                    <div class="item item-thumbnail">
                        <a href="comercios.aspx?Id_tiposervicio=4" class="item-image">
                            <img src="assets/img/gochasqui/tiendasb.png" alt="" />
                            <%--<div class="discount">13% OFF</div>--%>
                        </a>
                        <div class="item-info">
                            <h4 class="item-title">
                                <a href="comercios.aspx?Id_tiposervicio=4">Servicio Tiendas<br />
                                </a>
                            </h4>
                            <p class="item-desc">Tenemos variedad de productos</p>
                        </div>
                    </div>
                    <!-- END item -->
                </div>
                <!-- END col-2 -->
                <!-- BEGIN col-2 -->
                <div class="col-md-2 col-sm-4">
                    <!-- BEGIN item -->
                    <div class="item item-thumbnail">
                        <a href="comercios.aspx?Id_tiposervicio=5" class="item-image">
                            <img src="assets/img/gochasqui/saludb.png" alt="" />
                            <%--<div class="discount">30% OFF</div>--%>
                        </a>
                        <div class="item-info">
                            <h4 class="item-title">
                                <a href="comercios.aspx?Id_tiposervicio=5">Servicio Salud<br />
                                </a>
                            </h4>
                            <p class="item-desc">La salud es primordial</p>
                        </div>
                    </div>
                    <!-- END item -->
                </div>
                <!-- END col-2 -->
                <!-- BEGIN col-2 -->
                <div class="col-md-2 col-sm-4">
                    <!-- BEGIN item -->
                    <div class="item item-thumbnail">
                        <a href="envio.aspx" class="item-image">
                            <%--<asp:Image ID="imgEnvio" ImageUrl="./assets/img/gochasqui/envios.png" onmouseover="this.src='./assets/img/gochasqui/mercadob.png'" onmouseout="this.src='./assets/img/gochasqui/envios.png'" runat="server" />--%>
                            <img src="assets/img/gochasqui/enviosb.png" alt="" />
                            <%--<div class="discount">40% OFF</div>--%>
                        </a>
                        <div class="item-info">
                            <h4 class="item-title">
                                <a href="envio.aspx">Servicio Envios<br />
                                </a>
                            </h4>
                            <p class="item-desc">Trasladamos tus productos</p>
                        </div>
                    </div>
                    <!-- END item -->
                </div>
                <!-- END col-2 -->
            </div>
            <!-- END row -->
        </div>
        <!-- END container -->
    </div>
    <!-- END #trending-items -->
</asp:Content>

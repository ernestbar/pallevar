<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="cambia_pass.aspx.cs" Inherits="GoChasquiAdmin.cambia_pass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="form-group row">
            <asp:Label ID="lblAviso" class="col-form-label col-md-6 text-blue" runat="server" Text=""></asp:Label>
        </div>
    </div>
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="View1" runat="server">
            <!-- BEGIN #product -->
            <div id="product" class="section-container p-t-20">
                <!-- BEGIN container -->
                <div class="container">

                    <!-- BEGIN row -->
                    <div class="row row-space-30">
                        <!-- BEGIN col-8 -->
                        <div class="col-md-8">
                            <h4 class="m-t-0">CAMBIAR CONTRASEÑA</h4>
                            <p class="m-b-30 f-s-13">
                                Introduce tu nueva contraseña y repitela.
                            </p>
                            <div class="form-group row">
                                <label class="col-form-label col-md-3 text-lg-right">Nueva contraseña:<span class="text-danger">*</span></label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtPassword" class="form-control" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-form-label col-md-3"></label>
                                <div class="col-md-7">
                                    <asp:Button ID="btnEnviar" OnClick="btnEnviar_Click" class="btn btn-inverse btn-lg" runat="server" Text="Solicitar" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:View>

        <asp:View ID="View2" runat="server">
            <div class="section-container" id="checkout-cart">
                <!-- BEGIN container -->
                <div class="container">
                    <!-- BEGIN checkout -->
                    <div class="checkout">
                        <!-- BEGIN checkout-message -->
                        <div class="checkout-message">
                            <h1>Felicidades! <small>Tu contraseña se cambio correctamente, puedes ingresar con la misma.</small></h1>
                            <p class="text-muted text-center m-b-0">
                                <asp:Label ID="lblAsistencia1" runat="server" Text="Label"></asp:Label>
                            </p>
                        </div>
                        <!-- END checkout-message -->
                    </div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="View3" runat="server">
            <div class="section-container" id="checkout-cart">
                <!-- BEGIN container -->
                <div class="container">
                    <!-- BEGIN checkout -->
                    <div class="checkout">
                        <!-- BEGIN checkout-message -->
                        <div class="checkout-message">
                            <h1>Lo siento! <small>Pero este link ya fue procesado o fue inhabilitado por tiempo, el link solo dura 24 hrs. para su uso, vuelva a generar otro link gracias!!</small></h1>
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

<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="reset_password.aspx.cs" Inherits="GoChasquiAdmin.reset_password" %>

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
                    <!-- BEGIN breadcrumb -->
                    <ul class="breadcrumb m-b-10 f-s-12">
                        <li class="breadcrumb-item active">RESETEA TU CONTRASEÑA</li>
                    </ul>
                    <!-- END breadcrumb -->
                    <!-- BEGIN row -->
                    <div class="row row-space-30">
                        <!-- BEGIN col-8 -->
                        <div class="col-md-8">
                            <h4 class="m-t-0">OLVIDASTE TU CONTRASEÑA?</h4>
                            <p class="m-b-30 f-s-13">
                                Introduce tu correo con el que te registraste en nuestra aplicacion y te enviaremos al mismo un link para el reseteo de tu contraseña.
                            </p>
                            <div class="form-group row">
                                <label class="col-form-label col-md-3 text-lg-right">Correo electronico<span class="text-danger">*</span></label>
                                <div class="col-md-7">
                                    <asp:TextBox ID="txtEmail" class="form-control" runat="server"></asp:TextBox>
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
                            <h1>Felicidades! <small>Tu solicitud se proceso satisfactoriamente. Se te envio un correo con un link para que puedas resetear tu contraseña.</small></h1>
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
</asp:Content>

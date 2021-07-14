<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="contacto.aspx.cs" Inherits="GoChasquiAdmin.contacto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container align-content-center">
        <!-- begin section-container -->
        <div class="section-container align-content-center">
            <h4 class="section-title m-b-20"><span>CONTACTANOS</span></h4>
            <p class="m-b-30 f-s-13">
                <b>SI NECESITAS COMUNICARTE CON NOSOTROS, PUEDES ENVIANOS UN CORREO CON TUS DATOS, PARA QUE NOS PONGAMOS EN CONTACTO CONTIGO.</b>
            </p>
            <asp:Label ID="lblAviso" runat="server" Text=""></asp:Label>
            <!-- begin row -->
            <div class="row row-space-30 f-s-12 text-inverse">
                <!-- begin col-8 -->
                <div class="col-md-8">

                    <div class="form-group row">
                        <label class="col-form-label col-md-3 text-md-right">Nombre <span class="text-danger">*</span></label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtNombre" class="form-control" runat="server"></asp:TextBox>

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-md-3 text-md-right">Email <span class="text-danger">*</span></label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtEmail" class="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-md-3 text-md-right">Celular <span class="text-danger">*</span></label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtCelular" class="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-md-3 text-md-right">Mensaje <span class="text-danger">*</span></label>
                        <div class="col-md-9">
                            <asp:TextBox ID="txtMensaje" TextMode="MultiLine" class="form-control" Rows="10" runat="server"></asp:TextBox>

                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-md-3 text-md-right"></label>
                        <div class="col-md-9 text-left">
                            <asp:Button ID="btnEnviar" class="btn btn-inverse btn-lg btn-block" OnClick="btnEnviar_Click" runat="server" Text="Enviar Mensaje" />
                            <%--<button type="submit" class="btn btn-inverse btn-lg btn-block">Send Message</button>--%>
                        </div>
                    </div>

                </div>
                <!-- end col-8 -->
                <!-- begin col-4 -->
                <%--<div class="col-md-4">
								<p>
									<strong>SeanTheme Studio, Inc</strong><br>
									795 Folsom Ave, Suite 600<br>
									San Francisco, CA 94107<br>
									P: (123) 456-7890<br>
								</p>
								<p>
									<span class="phone">+11 (0) 123 456 78</span><br>
									<a href="mailto:hello@emailaddress.com">seanthemes@support.com</a>
								</p>
							</div>--%>
                <!-- end col-4 -->
            </div>
            <!-- end row -->
        </div>
        <!-- end section-container -->
    </div>

    <!-- BEGIN #registro -->
    <div class="section-container">
        <!-- BEGIN container -->
        <div class="container">
            <div class="row">
                <div class="col-12" style="text-align: center">
                    <img alt="" src="assets/img/gochasqui/DRIVER MOVIL.png" width="400" height="568">
                </div>
            </div>
        </div>
        <!-- END container -->
    </div>
    <!-- END #registro -->
</asp:Content>

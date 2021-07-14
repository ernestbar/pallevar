<%@ Page Title="" Language="C#" MasterPageFile="~/webPublica.Master" AutoEventWireup="true" CodeBehind="cambiar_clave.aspx.cs" Inherits="GoChasquiAdmin.cambiar_clave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="lblIdUsuario" runat="server" Text="" Visible="false"></asp:Label>
    <div class="container">
        <!-- begin login -->
        <div class="login bg-white animated fadeInDown p-20 m-2">
            <!-- begin brand -->
            <div class="login-header">
                <div class="brand">
                    <span class="logo"></span><b>Cambio  </b>de contraseña
					<small>rapido y sencillo</small>
                </div>
                <div class="icon">
                    <i class="fa fa-lock"></i>
                </div>
            </div>
        </div>
        <!-- end brand -->
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <!-- begin login-content -->
                <div class="login-content">
                    <div class="form-group">
                        <asp:TextBox ID="txtClave" class="form-control col-md-6" placeholder="Nuevo password" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtClaveRepeat" class="form-control col-md-6" placeholder="Repetir Password" runat="server"></asp:TextBox><asp:CompareValidator ID="CompareValidator1" ControlToCompare="txtClave" ControlToValidate="txtClaveRepeat" runat="server" ErrorMessage="* Las claves no coinciden"></asp:CompareValidator>
                    </div>

                    <div class="form-group">
                        <asp:Button ID="btnCambiar" CssClass="btn btn-primary btn-block col-md-6" OnClick="btnCambiar_Click" runat="server" Text="Cambiar password" />
                    </div>
                    <!-- end login-content -->
                </div>
                <!-- end login -->
            </asp:View>
            <asp:View ID="View2" runat="server">
                <div class="form-group">
                    <asp:Label ID="lbl_aviso" CssClass="label-danger" runat="server" Text=""></asp:Label>
                </div>
            </asp:View>
        </asp:MultiView>

    </div>
</asp:Content>

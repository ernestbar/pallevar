<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="adm_drivers_documentos.aspx.cs" Inherits="GoChasquiAdmin.adm_drivers_documentos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }

        function abrirAdjunto(url) {
            window.open(url, '_target')
        }

        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgImagen.ClientID%>').prop('src', e.target.result)
                        .width(300)
                        .height(300);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsDocumentoDriver" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaDocumentoDriverXDriverTodos">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdDriver" Name="Id_driver" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="lblIdUsuario" Name="Id_usuario" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsTipoDocumento" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaTipoDocumentoTodos">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="Id_usuario" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblIdDriver" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="lblIdTipoDocumento" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="lblIdUsuario" runat="server" Text="" Visible="false"></asp:Label>
    <div id="content" class="content">
        <!-- begin page-header -->
        <h1 class="page-header">Documentos <small>del Driver</small></h1>
        <!-- end page-header -->
        <!-- begin panel -->
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <div class="form-group row m-b-15">
                    <asp:Button ID="btnNuevo" class="btn btn-success col-form-label col-md-3" OnClick="btnNuevo_Click" runat="server" Text="Nuevo Documento" />
                </div>
                <div class="panel panel-inverse">
                    <!-- begin panel-heading -->
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-redo"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">Roles</h4>
                    </div>
                    <!-- end panel-heading -->
                    <div class="table-responsive">
                        <!-- begin panel-body -->
                        <div class="panel-body">
                            <table id="data-table-default" class="table table-striped table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <td style="width: 5%; text-align: center;">ID</td>
                                        <td style="width: 70%; text-align: center;">NOMBRE</td>
                                        <td style="width: 5%; text-align: center;">ACTIVO</td>
                                        <td style="width: 10%; text-align: center;" data-orderable="false"></td>
                                        <td style="width: 10%; text-align: center;" data-orderable="false"></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="Repeater1" DataSourceID="odsDocumentoDriver" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("id_tipodocumento") %></td>
                                                <td><%# Eval("nombre_documento") %></td>
                                                <td style="text-align: center; vertical-align: middle; padding: 2px">
                                                    <input type="checkbox" <%# Convert.ToBoolean(Eval("activo")) ? "checked" : "" %> onclick="return false;" onkeydown="return false;" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAsignar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_tipodocumento") %>' OnClick="btnAsignar_Click" runat="server" Text="Asignar/Quitar" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnEditar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_tipodocumento") %>' OnClick="btnEditar_Click" runat="server" Text="Editar" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </asp:View>
            <asp:View ID="View2" runat="server">
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Tipo de Documento:</label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="ddlTipoDocumento" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsTipoDocumento" DataTextField="nombre" DataValueField="id_tipodocumento" runat="server"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Seleccionar Imagen:</label>
                    <div class="col-md-3">
                        <asp:FileUpload ID="fuArchivo" class="form-control m-b-5" runat="server" onchange="ImagePreview(this);"/>
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <label class="col-form-label col-md-3">Imagen:</label>
                    <div class="col-md-3">
                        <asp:Image ID="imgImagen" runat="server" Width="300" Height="300" />
                        <asp:Button ID="btnVer" class="btn btn-green col-md-3" runat="server" Text="Ver" OnClick="btnVer_Click" />
                    </div>
                </div>
                <div class="form-group row m-b-15">
                    <asp:Button ID="btnRegresar" class="btn btn-primary col-md-3" OnClick="btnRegresar_Click" runat="server" Text="Volver" />
                    <div class="col-md-9">
                        <asp:Button ID="btnGuardar" class="btn btn-primary col-md-3" OnClick="btnGuardar_Click" runat="server" Text="Guardar" />
                    </div>
                </div>
            </asp:View>
        </asp:MultiView>
        <div class="form-group row m-b-15">
            <asp:Button ID="btnCancelar" class="btn btn-primary col-form-label col-md-3" OnClick="btnCancelar_Click" runat="server" Text="Cancelar" />
        </div>
    </div>
    </small>
</asp:Content>

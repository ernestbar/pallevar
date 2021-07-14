<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="adm_roles.aspx.cs" Inherits="GoChasquiAdmin.adm_roles" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function mostrarMensaje(mensaje) {
            alert(mensaje);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsUsuarios" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaUsuarioRoles">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuarioRol" Name="id_usuario" DefaultValue="1" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsListaRoles" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaRolTodos">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuarioRol" Name="id_usuario" DefaultValue="1" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblIdUsuarioRol" runat="server" Text="" Visible="false"></asp:Label>
    <asp:Label ID="lblIdUsuario" runat="server" Text="" Visible="false"></asp:Label>
    <div id="content" class="content">
        <asp:Label ID="lblAviso" runat="server" Text=""></asp:Label>
        <!-- begin page-header -->
        <h1 class="page-header">Roles del usuario <small>
            <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label></small></h1>
        <!-- end page-header -->
        <!-- begin panel -->
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <div class="form-group row m-b-15">
                    <asp:Button ID="btnNuevo" class="btn btn-success col-form-label col-md-3" OnClick="btnNuevo_Click" runat="server" Text="Nuevo Rol" />
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
                                        <td style="width: 10%; text-align: center;">ID</td>
                                        <td style="width: 70%; text-align: center;">ROL</td>
                                        <td style="width: 10%; text-align: center;">ACTIVO</td>
                                        <td style="width: 10%; text-align: center;" data-orderable="false"></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="Repeater1" DataSourceID="odsUsuarios" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("id_rol") %></td>
                                                <td><%# Eval("nombre_rol") %></td>
                                                <td style="text-align: center; vertical-align: middle; padding: 2px">
                                                    <input type="checkbox" <%# Convert.ToBoolean(Eval("activo")) ? "checked" : "" %> onclick="return false;" onkeydown="return false;" />
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAsignar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_rol") %>' OnClick="btnAsignar_Click" runat="server" Text="Asignar/Quitar" />
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
                <div class="col-lg-6">
                    <asp:Label ID="lblIdUsrCP" runat="server" Text="" Visible="false"></asp:Label>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Nuevo Rol:</label>
                        <div class="col-md-3">
                            <asp:DropDownList ID="ddlRoles" class="form-control m-b-5" DataSourceID="odsListaRoles" DataTextField="nombre" DataValueField="id_rol" runat="server"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <asp:Button ID="btnRegresar" class="btn btn-primary col-form-label col-md-3" OnClick="btnRegresar_Click" runat="server" Text="Volver" />

                        <div class="col-md-9">
                            <asp:Button ID="btnGuardarRol" class="btn btn-primary" OnClick="btnGuardarRol_Click" runat="server" Text="Guardar" />
                        </div>
                    </div>
                </div>
            </asp:View>
        </asp:MultiView>
        <div class="form-group row m-b-15">
            <asp:Button ID="btnCancelar" class="btn btn-primary col-form-label col-md-3" OnClick="btnCancelar_Click" runat="server" Text="Cancelar" />
        </div>
    </div>
</asp:Content>

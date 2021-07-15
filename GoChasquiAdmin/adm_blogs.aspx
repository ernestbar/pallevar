<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="adm_blogs.aspx.cs" Inherits="GoChasquiAdmin.adm_blogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsBlogs" runat="server" TypeName="GoChasquiAdmin.Clases.Blogs" SelectMethod="lista_blog_todos">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="id_usuario" DefaultValue="1" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:Label ID="lblIdBlog" runat="server" Text="0" Visible="false"></asp:Label>
    <asp:Label ID="lblIdPedido" runat="server" Text="0" Visible="false"></asp:Label>
    <asp:Label ID="lblIdUsuario" runat="server" Text="1" Visible="false"></asp:Label>
    <div id="content" class="content">
        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <!-- begin page-header -->
                <h1 class="page-header">Administrador <small>de blogs</small></h1>
                <!-- end page-header -->
                <asp:Label ID="lblAviso" runat="server" Text=""></asp:Label>
                <!-- begin panel -->
                <div class="panel panel-inverse">
                    <!-- begin panel-heading -->
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-redo"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">Usuarios registrados</h4>
                    </div>
                    <!-- end panel-heading -->
                    <asp:Button ID="btnNuevo" runat="server" CssClass="btn btn-success" OnClick="btnNuevo_Click" Text="NUEVO BLOG" />
                    <div class="table-responsive">
                        <!-- begin panel-body -->
                        <div class="panel-body">
                            <table id="data-table-default" class="table table-striped table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <td>TITULO</td>
                                        <td>FECHA INI.</td>
                                        <td>FECHA FIN</td>
                                        <td>FOTO</td>
                                        <td>ACTIVO</td>
                                        <td>DESCRIPCION</td>
                                        <td>OPCIONES</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="Repeater1" DataSourceID="odsBlogs" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("titulo") %></td>
                                                <td><%# Eval("fecha_publicacion") %></td>
                                                <td><%# Eval("fecha_termino") %></td>
                                                <td><asp:Image runat="server" Width="70" ImageUrl='<%# string.Concat ("Img_blog/",Eval("id_blog"),"/", Eval("url_foto")) %>'></asp:Image></td>
                                                <td><%# Eval("activo") %></td>
                                                <td><%# Eval("descripcion") %></td>
                                                <td>
                                                    <asp:Button ID="btnEditar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_blog") %>' OnClick="btnEditar_Click" runat="server" Text="Editar" />
                                                    <asp:Button ID="btnEliminar" class="btn-sm btn-info" CommandArgument='<%# Eval("id_blog") %>' OnClick="btnEliminar_Click" runat="server" Text="Eliminar" />
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
                <div class="col-lg-12">
                    <asp:Label ID="lblIdUsrCP" runat="server" Text="" Visible="false"></asp:Label>
                    <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Titulo:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtTitulo" class="form-control m-b-5" runat="server"></asp:TextBox>
                        </div>
                    </div>
                      <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Descripcion:</label>
                        <div class="col-md-3">
                            <asp:TextBox ID="txtDescripcion" TextMode="MultiLine" class="form-control m-b-5" runat="server"></asp:TextBox>
                        </div>
                    </div>
                     <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Fecha Publicacion:</label>
                        <div class="col-md-3">
                            <input id="fecha_ini" class="form-control" style="background:#ecf1fa" type="date" required>
                            <asp:HiddenField ID="hfFechaIni" runat="server" />
                        </div>
                    </div>
                     <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Fecha Finalizacion:</label>
                        <div class="col-md-3">
                            <input id="fecha_fin" class="form-control" style="background:#ecf1fa" type="date" required>
                            <asp:HiddenField ID="hfFechaFin" runat="server" />
                        </div>
                    </div>
                     <div class="form-group row m-b-15">
                        <label class="col-form-label col-md-3">Foto:</label>
                        <div class="col-md-3">
                             <asp:FileUpload ID="fuImagen" class="form-control m-b-5" runat="server" AllowMultiple="True" />
                        </div>
                    </div>
                    <div class="form-group row m-b-15">
                        <asp:Button ID="btnGuardar" class="btn btn-primary col-form-label col-md-3" OnClientClick="recuperarFechas()" OnClick="btnGuardar_Click" runat="server" Text="Guardar" />

                        <div class="col-md-9">
                            <asp:Button ID="btnVolver" class="btn btn-primary" OnClick="btnVolver_Click" runat="server" Text="Volver" />
                        </div>
                    </div>
                </div>
            </asp:View>
            
        </asp:MultiView>

    </div>

    <script type="text/javascript">

    function recuperarFechas() {

		document.getElementById('<%=hfFechaIni.ClientID%>').value = document.getElementById('fecha_ini').value;
        document.getElementById('<%=hfFechaFin.ClientID%>').value = document.getElementById('fecha_fin').value;
		}

        <%--function recuperarFechaLlegada() {

            document.getElementById('<%=hfFechaRetorno.ClientID%>').value = document.getElementById('fecha_regreso').value;
    }--%>
    </script>
</asp:Content>

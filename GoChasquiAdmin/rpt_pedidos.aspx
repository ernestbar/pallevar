<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="rpt_pedidos.aspx.cs" Inherits="GoChasquiAdmin.rpt_pedidos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(function () {
            $("[id*=txtFechaInicial]").datepicker({
                dateFormat: 'dd/mm/yy'
            });

            $("[id*=txtFechaFinal]").datepicker({
                dateFormat: 'dd/mm/yy'
            });
        });

        function mostrarFormReporte(url) {
            window.open(url, '_blank');
        }
    </script>

    <style type="text/css">
        input[type=text]
        {
            margin-right:5px;
            position:relative;
            top:-2px
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ObjectDataSource ID="odsTipoEstado" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaTipoEstadoTodos" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="Id_usuario" PropertyName="Text" Type="Int32" DefaultValue="10" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsCiudad" runat="server" TypeName="GoChasquiAdmin.GCws1.WSGoChasquiClient" SelectMethod="ListaCiudadTodos" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblIdUsuario" Name="Id_usuario" PropertyName="Text" Type="Int32" DefaultValue="4" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="lblIdUsuario" runat="server" Text="0" Visible="false"></asp:Label>
    <!-- begin #content -->
    <div id="content" class="content">
        <!-- begin row -->
        <div class="row">
            <!-- begin col-10 -->
            <div class="col-lg-12">
                <div class="panel panel-inverse">
                    <!-- begin panel-heading -->
                    <div class="panel-heading">
                        <div class="panel-heading-btn">
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-default" data-click="panel-expand"><i class="fa fa-expand"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-success" data-click="panel-reload"><i class="fa fa-redo"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-warning" data-click="panel-collapse"><i class="fa fa-minus"></i></a>
                            <a href="javascript:;" class="btn btn-xs btn-icon btn-circle btn-danger" data-click="panel-remove"><i class="fa fa-times"></i></a>
                        </div>
                        <h4 class="panel-title">Reporte de Pedidos</h4>
                    </div>
                    <!-- end panel-heading -->
                    <!-- begin panel-body -->
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-3">
                                <strong>Fecha Inicial:</strong><asp:TextBox ID="txtFechaInicial" runat="server" class="form-control"></asp:TextBox>
                            </div>
                            <div class="col-3">
                                <strong>Fecha Final:</strong><asp:TextBox ID="txtFechaFinal" runat="server" class="form-control"></asp:TextBox>
                            </div>
                            <div class="col-3">
                                <strong>Seleccione un Estado: </strong>
                                <asp:DropDownList ID="ddlTipoEstado" class="btn btn-light dropdown-toggle" DataSourceID="odsTipoEstado" DataTextField="nombre" DataValueField="id_tipoestado" runat="server"></asp:DropDownList>
                            </div>
                            <div class="col-3">
                                <strong>Seleccione una Ciudad: </strong>
                                <asp:DropDownList ID="ddlCiudad" class="btn btn-light btn-sm dropdown-toggle" DataSourceID="odsCiudad" DataTextField="nombre" DataValueField="id_ciudad" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <!-- end panel-body -->
                    </div>
                    <div class="panel-footer">
                        <asp:LinkButton ID="btnImprimir" runat="server" OnClick="btnImprimir_Click" CssClass="btn btn-primary" class="form-control"><i class="fa fa-print"></i> Imprimir</asp:LinkButton>
                    </div>
                </div>
                <!-- end col-10 -->
            </div>
            <!-- end row -->
        </div>
    </div>
    <!-- end #content -->
</asp:Content>

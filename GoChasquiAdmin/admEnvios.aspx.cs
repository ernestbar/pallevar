using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class admEnvios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Session["user_email"] == null)
                    {
                        Response.Redirect("login_usuario.aspx?op=admincli");
                    }
                    else
                    {
                        GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                        var usuario = obj.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                        lblIdUsuario.Text = usuario.id_usuario.ToString();
                        var cliente_usuario = obj.ListaClienteUsuarioXUsuario(usuario.id_usuario);
                        lblClienteID.Text = cliente_usuario.First().id_cliente.ToString();
                        ObtieneCliente(cliente_usuario.First().id_cliente);
                        ddlTipoEstado.SelectedValue = "1";
                        lblIdTipoEstado.Text = ddlTipoEstado.SelectedValue;
                        odsPedidos.DataBind();
                        MultiView1.ActiveViewIndex = 0;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnDetalles_Click(object sender, EventArgs e)
        {
            try
            {
                int IdPedido = 0;
                Button btn = (Button)sender;
                IdPedido = int.Parse(btn.CommandArgument);
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                GCws1.Pedido pedido = obj.ListaPedidoIndividual(IdPedido);
                lblIdPedido.Text = IdPedido.ToString();

                // Transporte
                if (pedido.id_tiposervicio == 1)
                {
                    // Cargos
                    List<GCws1.PedidoCargoExtra> listaPedidoCargoExtra = obj.ListaPedidoCargoExtraXPedido(IdPedido).ToList();
                    // Ruta
                    GCws1.Ruta ruta = obj.ListaRutaXPedido(IdPedido);

                    decimal costo = 0;

                    // Costo
                    costo = 0;
                    foreach (GCws1.PedidoCargoExtra pedidoCargoExtra in listaPedidoCargoExtra)
                    {
                        if (pedidoCargoExtra.id_tipocargoextra == 2) // Costo Transporte
                        {
                            costo = pedidoCargoExtra.monto;
                        }
                    }
                    lblTranspCosto.Text = costo.ToString();

                    // Ruta
                    lblTranspOrigen.Text = ruta.direccion1;
                    lblTranspDestino.Text = ruta.direccion2;
                    lblTranspDistancia.Text = ruta.distancia_km_aprox.ToString();

                    MultiView1.ActiveViewIndex = 1;
                }

                // Restaurante
                if (pedido.id_tiposervicio == 2)
                {
                    // Cargos
                    List<GCws1.PedidoCargoExtra> listaPedidoCargoExtra = obj.ListaPedidoCargoExtraXPedido(IdPedido).ToList();
                    // Ruta
                    GCws1.Ruta ruta = obj.ListaRutaXPedido(IdPedido);

                    decimal costo = 0;

                    // Costo
                    costo = 0;
                    foreach (GCws1.PedidoCargoExtra pedidoCargoExtra in listaPedidoCargoExtra)
                    {
                        if (pedidoCargoExtra.id_tipocargoextra == 1) // Gasto Envío
                        {
                            costo = pedidoCargoExtra.monto;
                        }
                    }

                    lblTotalProd.Text = pedido.monto.ToString();
                    lblCostoDelivery.Text = costo.ToString();
                    lblTotalPagar.Text = (pedido.monto + costo).ToString();

                    MultiView1.ActiveViewIndex = 2;
                }

                // Envios
                if (pedido.id_tiposervicio == 6)
                {
                    // Pedido Envío
                    GCws1.PedidoEnvio pedidoEnvio = obj.ListaPedidoEnvioXPedido(IdPedido);
                    // Cargos
                    List<GCws1.PedidoCargoExtra> listaPedidoCargoExtra = obj.ListaPedidoCargoExtraXPedido(IdPedido).ToList();
                    // Ruta
                    GCws1.Ruta ruta = obj.ListaRutaXPedido(IdPedido);

                    decimal costo = 0;

                    // Costo
                    costo = 0;
                    foreach (GCws1.PedidoCargoExtra pedidoCargoExtra in listaPedidoCargoExtra)
                    {
                        if (pedidoCargoExtra.id_tipocargoextra == 3) // Costo Envío
                        {
                            costo = pedidoCargoExtra.monto;
                        }
                    }

                    // ***** Carga Datos Principales
                    lblEnvCosto.Text = costo.ToString();
                    lblEnvOrigen.Text = ruta.direccion1;
                    lblEnvDestino.Text = ruta.direccion2;
                    lblEnvDistancia.Text = ruta.distancia_km_aprox.ToString();

                    // ***** Carga Datos Envio
                    lblEnvNombreDestinatario.Text = pedidoEnvio.nombre_destinatario;
                    lblEnvCelularDestinatario.Text = pedidoEnvio.celular_destinatario;
                    lblEnvContenido.Text = pedidoEnvio.contenido;
                    lblEnvAlto.Text = pedidoEnvio.alto.ToString();
                    lblEnvAncho.Text = pedidoEnvio.ancho.ToString();
                    lblEnvRecomendaciones.Text = pedidoEnvio.recomendaciones;

                    MultiView1.ActiveViewIndex = 3;
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void ddlCliente_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                lblClienteID.Text = ddlCliente.SelectedValue;
                ObtieneCliente(int.Parse(ddlCliente.SelectedValue));
                odsTipoEstado.DataBind();
                odsPedidos.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void ddlTipoEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblIdTipoEstado.Text = ddlTipoEstado.SelectedValue;
            odsPedidos.DataBind();
        }

        protected void btnVolverTransporte_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnVolverEnvio_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        private void ObtieneCliente(int Id_Cliente)
        {
            try
            {
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                var cliente = obj.ListaClienteIndividual(Id_Cliente);
                lblIdTipoNegocio.Text = cliente.id_tiponegocio.ToString();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
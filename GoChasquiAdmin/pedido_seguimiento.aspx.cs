using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class pedido_seguimiento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
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
                    MultiView1.ActiveViewIndex = 0;
                }
            }
        }

        protected void btnDetalles_Click(object sender, EventArgs e)
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
                bool PropuestaAceptada = false;
                var pedidoPropuesta = obj.ListaPedidoPropuestaAceptada(IdPedido);

                // Pedido Propuesta
                if (pedidoPropuesta.id_estadopropuesta == 2)
                {
                    PropuestaAceptada = true;
                }
                else
                {
                    PropuestaAceptada = false;
                }

                // Controles
                if (!pedido.pagado || !pedido.entregado)
                {
                    if (PropuestaAceptada)
                    {
                        btnPedidoPropuesta.Enabled = false;
                    }
                    else
                    {
                        btnPedidoPropuesta.Enabled = true;
                    }
                }
                else
                {
                    btnPedidoPropuesta.Enabled = false;
                }

                if (pedido.id_tipoestado == 1)
                {
                    btnCancelarTransporte.Enabled = true;
                }
                else
                {
                    btnCancelarTransporte.Enabled = false;
                }

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
                if (pedido.id_tipoestado == 1)
                {
                    btnCancelar.Enabled = true;
                }
                else
                {
                    btnCancelar.Enabled = false;
                }

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
                if (pedido.id_tipoestado == 1)
                {
                    btnCancelarEnvio.Enabled = true;
                }
                else
                {
                    btnCancelarEnvio.Enabled = false;
                }

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

        protected void btnPedidoPropuesta_Click(object sender, EventArgs e)
        {
            int idPedido = 0;
            int.TryParse(lblIdPedido.Text, out idPedido);
            bool PropuestaAceptada = false;

            GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
            GCws1.Pedido pedido = obj.ListaPedidoIndividual(idPedido);
            GCws1.PedidoPropuesta pedidoPropuesta = obj.ListaPedidoPropuestaAceptada(idPedido);

            // Pedido Propuesta
            if (pedidoPropuesta.id_estadopropuesta == 2)
            {
                PropuestaAceptada = true;
            }
            else
            {
                PropuestaAceptada = false;
            }

            if (pedido.pagado || pedido.entregado)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El pedido ya fue entregado');", true);
                return;
            }

            if (PropuestaAceptada)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El pedido ya tiene una propuesta aceptada');", true);
                return;
            }

            Response.Redirect("~/transporte_propuesta_driver.aspx?Id_pedido=" + idPedido);
        }

        protected void btnVolverTransporte_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnCancelarTransporte_Click(object sender, EventArgs e)
        {
            CancelarPedido();
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            CancelarPedido();
        }

        protected void btnVolverEnvio_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnCancelarEnvio_Click(object sender, EventArgs e)
        {
            CancelarPedido();
        }

        private void CancelarPedido()
        {
            try
            {
                int idPedido = 0;
                int.TryParse(lblIdPedido.Text, out idPedido);
                int IdUsuario = Session["id_usuario"] == null ? 0 : Convert.ToInt32(Session["id_usuario"]);

                GCws1.WSGoChasquiClient goch = new GCws1.WSGoChasquiClient();
                GCws1.Pedido pedido = goch.ActualizarPedidoEstado(IdUsuario, idPedido, 11); // Cancelado Usuario

                if (pedido.error == "")
                {
                    odsPedidos.DataBind();
                    rptrPedidos.DataBind();
                    MultiView1.ActiveViewIndex = 0;
                }
                else
                {
                    lblAviso.Text = pedido.error;
                }

            }
            catch (Exception ex)
            {
                lblAviso.Text = ex.Message;
            }
        }
    }
}
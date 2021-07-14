using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class transporte_propuesta_driver : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    int IdPedido = Request.QueryString["Id_pedido"] == null ? 0 : Convert.ToInt32(Request.QueryString["Id_pedido"]);
                    lblIdPedido.Text = IdPedido.ToString();

                    // Mostrar mensaje si existe
                    string mensaje = Session["MENSAJE"] == null ? "" : Session["MENSAJE"].ToString();
                    if (mensaje != "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + mensaje + "');", true);
                        Session["MENSAJE"] = "";
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            int IdPedido = lblIdPedido.Text == "" ? 0 : Convert.ToInt32(lblIdPedido.Text);
            Response.Redirect("~/transporte_propuesta_driver.aspx?Id_pedido=" + IdPedido);
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                int IdPedidoPropuesta = 0;
                Button obj = (Button)sender;
                IdPedidoPropuesta = int.Parse(obj.CommandArgument);
                string error = "";
                int IdUsuario = Session["id_usuario"] == null ? 0 : Convert.ToInt32(Session["id_usuario"]);

                GCws1.WSGoChasquiClient goch = new GCws1.WSGoChasquiClient();
                GCws1.PedidoPropuesta pedidoPropuesta = goch.ActualizarPedidoPropuestaEstado(IdUsuario, IdPedidoPropuesta, 2); // Aceptado
                error += pedidoPropuesta.error;

                if (error == "")
                {
                    Session["MENSAJE"] = "Se aceptó la propuesta";
                    Response.Redirect("~/home.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('No se pudo aceptar correctamente la propuesta');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnRechazar_Click(object sender, EventArgs e)
        {
            try
            {
                int IdPedidoPropuesta = 0;
                Button obj = (Button)sender;
                IdPedidoPropuesta = int.Parse(obj.CommandArgument);
                string error = "";
                int IdUsuario = Session["id_usuario"] == null ? 0 : Convert.ToInt32(Session["id_usuario"]);

                GCws1.WSGoChasquiClient goch = new GCws1.WSGoChasquiClient();
                GCws1.PedidoPropuesta pedidoPropuesta = goch.ActualizarPedidoPropuestaEstado(IdUsuario, IdPedidoPropuesta, 3); // Rechazado
                error += pedidoPropuesta.error;

                if (error == "")
                {
                    Session["MENSAJE"] = "Se rechazó la propuesta";
                    Response.Redirect("~/home.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('No se pudo rechazar correctamente la propuesta');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
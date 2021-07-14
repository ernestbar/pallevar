using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class rpt_pedidos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Session["id_usuario"] == null)
                    {
                        Response.Redirect("Default.aspx");
                    }
                    else
                    {
                        txtFechaInicial.Attributes.Add("readonly", "readonly");
                        txtFechaFinal.Attributes.Add("readonly", "readonly");
                        txtFechaInicial.Text = DateTime.Today.ToString("dd/MM/yyyy");
                        txtFechaFinal.Text = DateTime.Today.ToString("dd/MM/yyyy");
                        lblIdUsuario.Text = Session["id_usuario"].ToString();
                        ddlCiudad.SelectedValue = "4";
                        ddlTipoEstado.SelectedValue = "10";
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlCiudad_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnImprimir_Click(object sender, EventArgs e)
        {
            // Mostrar reporte
            Session.Add("REPORTE", "Pedido");
            Session.Add("FECHA_INI", Convert.ToDateTime(txtFechaInicial.Text));
            Session.Add("FECHA_FIN", Convert.ToDateTime(txtFechaFinal.Text));
            Session.Add("ID_TIPOESTADO", ddlTipoEstado.SelectedValue);
            Session.Add("ID_CIUDAD", ddlCiudad.SelectedValue);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarFormReporte", "mostrarFormReporte('" + Page.ResolveUrl("~/Reporte.aspx") + "');", true);
        }
    }
}
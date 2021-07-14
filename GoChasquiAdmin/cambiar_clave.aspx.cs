using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class cambiar_clave : System.Web.UI.Page
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
                        MultiView1.ActiveViewIndex = 0;
                        GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                        var usuario = obj.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                        lblIdUsuario.Text = usuario.id_usuario.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnCambiar_Click(object sender, EventArgs e)
        {
            try
            {
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                var cambio = obj.CambiarUsuarioClave(int.Parse(lblIdUsuario.Text), int.Parse(lblIdUsuario.Text), txtClave.Text);
                MultiView1.ActiveViewIndex = 1;
                if (cambio.error == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Su clave se cambio correctamente!!!');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + cambio.error + "');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
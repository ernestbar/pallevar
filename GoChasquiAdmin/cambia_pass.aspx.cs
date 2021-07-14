using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class cambia_pass : System.Web.UI.Page
    {
        static string hash = "";
        static string id_usuario = "";
        static string id_reset = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    MultiView1.ActiveViewIndex = 0;
                    string valor = Request.QueryString["seg"].ToString();
                    string[] datos = valor.Split('|');
                    GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                    // Parámetros
                    GCws1.Parametro parametro = obj.ListaParametroIndividual();
                    lblAsistencia1.Text = "Si requiere asistencia, puede comunicarse al " + parametro.celular_cc;
                    lblAsistencia2.Text = lblAsistencia1.Text;
                    //   
                    hash = datos[0];
                    id_usuario = datos[1];
                    id_reset = datos[2];
                    string url = obj.ListaPasswordResetIndividual(int.Parse(id_reset)).url;
                    bool procesado = obj.ListaPasswordResetIndividual(int.Parse(id_reset)).procesado;
                    bool activo = obj.ListaPasswordResetIndividual(int.Parse(id_reset)).activo;
                    if (procesado == true || activo == false)
                    {
                        MultiView1.ActiveViewIndex = 2;
                    }
                    else
                    {
                        if (hash == url)
                        {
                            txtPassword.Focus();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Su link caduco o sus datos no son correctos, porfavor solicite otro reseteo');", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            try
            {
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                if (obj.CambiarUsuarioClave(int.Parse(id_usuario), int.Parse(id_usuario), txtPassword.Text).error == "")
                {
                    if (obj.ActualizarPasswordReset(int.Parse(id_usuario), int.Parse(id_reset), int.Parse(id_usuario), txtPassword.Text, "", hash, false, true, DateTime.Now).error == "")
                    {
                        MultiView1.ActiveViewIndex = 1;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
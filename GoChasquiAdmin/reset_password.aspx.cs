using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
namespace GoChasquiAdmin
{
    public partial class reset_password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    MultiView1.ActiveViewIndex = 0;
                    GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                    // Parámetros
                    GCws1.Parametro parametro = obj.ListaParametroIndividual();
                    lblAsistencia.Text = "Si requiere asistencia, puede comunicarse al " + parametro.celular_cc;
                    //   
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
                if (obj.ListaUsuarioIndividual_x_Email(txtEmail.Text).id_usuario > 0)
                {
                    int id_usuario = obj.ListaUsuarioIndividual_x_Email(txtEmail.Text).id_usuario;

                    string hash = random_token.Instancia().Generar(32);
                    string host = Request.Url.GetLeftPart(UriPartial.Authority);
                    int id_reset = obj.InsertarPasswordReset(1, 0, id_usuario, "", "", hash, true, false, DateTime.Now).id_passwordreset;
                    if (id_reset > 0)
                    {
                        MultiView1.ActiveViewIndex = 1;
                        string link = host + "/" + "cambia_pass.aspx?seg=" + hash + "|" + id_usuario.ToString() + "|" + id_reset.ToString();
                        enviar_correo objC = new enviar_correo();
                        string resultado = objC.enviar(txtEmail.Text, "Reseteo de contraseña", "Estimado usuario usted puede realizar el reseteo de su contraseña en este link: " + link, "");
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('En estos momento no podemos procesar tu solicitud!!!');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El correo proporcionado, no pertenece a un usuario reguistrado en nuestro sistema!');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace GoChasquiAdmin
{
    public partial class actualizar_foto_cliente : System.Web.UI.Page
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
                        var cli = obj.ListaClienteUsuarioXUsuario(usuario.id_usuario);
                        lblClienteID.Text = cli.First().id_cliente.ToString();
                        ddlCliente.Items.Clear();
                        odsClienteUsuario.DataBind();
                        ddlCliente.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnGrabar_Click(object sender, EventArgs e)
        {
            try
            {
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                if (fuImagen.HasFile)
                {
                    string Ruta = Server.MapPath("~/Img_cliente/" + ddlCliente.SelectedValue + "/");
                    if (!Directory.Exists(Ruta))
                    {
                        Directory.CreateDirectory(Ruta);
                    }
                    string archivo = fuImagen.FileName;
                    string url = "Img_cliente/" + ddlCliente.SelectedValue + "/" + archivo;
                    fuImagen.PostedFile.SaveAs(Ruta + archivo);
                    var foto = obj.InsertarMultimediaCliente(int.Parse(lblIdUsuario.Text), 0, 1, int.Parse(ddlCliente.SelectedValue), fuImagen.FileName, url, true, DateTime.Now, DateTime.Now);
                    if (foto.id_multimediacliente > 0)
                    {
                        Repeater2.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void ddlCliente_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblClienteID.Text = ddlCliente.SelectedValue;
        }
    }
}
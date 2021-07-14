using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class adm_usuarios : System.Web.UI.Page
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
                        GCws1.WSGoChasquiClient obj1 = new GCws1.WSGoChasquiClient();
                        var usuario = obj1.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                        lblIdUsuario.Text = usuario.id_usuario.ToString();
                        MultiView1.ActiveViewIndex = 0;

                        int i = 0;
                        for (i = 0; i <= 31; i++)
                        {
                            ListItem dias = new ListItem();
                            if (i == 0)
                            { dias.Text = "Dia"; }
                            else { dias.Text = i.ToString(); }

                            ddlDia.Items.Insert(i, dias);
                        }
                        int m = 0;
                        for (m = 0; m <= 12; m++)
                        {
                            ListItem meses = new ListItem();
                            if (m == 0)
                            { meses.Text = "Mes"; }
                            else { meses.Text = m.ToString(); }
                            ddlMes.Items.Insert(m, meses);
                        }
                        int a = 0;
                        for (a = 0; a <= 80; a++)
                        {
                            ListItem anios = new ListItem();
                            if (a == 0)
                            { anios.Text = "Años"; }
                            else { anios.Text = (DateTime.Now.Year + 1 - a).ToString(); }
                            ddlAnio.Items.Insert(a, anios);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnRoles_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            Session["id_usuariorol"] = id;
            Session["id_usuario"] = lblIdUsuario.Text;
            Response.Redirect("adm_roles.aspx");
        }

        protected void btnResetPass_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            lblIdUsrCP.Text = id;
            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnEstado_Click(object sender, EventArgs e)
        {
            try
            {
                string id = "";
                Button obj = (Button)sender;
                id = obj.CommandArgument.ToString();
                GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();
                objU.EliminarUsuario(int.Parse(lblIdUsuario.Text), int.Parse(id));
                Repeater1.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnCambiar_Click(object sender, EventArgs e)
        {
            try
            {
                GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();

                if (objU.CambiarUsuarioClave(int.Parse(lblIdUsuario.Text), int.Parse(lblIdUsrCP.Text), txtNewClave.Text).error == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Se cambio el password correctamente');", true);
                    MultiView1.ActiveViewIndex = 0;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Hubo un error comuniquese con el administrador');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                string id = "";
                Button obj = (Button)sender;
                id = obj.CommandArgument.ToString();
                lblIdUsrCP.Text = id;
                GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();
                var usuario = objU.ListaUsuarioIndividual(int.Parse(id));
                if (usuario.id_usuario > 0)
                {
                    MultiView1.ActiveViewIndex = 2;
                    txtNombre.Text = usuario.nombre;
                    txtPaterno.Text = usuario.paterno;
                    txtMaterno.Text = usuario.materno;
                    lblEmail.Text = usuario.email;
                    ddlAnio.SelectedValue = usuario.fecha_nacimiento.Year.ToString();
                    ddlMes.SelectedValue = usuario.fecha_nacimiento.Month.ToString();
                    ddlDia.SelectedValue = usuario.fecha_nacimiento.Day.ToString();
                    txtCelular.Text = usuario.celular;
                    lblActivo.Text = usuario.activo.ToString();
                    lblTokenRedes.Text = usuario.token_redes;
                    lblUrlFoto.Text = usuario.url_foto;
                    lblPass.Text = usuario.clave;
                    ddlCiudad.SelectedValue = usuario.id_ciudad.ToString();
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnCancelar2_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            try
            {
                GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();
                string fecha_nac = ddlDia.SelectedValue + "/" + ddlMes.SelectedValue + "/" + ddlAnio.Text;
                if (objU.ActualizarUsuario(int.Parse(lblIdUsuario.Text), int.Parse(lblIdUsrCP.Text), lblEmail.Text, txtNombre.Text, txtPaterno.Text, txtMaterno.Text, lblPass.Text, bool.Parse(lblActivo.Text), lblUrlFoto.Text, lblTokenRedes.Text, DateTime.Parse(fecha_nac), txtCelular.Text, int.Parse(ddlCiudad.SelectedValue)).error == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El registro se actualizo correctamente');", true);
                    Repeater1.DataBind();
                    MultiView1.ActiveViewIndex = 0;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Hubo un error comuniquese con el administrador');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class usuario_roles : System.Web.UI.Page
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
                        GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();

                        lblIdUsuarioRol.Text = Session["id_usuariorol"].ToString();
                        lblIdUsuario.Text = Session["id_usuario"].ToString();
                        lblEmail.Text = obj.ListaUsuarioIndividual(int.Parse(lblIdUsuarioRol.Text)).email;
                        Repeater1.DataBind();
                        MultiView1.ActiveViewIndex = 0;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnAsignar_Click(object sender, EventArgs e)
        {
            try
            {
                string id = "";
                Button obj = (Button)sender;
                id = obj.CommandArgument.ToString();
                GCws1.WSGoChasquiClient obj_ur = new GCws1.WSGoChasquiClient();
                bool aux = obj_ur.ListaUsuarioRolIndividual(int.Parse(lblIdUsuarioRol.Text), int.Parse(id)).activo;
                bool activo = false;
                if (aux == true)
                    activo = false;
                else
                    activo = true;
                var usuario_rol = obj_ur.ActualizarUsuarioRol(int.Parse(lblIdUsuario.Text), int.Parse(lblIdUsuarioRol.Text), int.Parse(id), activo);
                if (usuario_rol.error == "")
                {
                    Repeater1.DataBind();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + usuario_rol.error + "');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/cliente_usuarios.aspx");
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnGuardarRol_Click(object sender, EventArgs e)
        {
            try
            {
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                var UsuarioRol = obj.InsertarUsuarioRol(int.Parse(lblIdUsuario.Text), int.Parse(lblIdUsuarioRol.Text), int.Parse(ddlRoles.SelectedValue), true);
                if (UsuarioRol.error == "")
                {
                    Repeater1.DataBind();
                    MultiView1.ActiveViewIndex = 0;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + UsuarioRol.error + "');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class cliente_usuarios : System.Web.UI.Page
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

                        lblIdCliente.Text = Session["id_cliente"].ToString();
                        lblIdUsuario.Text = Session["id_usuario"].ToString();
                        Repeater1.DataBind();
                        MultiView1.ActiveViewIndex = 0;

                        int i = 0;
                        for (i = 0; i <= 31; i++)
                        {
                            ListItem dias = new ListItem();
                            if (i == 0)
                            {
                                dias.Text = "Dia";
                            }
                            else
                            {
                                dias.Text = i.ToString();
                            }

                            ddlDia.Items.Insert(i, dias);
                            ddlDesdeDia.Items.Insert(i, dias);
                            ddlHastaDia.Items.Insert(i, dias);
                        }
                        int m = 0;
                        for (m = 0; m <= 12; m++)
                        {
                            ListItem meses = new ListItem();
                            if (m == 0)
                            {
                                meses.Text = "Mes";
                            }
                            else
                            {
                                meses.Text = m.ToString();
                            }
                            ddlMes.Items.Insert(m, meses);
                            ddlDesdeMes.Items.Insert(m, meses);
                            ddlHastaMes.Items.Insert(m, meses);
                        }
                        int a = 0;
                        for (a = 0; a <= 80; a++)
                        {
                            ListItem anios = new ListItem();
                            if (a == 0)
                            {
                                anios.Text = "Años";
                            }
                            else
                            {
                                anios.Text = (DateTime.Now.Year + 1 - a).ToString();
                            }
                            ddlAnio.Items.Insert(a, anios);
                        }

                        for (a = 0; a <= (2051 - DateTime.Now.Year); a++)
                        {
                            ListItem anios = new ListItem();
                            if (a == 0)
                            {
                                anios.Text = "Años";
                            }
                            else
                            {
                                anios.Text = (2050 + 1 - a).ToString();
                            }
                            ddlDesdeAnio.Items.Insert(a, anios);
                            ddlHastaAnio.Items.Insert(a, anios);
                        }
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
                GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();
                objU.EliminarClienteUsuario(int.Parse(lblIdUsuario.Text), int.Parse(id));
                Repeater1.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnRoles_Click(object sender, EventArgs e)
        {
            try
            {
                string id = "";
                Button obj = (Button)sender;
                id = obj.CommandArgument.ToString();
                GCws1.WSGoChasquiClient objCU = new GCws1.WSGoChasquiClient();
                var cliente_usuario = objCU.ListaClienteUsuarioIndividual(int.Parse(id));
                int idUsuario = cliente_usuario.id_usuario;

                Session["id_usuariorol"] = idUsuario; // Id. de Usuario
                Session["id_usuario"] = lblIdUsuario.Text;
                Response.Redirect("usuario_roles.aspx");
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            lblTipoOperacion.Text = "I";
            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                lblTipoOperacion.Text = "U";
                string id = "";
                Button obj = (Button)sender;
                id = obj.CommandArgument.ToString();
                GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();
                var cliente_usuario = objU.ListaClienteUsuarioIndividual(int.Parse(id));
                int idUsuario = cliente_usuario.id_usuario;
                var usuario = objU.ListaUsuarioIndividual(idUsuario);

                if (usuario.id_usuario > 0)
                {
                    MultiView1.ActiveViewIndex = 1;
                    lblIdUs.Text = usuario.id_usuario.ToString();
                    txtEmail.Text = usuario.email;
                    txtNombre.Text = usuario.nombre;
                    txtPaterno.Text = usuario.paterno;
                    txtMaterno.Text = usuario.materno;
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

                ddlDesdeAnio.SelectedValue = cliente_usuario.fecha.Year.ToString();
                ddlDesdeMes.SelectedValue = cliente_usuario.fecha.Month.ToString();
                ddlDesdeDia.SelectedValue = cliente_usuario.fecha.Day.ToString();
                ddlHastaAnio.SelectedValue = cliente_usuario.fecha_fin.Year.ToString();
                ddlHastaMes.SelectedValue = cliente_usuario.fecha_fin.Month.ToString();
                ddlHastaDia.SelectedValue = cliente_usuario.fecha_fin.Day.ToString();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                int idUsuario = 0;
                GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();
                string fecha_nac = ddlDia.SelectedValue + "/" + ddlMes.SelectedValue + "/" + ddlAnio.Text;
                string fecha_desde = ddlDesdeDia.SelectedValue + "/" + ddlDesdeMes.SelectedValue + "/" + ddlDesdeAnio.Text;
                string fecha_hasta = ddlHastaDia.SelectedValue + "/" + ddlHastaMes.SelectedValue + "/" + ddlHastaAnio.Text;
                GCws1.Usuario usuario = new GCws1.Usuario();
                GCws1.ClienteUsuario clienteUsuario = new GCws1.ClienteUsuario();

                if (lblTipoOperacion.Text == "I")
                {
                    usuario = objU.InsertarUsuario(int.Parse(lblIdUsuario.Text), 0, txtEmail.Text, txtNombre.Text, txtPaterno.Text, txtMaterno.Text, "123", true, lblUrlFoto.Text, lblTokenRedes.Text, DateTime.Parse(fecha_nac), txtCelular.Text, int.Parse(ddlCiudad.SelectedValue));
                    if (usuario.error == "")
                    {
                        idUsuario = usuario.id_usuario;
                        clienteUsuario = objU.InsertarClienteUsuario(int.Parse(lblIdUsuario.Text), 0, DateTime.Parse(fecha_desde), DateTime.Parse(fecha_hasta), true, int.Parse(lblIdCliente.Text), idUsuario);
                    }
                }
                else
                {
                    usuario = objU.ActualizarUsuario(int.Parse(lblIdUsuario.Text), int.Parse(lblIdUs.Text), txtEmail.Text, txtNombre.Text, txtPaterno.Text, txtMaterno.Text, lblPass.Text, true, lblUrlFoto.Text, lblTokenRedes.Text, DateTime.Parse(fecha_nac), txtCelular.Text, int.Parse(ddlCiudad.SelectedValue));
                }

                if (usuario.error == "")
                {
                    if (lblTipoOperacion.Text == "I")
                    {
                        if (clienteUsuario.error == "")
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El registro se realizó correctamente');", true);
                            Repeater1.DataBind();
                            MultiView1.ActiveViewIndex = 0;
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Hubo un error comuniquese con el administrador');", true);
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El registro se realizó correctamente');", true);
                        Repeater1.DataBind();
                        MultiView1.ActiveViewIndex = 0;
                    }
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
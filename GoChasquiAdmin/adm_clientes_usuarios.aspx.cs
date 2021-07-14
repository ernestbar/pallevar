using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class adm_clientes_usuarios : System.Web.UI.Page
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
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();
            objU.EliminarClienteUsuario(int.Parse(lblIdUsuario.Text), int.Parse(id));
            Repeater1.DataBind();
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            txtEmail.Text = "";
            txtNombre.Text = "";
            txtPaterno.Text = "";
            txtMaterno.Text = "";
            txtCelular.Text = "";
            MultiView1.ActiveViewIndex = 1;
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

                var usuario = objU.InsertarUsuario(int.Parse(lblIdUsuario.Text), 0, txtEmail.Text, txtNombre.Text, txtPaterno.Text, txtMaterno.Text, "123", true, lblUrlFoto.Text, lblTokenRedes.Text, DateTime.Parse(fecha_nac), txtCelular.Text, int.Parse(ddlCiudad.SelectedValue));

                if (usuario.error == "")
                {
                    idUsuario = usuario.id_usuario;
                    var clienteUsuario = objU.InsertarClienteUsuario(int.Parse(lblIdUsuario.Text), 0, DateTime.Parse(fecha_desde), DateTime.Parse(fecha_hasta), true, int.Parse(lblIdCliente.Text), idUsuario);

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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Hubo un error comuniquese con el administrador');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/adm_clientes.aspx");
        }
    }
}
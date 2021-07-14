using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class registra_usuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
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
                        else { anios.Text = (DateTime.Now.Year - a).ToString(); }
                        ddlAnio.Items.Insert(a, anios);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                string dia = "";
                string mes = "";
                string año = "";

                if (ddlDia.SelectedIndex == 0)
                { dia = "1"; mes = "1"; año = "1900"; }
                else { dia = ddlDia.SelectedValue; }
                if (ddlMes.SelectedIndex == 0)
                { dia = "1"; mes = "1"; año = "1900"; }
                else { mes = ddlMes.SelectedValue; }
                if (ddlAnio.SelectedIndex == 0)
                { dia = "1"; mes = "1"; año = "1900"; }
                else { año = ddlAnio.SelectedValue; }

                DateTime fecha_nac = DateTime.Parse(dia + "/" + mes + "/" + año);


                var resultado = obj.InsertarUsuario(1, 0, txtEmail.Text, txtNombre.Text, txtPaterno.Text, txtMaterno.Text, txtPassword.Text, true, "", "", fecha_nac, txtCelular.Text, int.Parse(ddlCiudad.SelectedValue));
                int id = resultado.id_usuario;
                if (id > 0)
                {
                    Response.Redirect("home.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El correo ingresado ya tiene un usuario');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
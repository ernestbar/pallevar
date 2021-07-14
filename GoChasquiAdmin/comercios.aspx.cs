using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class comercios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (Session["id_usuario"] == null)
                //{
                //    Response.Redirect("home.aspx");
                //}
                //else
                //{
                    lblIdCiudad.Text = Session["id_ciudad"] == null ? "4" : Session["id_ciudad"].ToString();
                    int IdTipoServicio = Request.QueryString["Id_tiposervicio"] == null ? 0 : Convert.ToInt32(Request.QueryString["Id_tiposervicio"]);
                    lblIdTipoNegocio.Text = IdTipoServicio.ToString();

                    switch (IdTipoServicio)
                    {
                        case 3:
                            lblTitulo.Text = "Contamos con los mercados mas exclusivos y solcitados de nuestra cuidad.";
                            break;
                        case 4:
                            lblTitulo.Text = "Contamos con las tiendas mas exclusivas y solcitadas de nuestra cuidad.";
                            break;
                        case 5:
                            lblTitulo.Text = "Contamos con las tiendas de salud mas exclusivas y solcitadas de nuestra cuidad.";
                            break;
                    }
                //}
            }
        }

        protected void btnComprar_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            Session["id_cliente"] = id;
            Response.Redirect("productos_comercio.aspx?Id_tiposervicio=" + lblIdTipoNegocio.Text);
        }
    }
}
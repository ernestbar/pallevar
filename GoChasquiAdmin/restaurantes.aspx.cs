using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class restaurantes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    if (Session["id_usuario"] == null)
            //    {
            //        Response.Redirect("home.aspx");
            //    }
            //    else
            //    {
            //        lblIdCiudad.Text = Session["id_ciudad"] == null ? "" : Session["id_ciudad"].ToString();
            //    }
            //}
        }

        protected void btnComprar_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            Session["id_cliente"] = id;
            Response.Redirect("productos.aspx");
        }
    }
}
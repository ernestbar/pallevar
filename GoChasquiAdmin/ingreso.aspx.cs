using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class ingreso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Ingresar_Click(object sender, EventArgs e)
        {
            if (TextBox1.Text.ToUpper() == "GOCHASQUI")
            {
                Response.Redirect("home.aspx");
            }
        }
    }
}
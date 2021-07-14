using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Mostrar mensaje si existe
                string mensaje = Session["MENSAJE"] == null ? "" : Session["MENSAJE"].ToString();
                if (mensaje != "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + mensaje + "');", true);
                    Session["MENSAJE"] = "";
                }
            }
        }
    }
}
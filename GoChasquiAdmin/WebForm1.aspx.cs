using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Script.Serialization;

namespace GoChasquiAdmin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected string lotesJSON = "[]";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //ddlUrbanizacion.Items.Clear();
                //ddlUrbanizacion.Items.Add(new ListItem("Seleccione una Urbanización", Convert.ToString(0)));
                //foreach (DataRow dRow in urbanizaciones.urbanizacion.ListaActivos().Rows)
                //{
                //    ddlUrbanizacion.Items.Add(new ListItem(Convert.ToString(dRow["nombre"]), Convert.ToString(dRow["id_urbanizacion"])));
                //}
                //ddlUrbanizacion.SelectedValue = "23";
              
            }
        }

        
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class Principal : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["user_img_url"] == null)
                {
                    //Response.Redirect("home.aspx");
                }
                else
                {
                    GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                    var usuario = obj.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                    var roles_admin = obj.ListaUsuarioRolIndividual(usuario.id_usuario, 2);//colocal el ID de ADMINISTRADOR COMERCIO
                    var roles_super_admin = obj.ListaUsuarioRolIndividual(usuario.id_usuario, 1);//colocal el ID de ADMINISTRADOR COMERCIO
                    if (roles_admin.activo == true || roles_super_admin.activo==true)
                    {
                        imgUser.ImageUrl = Session["user_img_url"].ToString();
                        lblUsuario.Text = Session["user_name"].ToString();
                    }
                    else
                    {
                        Response.Redirect("home.aspx");
                    }

                }
            }
        }

        protected void lbtnCerrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("home.aspx");
        }
    }
}
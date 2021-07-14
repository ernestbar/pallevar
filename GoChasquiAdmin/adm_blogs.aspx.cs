using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class adm_blogs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["user_email"] = "ernesto.barron@gmail.com";
                //if (Session["id_usuario"] == null)
                //{
                //    Response.Redirect("~/Default.aspx");
                //}
                //else
                //{
                    GCws1.WSGoChasquiClient obj1 = new GCws1.WSGoChasquiClient();
                    var usuario = obj1.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                    lblIdUsuario.Text = usuario.id_usuario.ToString();
                    MultiView1.ActiveViewIndex = 0;
                //}
            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
                
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            lblIdBlog.Text = id;
            Clases.Blogs obj_b = new Clases.Blogs(int.Parse(id));
            txtTitulo.Text = obj_b.titulo;
            txtDescripcion.Text = obj_b.descripcion;
            hfFechaIni.Value = obj_b.fecha_publicacion.ToString();
            hfFechaFin.Value = obj_b.fecha_publicacion.ToString();
            fecha_ini.Value = obj_b.fecha_publicacion.ToShortDateString();
            MultiView1.ActiveViewIndex = 1;

        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            lblIdBlog.Text = id;
            Clases.Blogs obj_b = new Clases.Blogs("E", int.Parse(id),int.Parse(lblIdUsuario.Text),"","",DateTime.Now, DateTime.Now,"",false, DateTime.Now, int.Parse(lblIdUsuario.Text));
            Repeater1.DataBind();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string fecha_ini = hfFechaIni.Value;
            string fecha_fin = hfFechaFin.Value;
            string url_foto = "";
            if (fuImagen.HasFile)
                url_foto = fuImagen.FileName;



               
            if (lblIdBlog.Text == "")
            {
                Clases.Blogs obj_b = new Clases.Blogs("I", 0, int.Parse(lblIdUsuario.Text), txtTitulo.Text,url_foto,DateTime.Parse(fecha_ini), DateTime.Parse(fecha_fin),txtDescripcion.Text, true, DateTime.Now, int.Parse(lblIdUsuario.Text));
                string[] resultado = obj_b.ABM().Split('|');
                string Id_blog = resultado[2];
                lblAviso.Text = resultado[1];
                if (fuImagen.HasFile)
                {
                    string Ruta = Server.MapPath("~/Img_blog/" + Id_blog + "/");
                    if (!Directory.Exists(Ruta))
                    {
                        Directory.CreateDirectory(Ruta);
                    }
                    string archivo = fuImagen.FileName;
                    fuImagen.PostedFile.SaveAs(Ruta + archivo);
                   
                }
            }
            else
            {
                Clases.Blogs obj_b = new Clases.Blogs("U",int.Parse(lblIdBlog.Text), int.Parse(lblIdUsuario.Text), txtTitulo.Text, url_foto, DateTime.Parse(fecha_ini), DateTime.Parse(fecha_fin), txtDescripcion.Text, true, DateTime.Now, int.Parse(lblIdUsuario.Text));
                string[] resultado = obj_b.ABM().Split('|');
                if (fuImagen.HasFile)
                {
                    string Ruta = Server.MapPath("~/Img_blog/" + lblIdBlog.Text + "/");
                    if (!Directory.Exists(Ruta))
                    {
                        Directory.CreateDirectory(Ruta);
                    }
                    string archivo = fuImagen.FileName;
                    fuImagen.PostedFile.SaveAs(Ruta + archivo);

                }
                lblAviso.Text = resultado[1];
            }
            MultiView1.ActiveViewIndex = 0;
            Repeater1.DataBind();
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            lblIdBlog.Text = "";
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            lblIdBlog.Text = "";
            MultiView1.ActiveViewIndex = 1;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace GoChasquiAdmin
{
    public partial class abmProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Session["user_email"] == null)
                    {
                        Response.Redirect("login_usuario.aspx?op=admincli");
                    }
                    else
                    {
                        GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                        var usuario = obj.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                        lblIdUsuario.Text = usuario.id_usuario.ToString();
                        var cli = obj.ListaClienteUsuarioXUsuario(usuario.id_usuario);
                        lblClienteID.Text = cli.First().id_cliente.ToString();
                        ddlCliente.Items.Clear();
                        odsClienteUsuario.DataBind();
                        ddlCliente.DataBind();
                        lblTipoOperacion.Text = "I";
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnGrabar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["user_email"] == null)
                {
                    Response.Redirect("login_usuario.aspx");
                }
                else
                {
                    GCws1.WSGoChasquiClient cli = new GCws1.WSGoChasquiClient();
                    GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                    GCws1.WSGoChasquiClient usr = new GCws1.WSGoChasquiClient();

                    var cliente = cli.ListaClienteIndividual(int.Parse(lblClienteID.Text));
                    if (cliente.id_tiponegocio == 1 || cliente.id_tiponegocio == 6) // Transporte o Envio
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El tipo de negocio transporte no puede tener productos');", true);
                        return;
                    }

                    var usuario = usr.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                    if (lblTipoOperacion.Text == "I")
                    {
                        var producto = obj.InsertarProducto(usuario.id_usuario, 0, int.Parse(ddlTipoProducto.SelectedValue), txtNombre.Text, txtDescripcion.Text, decimal.Parse(txtPrecio.Text), true, "", DateTime.Now, DateTime.Now, DateTime.Now, 1, decimal.Parse(txtCantidad.Text), int.Parse(lblClienteID.Text), true);
                        int id = producto.id_producto;

                        if (producto.error == "")
                        {
                            if (fuImagen.HasFile)
                            {
                                string Ruta = Server.MapPath("~/Img_producto/" + id.ToString() + "/");
                                if (!Directory.Exists(Ruta))
                                {
                                    Directory.CreateDirectory(Ruta);
                                }
                                string archivo = fuImagen.FileName;
                                fuImagen.PostedFile.SaveAs(Ruta + archivo);
                                string url = "Img_producto/" + id.ToString() + "/" + archivo;
                                var foto = obj.InsertarMultimediaProducto(usuario.id_usuario, 0, 1, id, fuImagen.FileName, url, true, DateTime.Now, DateTime.Now);
                            }
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El registro se realizó correctamente');", true);
                            Nuevo();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Hubo un error comuniquese con el administrador');", true);
                        }
                    }
                    if (lblTipoOperacion.Text == "U")
                    {
                        var producto = obj.ActualizarProducto(usuario.id_usuario, int.Parse(lblIdProducto.Text), int.Parse(ddlTipoProducto.SelectedValue), txtNombre.Text, txtDescripcion.Text, decimal.Parse(txtPrecio.Text), true, "", DateTime.Now, DateTime.Now, DateTime.Now, 1, decimal.Parse(txtCantidad.Text), int.Parse(lblClienteID.Text), true);
                        int id = producto.id_producto;

                        if (producto.error == "")
                        {
                            if (fuImagen.HasFile)
                            {
                                string Ruta = Server.MapPath("~/Img_producto/" + id.ToString() + "/");
                                if (!Directory.Exists(Ruta))
                                {
                                    Directory.CreateDirectory(Ruta);
                                }
                                string archivo = fuImagen.FileName;
                                string url = "Img_producto/" + id.ToString() + "/" + archivo;
                                fuImagen.PostedFile.SaveAs(Ruta + archivo);
                                var foto = obj.InsertarMultimediaProducto(usuario.id_usuario, 0, 1, id, fuImagen.FileName, url, true, DateTime.Now, DateTime.Now);
                            }
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El registro se actualizó correctamente');", true);
                            Nuevo();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Hubo un error comuniquese con el administrador');", true);
                        }
                    }
                    odsProducto.DataBind();
                    Repeater1.DataBind();
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            Nuevo();
        }

        private void Nuevo()
        {
            lblTipoOperacion.Text = "I";
            lblIdProducto.Text = "";
            txtNombre.Text = "";
            txtPrecio.Text = "0";
            txtCantidad.Text = "0";
            txtDescripcion.Text = "";
            ddlTipoProducto.SelectedIndex = 0;
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            GCws1.WSGoChasquiClient prod = new GCws1.WSGoChasquiClient();
            var producto = prod.ListaProductoIndividual(int.Parse(id));
            txtCantidad.Text = producto.stock_max.ToString();
            txtDescripcion.Text = producto.descripcion;
            txtNombre.Text = producto.nombre;
            txtPrecio.Text = producto.precio_unidad.ToString();
            lblIdProducto.Text = producto.id_producto.ToString();
            ddlTipoProducto.SelectedValue = producto.id_tipoproducto.ToString();
            lblTipoOperacion.Text = "U";
        }

        protected void btnEmilinar_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            GCws1.WSGoChasquiClient usr = new GCws1.WSGoChasquiClient();
            var usuario = usr.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
            GCws1.WSGoChasquiClient prod = new GCws1.WSGoChasquiClient();
            prod.EliminarProducto(usuario.id_usuario, int.Parse(id));
            odsProducto.DataBind();
            Repeater1.DataBind();
        }

        protected void ddlCliente_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblClienteID.Text = ddlCliente.SelectedValue;
        }
    }
}
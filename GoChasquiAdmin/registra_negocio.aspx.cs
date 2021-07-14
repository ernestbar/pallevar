using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Subgurim.Controles;

namespace GoChasquiAdmin
{
    public partial class registra_negocio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    // Parámetros
                    GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                    GCws1.Parametro parametro = obj.ListaParametroIndividual();
                    lblAsistencia.Text = "Si requiere asistencia, puede comunicarse al " + parametro.celular_cc;
                    //

                    MultiView1.ActiveViewIndex = 0;
                    if (Session["user_email"] == null)
                    {
                        Response.Redirect("login_usuario.aspx?op=regneg");
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void ddlTipoNegocio_DataBound(object sender, EventArgs e)
        {
            ListItem todos = new ListItem();
            todos.Text = "Tipo negocio";
            todos.Value = "9999999";
            //ddlTipoProducto.Items.Clear();
            ddlTipoNegocio.Items.Insert(0, todos);
        }

        protected void btnGrabar_Click(object sender, EventArgs e)
        {
            try
            {
                string error = "";
                string errorCliente = "";
                int IdCliente = 0;

                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                var usuario = obj.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                var cliente = obj.InsertarCliente(usuario.id_usuario, 0, txtRazonSocial.Text, txtNitCi.Text, txtPaterno.Text, txtMaterno.Text, txtNombres.Text, true, 1, int.Parse(ddlTipoNegocio.SelectedValue), DateTime.Now, true, false, int.Parse(ddlCiudad.SelectedValue));
                errorCliente += cliente.error;

                if (errorCliente == "")
                {
                    IdCliente = cliente.id_cliente;
                    var rol = obj.InsertarUsuarioRol(usuario.id_usuario, usuario.id_usuario, 3, true);
                    error += rol.error;

                    if (error == "")
                    {
                        var usuario_cliente = obj.InsertarClienteUsuario(usuario.id_usuario, 0, DateTime.Now, DateTime.Now, true, IdCliente, usuario.id_usuario);
                        error += usuario_cliente.error;

                        if (error == "")
                        {
                            var direccion = obj.InsertarDireccion(usuario.id_usuario, 0, IdCliente, hfLatitud.Value.ToString(), hfLongitud.Value.ToString(), txtDireccion.Text, DateTime.Now, true, txtTelefono1.Text, txtTelefono2.Text, txtCelular1.Text, txtCelular2.Text);
                            error += direccion.error;

                            if (error == "")
                            {
                                if (fuImagen.HasFile)
                                {
                                    string Ruta = Server.MapPath("~/Img_cliente/" + IdCliente.ToString() + "/");
                                    if (!Directory.Exists(Ruta))
                                    {
                                        Directory.CreateDirectory(Ruta);
                                    }
                                    string archivo = fuImagen.FileName;
                                    fuImagen.PostedFile.SaveAs(Ruta + archivo);
                                    string url = "Img_cliente/" + IdCliente.ToString() + "/" + archivo;

                                    var foto = obj.InsertarMultimediaCliente(usuario.id_usuario, 0, 1, IdCliente, fuImagen.FileName, url, true, DateTime.Now, DateTime.Now);
                                }
                            }
                        }
                    }
                }

                if (errorCliente == "" && error == "")
                {
                    MultiView1.ActiveViewIndex = 1;
                }
                else
                {
                    if (errorCliente != "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + errorCliente + "');", true);
                    }
                    else
                    {
                        EliminarCliente(IdCliente);
                        Session["MENSAJE"] = "No se pudo registrar el cliente. Por favor vuelva a intentarlo";
                        Response.Redirect("~/home.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
        private void EliminarCliente(int Id_cliente)
        {
            try
            {
                int IdUsuario = Session["id_usuario"] == null ? 0 : Convert.ToInt32(Session["id_usuario"]);
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                GCws1.Cliente Cliente;
                Cliente = obj.EliminarCliente(IdUsuario, Id_cliente);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
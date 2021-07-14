using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Subgurim.Controles;
using System.IO;

namespace GoChasquiAdmin
{
    public partial class adm_clientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Session["id_usuario"] == null)
                    {
                        Response.Redirect("~/Default.aspx");
                    }
                    else
                    {
                        GCws1.WSGoChasquiClient obj1 = new GCws1.WSGoChasquiClient();
                        var usuario = obj1.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                        lblIdUsuario.Text = usuario.id_usuario.ToString();
                        MultiView1.ActiveViewIndex = 0;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnUsuarios_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            Session["id_cliente"] = id;
            Session["id_usuario"] = lblIdUsuario.Text;
            Response.Redirect("~/adm_clientes_usuarios.aspx");
        }

        protected void btnEstado_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();
            objU.EliminarCliente(int.Parse(lblIdUsuario.Text), int.Parse(id));
            Repeater1.DataBind();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            lblIdCliente.Text = id;
            GCws1.WSGoChasquiClient obj_cli = new GCws1.WSGoChasquiClient();

            var cliente = obj_cli.ListaClienteIndividual(int.Parse(id));
            txtRazonSocial.Text = cliente.razon_social;
            txtNit.Text = cliente.nit;
            txtNombreCon.Text = cliente.nombre;
            txtPaternoCon.Text = cliente.paterno;
            txtMaternoCon.Text = cliente.materno;
            ddlCiudad.SelectedValue = cliente.id_ciudad.ToString();
            ddlTipoNegocio.SelectedValue = cliente.id_tiponegocio.ToString();

            var direc = obj_cli.ListaDireccionCliente(cliente.id_cliente);
            if (direc.Count() > 0)
            {
                txtDireccionCon.Text = direc.First().direccion1;
                txtTel1Con.Text = direc.First().telf1;
                txtTel2Con.Text = direc.First().telf2;
                txtCel1Con.Text = direc.First().cel1;
                txtCel2Con.Text = direc.First().cel2;
                lblIdDireccion.Text = direc.First().id_direccion.ToString();
                hfLatitud.Value = direc.First().latitud;
                hfLongitud.Value = direc.First().longitud;
                lblLatitud.Text = direc.First().latitud;
                lblLongitud.Text = direc.First().longitud;
            }

            //txtTel1Con.Text=direc.First().
            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            string id = "";
            lblIdCliente.Text = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            lblIdCliente.Text = id;

            txtRazonSocial.Text = "";
            txtNit.Text = "";
            txtNombreCon.Text = "";
            txtPaternoCon.Text = "";
            txtMaternoCon.Text = "";
            ddlCiudad.SelectedValue = "4";
            ddlTipoNegocio.SelectedValue = "1";
            txtDireccionCon.Text = "";
            txtTel1Con.Text = "";
            txtTel2Con.Text = "";
            txtCel1Con.Text = "";
            txtCel2Con.Text = "";
            lblIdDireccion.Text = "";
            hfLatitud.Value = "";
            hfLongitud.Value = "";
            lblLatitud.Text = "";
            lblLongitud.Text = "";

            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnGuardarCliente_Click(object sender, EventArgs e)
        {
            try
            {
                string error = "";
                string errorCliente = "";
                int IdCliente = 0;

                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                if (lblIdCliente.Text == "")
                {

                    var cliente = obj.InsertarCliente(int.Parse(lblIdUsuario.Text), 0, txtRazonSocial.Text, txtNit.Text, txtPaternoCon.Text, txtMaternoCon.Text, txtNombreCon.Text, true, 1, int.Parse(ddlTipoNegocio.SelectedValue), DateTime.Now, true, false, int.Parse(ddlCiudad.SelectedValue));
                    errorCliente += cliente.error;

                    if (errorCliente == "")
                    {
                        IdCliente = cliente.id_cliente;
                        var direccion = obj.InsertarDireccion(int.Parse(lblIdUsuario.Text), 0, IdCliente, hfLatitud.Value.ToString(), hfLongitud.Value.ToString(), txtDireccionCon.Text, DateTime.Now, true, txtTel1Con.Text, txtTel2Con.Text, txtCel1Con.Text, txtCel2Con.Text);
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
                                var foto = obj.InsertarMultimediaCliente(int.Parse(lblIdUsuario.Text), 0, 1, IdCliente, fuImagen.FileName, url, true, DateTime.Now, DateTime.Now);
                            }
                        }
                    }
                }
                else
                {
                    var cliente = obj.ActualizarCliente(int.Parse(lblIdUsuario.Text), int.Parse(lblIdCliente.Text), txtRazonSocial.Text, txtNit.Text, txtPaternoCon.Text, txtMaternoCon.Text, txtNombreCon.Text, true, 1, int.Parse(ddlTipoNegocio.SelectedValue), DateTime.Now, true, false, int.Parse(ddlCiudad.SelectedValue));
                    errorCliente += cliente.error;

                    if (errorCliente == "")
                    {
                        IdCliente = cliente.id_cliente;
                        var direccion = obj.ActualizarDireccion(int.Parse(lblIdUsuario.Text), int.Parse(lblIdDireccion.Text), cliente.id_cliente, hfLatitud.Value.ToString(), hfLongitud.Value.ToString(), txtDireccionCon.Text, DateTime.Now, true, txtTel1Con.Text, txtTel2Con.Text, txtCel1Con.Text, txtCel2Con.Text);
                        error += direccion.error;

                        if (error == "")
                        {
                            if (fuImagen.HasFile)
                            {
                                string Ruta = Server.MapPath("~/Img_cliente/" + cliente.id_cliente.ToString() + "/");
                                if (!Directory.Exists(Ruta))
                                {
                                    Directory.CreateDirectory(Ruta);
                                }
                                string archivo = fuImagen.FileName;
                                fuImagen.PostedFile.SaveAs(Ruta + archivo);
                                string url = "Img_cliente/" + cliente.id_cliente.ToString() + "/" + archivo;
                                var foto = obj.InsertarMultimediaCliente(int.Parse(lblIdUsuario.Text), 0, 1, cliente.id_cliente, fuImagen.FileName, url, true, DateTime.Now, DateTime.Now);
                            }
                        }
                    }
                }

                if (errorCliente == "" && error == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Se registró el cliente');", true);
                    MultiView1.ActiveViewIndex = 0;
                    Repeater1.DataBind();
                }
                else
                {
                    if (errorCliente != "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + errorCliente + "');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('No se pudo registrar el cliente. Por favor vuelva a intentarlo');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
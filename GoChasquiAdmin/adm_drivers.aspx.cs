using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace GoChasquiAdmin
{
    public partial class adm_drivers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    GCws1.WSGoChasquiClient obj1 = new GCws1.WSGoChasquiClient();
                    var usuario = obj1.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                    lblIdUsuarioAudit.Text = usuario.id_usuario.ToString();
                    MultiView1.ActiveViewIndex = 0;

                    int i = 0;
                    for (i = 0; i <= 31; i++)
                    {
                        ListItem dias = new ListItem();
                        if (i == 0)
                        { dias.Text = "Dia"; }
                        else { dias.Text = i.ToString(); }

                        ddlDia.Items.Insert(i, dias);
                        ddlVLDia.Items.Insert(i, dias);
                    }
                    int m = 0;
                    for (m = 0; m <= 12; m++)
                    {
                        ListItem meses = new ListItem();
                        if (m == 0)
                        { meses.Text = "Mes"; }
                        else { meses.Text = m.ToString(); }
                        ddlMes.Items.Insert(m, meses);
                        ddlVLMes.Items.Insert(m, meses);
                    }
                    int a = 0;
                    for (a = 0; a <= 80; a++)
                    {
                        ListItem anios = new ListItem();
                        if (a == 0)
                        { anios.Text = "Años"; }
                        else { anios.Text = (DateTime.Now.Year - a).ToString(); }
                        ddlAnio.Items.Insert(a, anios);
                    }

                    for (a = 0; a <= (2051 - DateTime.Now.Year); a++)
                    {
                        ListItem anios = new ListItem();
                        if (a == 0)
                        {
                            anios.Text = "Años";
                        }
                        else
                        {
                            anios.Text = (2050 + 1 - a).ToString();
                        }
                        ddlVLAnio.Items.Insert(a, anios);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnDocumento_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            Session["id_driver"] = id;
            Response.Redirect("adm_drivers_documentos.aspx");
        }

        protected void btnMotorizado_Click(object sender, EventArgs e)
        {
            int id = 0;
            Button obj = (Button)sender;
            id = int.Parse(obj.CommandArgument.ToString());
            lblIdDriver.Text = id.ToString();
            GCws1.WSGoChasquiClient objMotorizado = new GCws1.WSGoChasquiClient();
            var motorizado = objMotorizado.ListaMotorizadoXDriver(id);
            lblIdMotorizado.Text = motorizado.id_motorizado.ToString();

            if (motorizado.id_motorizado == 0)
            {
                txtPlaca.Text = "";
                ddlTipoMotorizado.SelectedValue = "1";
                txtColor.Text = "";
                txtMarca.Text = "";
                txtModelo.Text = "";
            }
            else
            {
                txtPlaca.Text = motorizado.placa;
                ddlTipoMotorizado.SelectedValue = motorizado.id_tipomotorizado.ToString();
                txtColor.Text = motorizado.color;
                txtMarca.Text = motorizado.marca;
                txtModelo.Text = motorizado.modelo;
                imgImagen.ImageUrl = "~/" + motorizado.url_foto;
            }
            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnCancelarM_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnGuardarM_Click(object sender, EventArgs e)
        {
            try
            {
                string error = "";
                int IdDriver = 0;
                int idMotorizado = 0;
                int.TryParse(lblIdDriver.Text, out IdDriver);
                int.TryParse(lblIdMotorizado.Text, out idMotorizado);

                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                GCws1.Motorizado motorizado;

                if (idMotorizado == 0)
                {
                    motorizado = obj.InsertarMotorizado(int.Parse(lblIdUsuarioAudit.Text), 0, txtPlaca.Text, true, IdDriver, int.Parse(ddlTipoMotorizado.SelectedValue), txtColor.Text, txtMarca.Text, txtModelo.Text, DateTime.Today, "");

                }
                else
                {
                    motorizado = obj.ActualizarMotorizado(int.Parse(lblIdUsuarioAudit.Text), idMotorizado, txtPlaca.Text, true, IdDriver, int.Parse(ddlTipoMotorizado.SelectedValue), txtColor.Text, txtMarca.Text, txtModelo.Text, DateTime.Today, "");
                }
                error += motorizado.error;

                if (error == "")
                {
                    if (fuArchivo.HasFile)
                    {
                        string Ruta = Server.MapPath("~/Img_motorizado/" + motorizado.id_motorizado + "/");
                        string archivo = fuArchivo.FileName;
                        if (!Directory.Exists(Ruta))
                        {
                            Directory.CreateDirectory(Ruta);
                        }
                        fuArchivo.PostedFile.SaveAs(Ruta + archivo);
                        string url = "Img_motorizado/" + motorizado.id_motorizado.ToString() + "/" + archivo;
                        var imagen = obj.ActualizarMotorizadoUrlFoto(int.Parse(lblIdUsuarioAudit.Text), motorizado.id_motorizado, url);
                        error += imagen.error;
                    }
                }

                if (error == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El registro se realizó correctamente');", true);
                    MultiView1.ActiveViewIndex = 0;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Hubo un error comuniquese con el administrador');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnResetPass_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            GCws1.WSGoChasquiClient obj_driver = new GCws1.WSGoChasquiClient();
            var UsuarioDriver = obj_driver.ListaDriverUsuarioXDriver(int.Parse(id));
            lblIdUsuario.Text = UsuarioDriver.id_usuario.ToString();
            txtNewClave.Text = "";
            MultiView1.ActiveViewIndex = 2;
        }

        protected void btnEstado_Click(object sender, EventArgs e)
        {
            string id = "";
            Button obj = (Button)sender;
            id = obj.CommandArgument.ToString();
            GCws1.WSGoChasquiClient obj_driver = new GCws1.WSGoChasquiClient();
            obj_driver.EliminarDriver(int.Parse(lblIdUsuarioAudit.Text), int.Parse(id));
            Repeater1.DataBind();
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            lblIdDriver.Text = "";
            lblIdUsuario.Text = "";
            // Driver
            txtNombre.Text = "";
            txtPaterno.Text = "";
            txtMaterno.Text = "";
            txtCI.Text = "";
            txtNroLicencia.Text = "";
            ddlAnio.SelectedIndex = 0;
            ddlMes.SelectedIndex = 0;
            ddlDia.SelectedIndex = 0;
            ddlVLAnio.SelectedIndex = 0;
            ddlVLMes.SelectedIndex = 0;
            ddlVLDia.SelectedIndex = 0;
            rbtnMasculino.Checked = true;
            ddlTipoDriver.SelectedValue = "1";
            // Usuario
            txtEmail.Enabled = true;
            txtEmail.Text = "";
            txtCelular.Text = "";
            ddlCiudad.SelectedValue = "4";

            MultiView1.ActiveViewIndex = 3;
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            int id = 0;
            Button obj = (Button)sender;
            id = int.Parse(obj.CommandArgument.ToString());
            lblIdDriver.Text = id.ToString();
            GCws1.WSGoChasquiClient objDriver = new GCws1.WSGoChasquiClient();
            var UsuarioDriver = objDriver.ListaDriverUsuarioXDriver(id);
            var driver = objDriver.ListaDriverIndividual(id);
            var usuario = objDriver.ListaUsuarioIndividual(UsuarioDriver.id_usuario);

            // Driver
            txtNombre.Text = driver.nombre;
            txtPaterno.Text = driver.paterno;
            txtMaterno.Text = driver.materno;
            txtCI.Text = driver.ci;
            txtNroLicencia.Text = driver.nro_licencia;
            ddlAnio.SelectedValue = driver.fecha_nacimiento.Year.ToString();
            ddlMes.SelectedValue = driver.fecha_nacimiento.Month.ToString();
            ddlDia.SelectedValue = driver.fecha_nacimiento.Day.ToString();
            ddlVLAnio.SelectedValue = driver.ven_licencia.Year.ToString();
            ddlVLMes.SelectedValue = driver.ven_licencia.Month.ToString();
            ddlVLDia.SelectedValue = driver.ven_licencia.Day.ToString();
            if (driver.genero == "M")
            {
                rbtnMasculino.Checked = true;
            }
            else
            {
                rbtnFemenino.Checked = true;
            }
            ddlTipoDriver.SelectedValue = driver.id_tipodriver.ToString();
            // Usuario
            txtEmail.Enabled = false;
            txtEmail.Text = usuario.email;
            txtCelular.Text = usuario.celular;
            ddlCiudad.SelectedValue = usuario.id_ciudad.ToString();
            //
            MultiView1.ActiveViewIndex = 3;
        }

        protected void btnVer_Click(object sender, EventArgs e)
        {
            if (imgImagen.ImageUrl != "")
            {
                FileInfo archivo = new System.IO.FileInfo(Server.MapPath(imgImagen.ImageUrl));

                if (archivo.Exists)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "abrirAdjunto", "abrirAdjunto('" + Page.ResolveUrl(imgImagen.ImageUrl) + "'); ", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Primero debe guardar la imagen');", true);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                string error = "";
                int IdUsuario = 0;
                int IdDriver = 0;
                int IdCiudad = 0;
                int IdTipoDriver = 0;
                string genero = "";
                string fecha_nac = ddlDia.SelectedValue + "/" + ddlMes.SelectedValue + "/" + ddlAnio.Text;
                string fecha_vl = ddlVLDia.SelectedValue + "/" + ddlVLMes.SelectedValue + "/" + ddlVLAnio.Text;

                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                int.TryParse(lblIdDriver.Text, out IdDriver);
                var UsuarioDriver = obj.ListaDriverUsuarioXDriver(IdDriver);
                IdUsuario = UsuarioDriver.id_usuario;
                IdCiudad = int.Parse(ddlCiudad.SelectedValue);
                IdTipoDriver = int.Parse(ddlTipoDriver.SelectedValue);

                if (rbtnMasculino.Checked)
                {
                    genero = "M";
                }
                else
                {
                    genero = "F";
                }


                GCws1.Usuario Usuario;
                // Usuario
                if (IdUsuario == 0)
                {
                    Usuario = obj.InsertarUsuario(int.Parse(lblIdUsuarioAudit.Text), 0, txtEmail.Text, txtNombre.Text, txtPaterno.Text, txtMaterno.Text, "123", true, "", "", DateTime.Parse(fecha_nac), txtCelular.Text, IdCiudad);
                }
                else
                {
                    Usuario = obj.ActualizarUsuario(int.Parse(lblIdUsuarioAudit.Text), IdUsuario, txtEmail.Text, txtNombre.Text, txtPaterno.Text, txtMaterno.Text, "", true, "", "", DateTime.Parse(fecha_nac), txtCelular.Text, IdCiudad);
                }
                error += Usuario.error;

                // Driver
                if (error == "")
                {
                    GCws1.Driver Driver;

                    if (IdDriver == 0)
                    {
                        Driver = obj.InsertarDriver(int.Parse(lblIdUsuarioAudit.Text), 0, txtNombre.Text, txtPaterno.Text, txtMaterno.Text, txtCI.Text, true, DateTime.Today, txtNroLicencia.Text, DateTime.Parse(fecha_vl), DateTime.Parse(fecha_nac), genero, true, "", "", IdTipoDriver);
                    }
                    else
                    {
                        Driver = obj.ActualizarDriver(int.Parse(lblIdUsuarioAudit.Text), IdDriver, txtNombre.Text, txtPaterno.Text, txtMaterno.Text, txtCI.Text, true, DateTime.Today, txtNroLicencia.Text, DateTime.Parse(fecha_vl), DateTime.Parse(fecha_nac), genero, true, "", "", IdTipoDriver);
                    }
                    error += Driver.error;

                    // Driver Usuario
                    if (error == "")
                    {
                        if (IdDriver == 0)
                        {
                            var DriverUsuario = obj.InsertarDriverUsuario(int.Parse(lblIdUsuarioAudit.Text), Driver.id_driver, Usuario.id_usuario, DateTime.Today, DateTime.Today, true);
                            error += DriverUsuario.error;
                        }
                    }

                    // Insertar en Usuario Rol
                    if (error == "")
                    {
                        if (IdUsuario == 0)
                        {
                            var usuario_rol = obj.InsertarUsuarioRol(int.Parse(lblIdUsuarioAudit.Text), Usuario.id_usuario, 7, true);
                            error += usuario_rol.error;
                        }
                    }

                    if (error == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('El registro se realizó correctamente');", true);
                        Repeater1.DataBind();
                        MultiView1.ActiveViewIndex = 0;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Hubo un error comuniquese con el administrador');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + error + "');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnCancelarCP_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnCambiarCP_Click(object sender, EventArgs e)
        {
            try
            {
                GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();

                if (objU.CambiarUsuarioClave(int.Parse(lblIdUsuario.Text), int.Parse(lblIdUsuario.Text), txtNewClave.Text).error == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Se cambio el password correctamente');", true);
                    MultiView1.ActiveViewIndex = 0;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Hubo un error comuniquese con el administrador');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
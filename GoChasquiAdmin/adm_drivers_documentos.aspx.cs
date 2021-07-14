using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace GoChasquiAdmin
{
    public partial class adm_drivers_documentos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Session["id_usuario"] == null)
                    {
                        Response.Redirect("Default.aspx");
                    }
                    else
                    {
                        GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();

                        lblIdDriver.Text = Session["id_driver"].ToString();
                        lblIdUsuario.Text = Session["id_usuario"].ToString();
                        Repeater1.DataBind();
                        MultiView1.ActiveViewIndex = 0;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnAsignar_Click(object sender, EventArgs e)
        {
            try
            {
                int idTipoDocumento = 0;
                int idDriver = 0;
                Button obj = (Button)sender;
                idTipoDocumento = int.Parse(obj.CommandArgument.ToString());
                idDriver = int.Parse(lblIdDriver.Text);
                GCws1.WSGoChasquiClient objU = new GCws1.WSGoChasquiClient();
                objU.EliminarDocumentoDriver(int.Parse(lblIdUsuario.Text), idTipoDocumento, idDriver);
                Repeater1.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                int idTipoDocumento = 0;
                int idDriver = 0;
                Button obj = (Button)sender;
                idTipoDocumento = int.Parse(obj.CommandArgument.ToString());
                lblIdTipoDocumento.Text = idTipoDocumento.ToString();
                idDriver = int.Parse(lblIdDriver.Text);
                GCws1.WSGoChasquiClient objDocumento = new GCws1.WSGoChasquiClient();
                var documento_driver = objDocumento.ListaDocumentoDriverIndividual(idTipoDocumento, idDriver);
                ddlTipoDocumento.Enabled = false;
                ddlTipoDocumento.SelectedValue = documento_driver.id_tipodocumento.ToString();
                imgImagen.ImageUrl = "~/" + documento_driver.url;
                MultiView1.ActiveViewIndex = 1;
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
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

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            lblIdTipoDocumento.Text = "";
            ddlTipoDocumento.Enabled = true;
            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                string error = "";
                int idTipoDocumento = 0;
                int.TryParse(lblIdTipoDocumento.Text, out idTipoDocumento);

                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                GCws1.DocumentoDriver documento_driver;

                if (idTipoDocumento == 0)
                {
                    documento_driver = obj.InsertarDocumentoDriver(int.Parse(lblIdUsuario.Text), int.Parse(ddlTipoDocumento.SelectedValue), int.Parse(lblIdDriver.Text), "", true, DateTime.Today);
                }
                else
                {
                    documento_driver = obj.ActualizarDocumentoDriver(int.Parse(lblIdUsuario.Text), int.Parse(ddlTipoDocumento.SelectedValue), int.Parse(lblIdDriver.Text), "", true, DateTime.Today);
                }
                error += documento_driver.error;

                if (error == "")
                {
                    if (fuArchivo.HasFile)
                    {
                        string Ruta = Server.MapPath("~/Driver_doc/" + lblIdDriver.Text + "/");
                        string archivo = fuArchivo.FileName;
                        if (!Directory.Exists(Ruta))
                        {
                            Directory.CreateDirectory(Ruta);
                        }
                        fuArchivo.PostedFile.SaveAs(Ruta + archivo);
                        string url = "Driver_doc/" + lblIdDriver.Text + "/" + archivo;
                        var imagen = obj.ActualizarDocumentoDriverUrl(int.Parse(lblIdUsuario.Text), documento_driver.id_tipodocumento, documento_driver.id_driver, url);
                        error += imagen.error;
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
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/adm_drivers.aspx");
        }
    }
}
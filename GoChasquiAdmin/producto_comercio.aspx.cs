using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace GoChasquiAdmin
{
    public partial class producto_comercio : System.Web.UI.Page
    {
        static ListItemCollection compras = new ListItemCollection();
        static int i = 0;
        static DataTable dt = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    if (Session["id_cliente"] == null)
                    {
                        Response.Redirect("home.aspx");
                    }
                    else
                    {
                        lblClienteID.Text = Session["id_cliente"].ToString();
                        int IdTipoServicio = Request.QueryString["Id_tiposervicio"] == null ? 0 : Convert.ToInt32(Request.QueryString["Id_tiposervicio"]);
                        lblIdTipoServicio.Text = IdTipoServicio.ToString();

                        GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                        lblCostoDeliveryConf.Text = obj.GastoEnvio("", "").ToString();
                        // Parámetros
                        GCws1.Parametro parametro = obj.ListaParametroIndividual();
                        lblAsistencia1.Text = "Si requiere asistencia, puede comunicarse al " + parametro.celular_cc;
                        lblAsistencia2.Text = lblAsistencia1.Text;
                        //
                        MultiView1.ActiveViewIndex = 0;
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void lbtnComprar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["user_email"] == null)
                {
                    Response.Redirect("login_usuario.aspx");
                }
                else
                {
                    string id = "";
                    LinkButton obj = (LinkButton)sender;
                    id = obj.CommandArgument.ToString();
                    MultiView1.ActiveViewIndex = 1;
                    GCws1.WSGoChasquiClient obj1 = new GCws1.WSGoChasquiClient();
                    GCws1.Producto prod = new GCws1.Producto();
                    prod = obj1.ListaProductoIndividual(int.Parse(id));

                    lblTitulo1.Text = prod.nombre;
                    //lblDescripcion1.Text = prod.descripcion;
                    lblPrecio1.Text = prod.precio_unidad.ToString();
                    lblTotal1.Text = prod.precio_unidad.ToString();
                    lblSubTotal.Text = prod.precio_unidad.ToString();
                    lblTotal_final.Text = prod.precio_unidad.ToString();
                    lblIdProducto1.Text = prod.id_producto.ToString();
                    imgProducto1.ImageUrl = prod.ruta_imagen;
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void lbtnSeguirComprando_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
        }

        protected void btnComprar_Click(object sender, EventArgs e)
        {
            try
            {
                string id = "";
                Button obj = (Button)sender;
                id = obj.CommandArgument.ToString();
                MultiView1.ActiveViewIndex = 1;
                GCws1.WSGoChasquiClient obj1 = new GCws1.WSGoChasquiClient();
                GCws1.Producto prod = new GCws1.Producto();
                prod = obj1.ListaProductoIndividual(int.Parse(id));

                lblTitulo1.Text = prod.nombre;
                //lblDescripcion1.Text = prod.descripcion;
                lblPrecio1.Text = prod.precio_unidad.ToString();
                lblTotal1.Text = prod.precio_unidad.ToString();
                lblSubTotal.Text = prod.precio_unidad.ToString();
                lblTotal_final.Text = prod.precio_unidad.ToString();
                lblIdProducto1.Text = prod.id_producto.ToString();
                imgProducto1.ImageUrl = prod.ruta_imagen;
                txtExtra.Text = "";
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }


        protected void lbtnPaso2anterior_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;
        }

        protected void lbtnPaso2siguiente_Click(object sender, EventArgs e)
        {
            try
            {
                lblProductosConf.Text = "";
                ListItem item = new ListItem();

                lblDireccionConf.Text = txtDireccion.Text;
                decimal costo_prod = 0;
                decimal costo_total = 0;

                i = i + 1;
                if (compras.Count > 0)
                {
                    foreach (ListItem item1 in compras)
                    {
                        string[] datos = item1.Text.Split('|');
                        costo_prod = costo_prod + decimal.Parse(datos[1].ToString());
                        lblProductosConf.Text = lblProductosConf.Text + "ITEM: " + datos[0].ToString() + " UNIDADES:" + datos[2] + " ID:" + datos[3] + "<br/>";
                    }
                }
                costo_total = costo_prod + decimal.Parse(lblCostoDeliveryConf.Text);
                lblTotalProdConf.Text = costo_prod.ToString();
                lblTotalPagarConf.Text = costo_total.ToString();

                MultiView1.ActiveViewIndex = 3;
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void lbtnPaso3anterior_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 2;
        }

        protected void btnSiguiente_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 2;
        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["user_email"] == null)
                {
                    return;
                }
                else
                {
                    if (lblTotalProdConf.Text == "0" || lblTotalProdConf.Text == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('No eligio ningun producto, elija por lo menos un producto para procesar su pedido, gracias');", true);
                    }
                    else
                    {
                        string error = "";
                        string errorPedido = "";
                        int IdPedido = 0;
                        int IdRuta = 0;
                        int IdUsuario = Session["id_usuario"] == null ? 0 : Convert.ToInt32(Session["id_usuario"]);
                        int IdCiudad = Session["id_ciudad"] == null ? 0 : Convert.ToInt32(Session["id_ciudad"]);
                        decimal GastoEnvio = 0;
                        decimal.TryParse(lblCostoDeliveryConf.Text, out GastoEnvio);

                        if (IdUsuario > 0)
                        {
                            GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                            // Insertar Pedido
                            GCws1.Pedido pedido = obj.InsertarPedido(IdUsuario, 0, DateTime.Today, DateTime.Today, false, decimal.Parse(lblTotalPagarConf.Text), false, true, IdUsuario, true, int.Parse(lblClienteID.Text), 2, 1, IdCiudad);
                            errorPedido += pedido.error;

                            // Insertar Pedido Detalle
                            if (errorPedido == "")
                            {
                                IdPedido = pedido.id_pedido;
                                if (compras.Count > 0)
                                {
                                    foreach (ListItem item1 in compras)
                                    {
                                        string[] datos = item1.Text.Split('|');
                                        GCws1.PedidoDetalle pedido_detalle = obj.InsertarPedidoDetalle(IdUsuario, 0, pedido.id_pedido, int.Parse(datos[3]), decimal.Parse(datos[1]), int.Parse(datos[2]), DateTime.Now, true, datos[4]);
                                        error += pedido_detalle.error;
                                    }
                                }

                                // Insertar Ruta
                                if (error == "")
                                {
                                    GCws1.Ruta ruta = obj.InsertarRuta(IdUsuario, 0, 0, "", "", "", DateTime.Today, DateTime.Today, true, hfLatitud.Value.ToString(), hfLongitud.Value.ToString(), lblDireccionConf.Text, IdPedido, 0);
                                    error += ruta.error;
                                    if (error == "")
                                    {
                                        IdRuta = ruta.id_ruta;
                                        // Insertar Cargos
                                        GCws1.PedidoCargoExtra pedido_cargo_extra = obj.InsertarPedidoCargoExtra(IdUsuario, 0, 1, GastoEnvio, true, DateTime.Today, IdPedido, 0);
                                        error += pedido_cargo_extra.error;
                                    }
                                }
                            }

                            if (errorPedido == "" && error == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Se registró el pedido');", true);
                                MultiView1.ActiveViewIndex = 4;
                            }
                            else
                            {
                                if (errorPedido != "")
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + errorPedido + "');", true);
                                }
                                else
                                {
                                    EliminarPedido(IdPedido);
                                    Session["MENSAJE"] = "No se pudo registrar el pedido. Por favor vuelva a intentarlo";
                                    Response.Redirect("~/home.aspx");
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        private void EliminarPedido(int Id_pedido)
        {
            try
            {
                int IdUsuario = Session["id_usuario"] == null ? 0 : Convert.ToInt32(Session["id_usuario"]);
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                GCws1.Pedido Pedido;
                Pedido = obj.EliminarPedido(IdUsuario, Id_pedido);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            compras.Clear();
            Response.Redirect("comercios.aspx?Id_tiposervicio=" + lblIdTipoServicio.Text);
        }

        protected void lbtnCancelarP_Click(object sender, EventArgs e)
        {
            compras.Clear();
            Response.Redirect("comercios.aspx?Id_tiposervicio=" + lblIdTipoServicio.Text);
        }

        protected void lbtnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                lblProductosComprados.Text = "";
                ListItem item = new ListItem();
                //string total= ScriptManager.RegisterStartupScript(this.UpdatePanel1, GetType(), "mifuncion", "prueba()", true);
                item.Text = lblTitulo1.Text + "|" + hfTotal.Value + "|" + hfUnidades.Value + "|" + lblIdProducto1.Text + "|" + txtExtra.Text;
                item.Value = lblIdProducto1.Text;
                compras.Add(item);
                lblDireccionConf.Text = txtDireccion.Text;
                decimal costo_prod = 0;
                decimal costo_total = 0;
                //lbCompras.Items.Clear();
                //lbComprasConf.Items.Clear();
                i = i + 1;
                if (compras.Count > 0)
                {
                    foreach (ListItem item1 in compras)
                    {
                        string[] datos = item1.Text.Split('|');
                        costo_prod = costo_prod + decimal.Parse(datos[1].ToString());
                        lblProductosComprados.Text = lblProductosComprados.Text + "ITEM: " + datos[0].ToString() + " UNIDADES:" + datos[2] + " ID:" + datos[3] + " DETEALLE EXTRA:" + datos[4] + "<br/>";
                    }
                }
                costo_total = costo_prod + decimal.Parse(lblCostoDeliveryConf.Text);
                lblTotalProdConf.Text = costo_prod.ToString();
                lblTotalPagarConf.Text = costo_total.ToString();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
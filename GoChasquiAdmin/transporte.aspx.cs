using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class transporte : System.Web.UI.Page
    {
        static int op = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsPostBack)
                {
                    //if (Session["id_usuario"] == null)
                    //{
                    //    Response.Redirect("home.aspx");
                    //}
                    //else
                    //{
                        // Parámetros
                        GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                        GCws1.Parametro parametro = obj.ListaParametroIndividual();
                        lblAsistencia.Text = "Si requiere asistencia, puede comunicarse al " + parametro.celular_cc;
                        //

                        MultiView1.ActiveViewIndex = op;
                        if (op == 0)
                        {
                            dOrigen.Attributes["class"] = "step active";
                            dDestino.Attributes["class"] = "step";
                            dFinal.Attributes["class"] = "step";
                            lbtnAnterior.Visible = false;
                        }
                    //}
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void lbtnAnterior_Click(object sender, EventArgs e)
        {
            try
            {
                op = op - 1;
                if (op >= 0)
                {
                    if (op < 3)
                    {
                        MultiView1.ActiveViewIndex = op;
                        if (op == 0)
                        {
                            dOrigen.Attributes["class"] = "step active";
                            dDestino.Attributes["class"] = "step";
                            dFinal.Attributes["class"] = "step";
                            lbtnAnterior.Visible = false;
                            lbtnSiguiente.Visible = true;
                        }
                        if (op == 1)
                        {
                            dOrigen.Attributes["class"] = "step";
                            dDestino.Attributes["class"] = "step active";
                            dFinal.Attributes["class"] = "step";
                            lbtnAnterior.Visible = true;
                            lbtnSiguiente.Visible = true;
                        }
                        if (op == 2)
                        {
                            dOrigen.Attributes["class"] = "step";
                            dDestino.Attributes["class"] = "step";
                            dFinal.Attributes["class"] = "step active";
                            lbtnSiguiente.Visible = false;
                            lbtnAnterior.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
        protected void lbtnSiguiente_Click(object sender, EventArgs e)
        {
            try
            {
                op = op + 1;
                if (op < 3)
                {
                    MultiView1.ActiveViewIndex = op;
                    if (op == 1)
                    {
                        dOrigen.Attributes["class"] = "step";
                        dDestino.Attributes["class"] = "step active";
                        dFinal.Attributes["class"] = "step";
                        lbtnAnterior.Visible = true;
                        lbtnSiguiente.Visible = true;

                    }
                    if (op == 2)
                    {
                        dOrigen.Attributes["class"] = "step";
                        dDestino.Attributes["class"] = "step";
                        dFinal.Attributes["class"] = "step active";
                        lbtnSiguiente.Visible = false;
                        lbtnAnterior.Visible = true;
                        lblDir1.Text = txtDireccion1.Text;
                        lblDir2.Text = txtDireccion2.Text;
                        CalculoPedidoTransporte();
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        protected void lbtnConfirmar_Click(object sender, EventArgs e)
        {
            if (Session["user_email"] == null)
            {
                return;
            }

            decimal distancia = 0;

            if (hfLatitud.Value == "" && hfLongitud.Value == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Debe seleccionar la dirección de origen');", true);
                return;
            }

            if (txtDireccion1.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Debe ingresar la dirección de origen');", true);
                return;
            }

            if (hfLat2.Value == "" && hfLon2.Value == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Debe ingresar la dirección de destino');", true);
                return;
            }

            if (txtDireccion2.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Debe ingresar la dirección de destino');", true);
                return;
            }

            if (FuncionesGlobales.numeroDecimal(lblCosto.Text) == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('No se tiene el costo del transporte. Por favor vuelva a intentar');", true);
                return;
            }

            if (FuncionesGlobales.numeroDecimal(txtCostoPropuesto.Text) == 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Debe ingresar el costo propuesto');", true);
                return;
            }
            distancia = FuncionesGlobales.numeroDecimal(lblDistancia.Text);

            try
            {
                string error = "";
                string errorPedido = "";
                int IdPedido = 0;
                int IdRuta = 0;
                decimal costoPropuesto = 0;
                int IdUsuario = Session["id_usuario"] == null ? 0 : Convert.ToInt32(Session["id_usuario"]);
                int IdCiudad = Session["id_ciudad"] == null ? 0 : Convert.ToInt32(Session["id_ciudad"]);

                costoPropuesto = decimal.Parse(txtCostoPropuesto.Text);
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                // Insertar Pedido
                GCws1.Pedido pedido = obj.InsertarPedido(IdUsuario, 0, DateTime.Today, DateTime.Today, false, costoPropuesto, false, true, IdUsuario, true, 1, 1, 1, IdCiudad);
                errorPedido += pedido.error;

                // Insertar Ruta
                if (errorPedido == "")
                {
                    IdPedido = pedido.id_pedido;
                    GCws1.Ruta ruta = obj.InsertarRuta(IdUsuario, 0, 0, hfLatitud.Value.ToString(), hfLongitud.Value.ToString(), txtDireccion1.Text, DateTime.Today, DateTime.Today, true, hfLat2.Value.ToString(), hfLon2.Value.ToString(), txtDireccion2.Text, pedido.id_pedido, distancia);
                    error += ruta.error;
                    // Insertar Cargos
                    if (error == "")
                    {
                        IdRuta = ruta.id_ruta;
                        GCws1.PedidoCargoExtra pedido_cargo_extra = obj.InsertarPedidoCargoExtra(IdUsuario, 0, 2, costoPropuesto, true, DateTime.Today, IdPedido, 0);
                        error += pedido_cargo_extra.error;
                    }
                }

                if (errorPedido == "" && error == "")
                {
                    op = 1;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Se registró el pedido');", true);
                    Response.Redirect("~/transporte_propuesta_driver.aspx?Id_pedido=" + IdPedido);
                }
                else
                {
                    if (errorPedido != "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('XXXX');", true);
                    }
                    else
                    {
                        EliminarPedido(IdPedido);
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

        private void CalculoPedidoTransporte()
        {
            try
            {
                GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                GCws1.PedidoTrasporteCalculo pedidoTrasporteCalculo = obj.CalculoPedidoTransporte(hfLatitud.Value.ToString(), hfLongitud.Value.ToString(), hfLat2.Value.ToString(), hfLon2.Value.ToString());
                lblCosto.Text = pedidoTrasporteCalculo.costo.ToString();
                txtCostoPropuesto.Text = pedidoTrasporteCalculo.costo.ToString();
                lblDistancia.Text = pedidoTrasporteCalculo.distancia.ToString();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }
    }
}
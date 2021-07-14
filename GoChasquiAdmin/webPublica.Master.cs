using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GoChasquiAdmin
{
    public partial class webPublica : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["user_img_url"] == null)
                {
                    imgUser.ImageUrl = "~/assets/img/gochasqui/PERFIL MORADO.png";
                    Panel_admin_comercio.Visible = false;
                    Panel_admin_pedidos.Visible = false;
                    lbtnCerrar.Text = "Ingresar";
                    lbtnCambiarClave.Visible = false;
                    //lblClienteOpciones.Visible = true;
                    //lbtnAdminProductos.Visible = false;
                    //lbtnAdminUsuarios.Visible = false;
                    //lbtnReporesConsultas.Visible = false;
                }
                else
                {
                    if (Session["user_email"] == null)
                    {
                        imgUser.ImageUrl = "~/assets/img/user/user-1.jpg";
                        Panel_admin_comercio.Visible = false;
                        Panel_admin_pedidos.Visible = false;
                        lbtnCerrar.Text = "Ingresar";
                    }
                    else
                    {
                        bool rolSuperAdmin = false;
                        bool rolAdminPallevar = false;
                        bool rolAdminComercio = false;

                        lbtnCambiarClave.Visible = true;
                        lbtnCerrar.Text = "Cerrar Session";
                        imgUser.ImageUrl = Session["user_img_url"].ToString();
                        lblUsuario.Text = Session["user_name"].ToString();
                        GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                        var usuario = obj.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString());
                        var usuario_rol = obj.ListaUsuarioRoles(usuario.id_usuario);

                        if (usuario_rol.Where(x => x.id_rol == 1 && x.activo == true).Count() > 0)
                        {
                            rolSuperAdmin = true;
                        }

                        if (usuario_rol.Where(x => x.id_rol == 2 && x.activo == true).Count() > 0)
                        {
                            rolAdminPallevar = true;
                        }

                        if (usuario_rol.Where(x => x.id_rol == 3 && x.activo == true).Count() > 0)
                        {
                            rolAdminComercio = true;
                        }
                        //
                        panel_super_admin.Visible = false;
                        Panel_admin_comercio.Visible = false;
                        Panel_admin_pedidos.Visible = false;

                        if (rolSuperAdmin)
                        {
                            panel_super_admin.Visible = true;
                        }
                        else if (rolAdminPallevar)
                        {
                            Panel_admin_comercio.Visible = true;
                            Panel_admin_pedidos.Visible = true;
                        }
                        else if (rolAdminComercio)
                        {
                            Panel_admin_comercio.Visible = true;
                        }
                        else
                        {
                            panel_super_admin.Visible = false;
                            Panel_admin_comercio.Visible = false;
                            Panel_admin_pedidos.Visible = true;
                        }

                        //var pedidos = obj.ListaPedidoXUsuario(usuario.id_usuario);
                        //if (pedidos.Count() > 0)
                        //{
                        //    Panel_admin_pedidos.Visible = true;
                        //}
                        //else
                        //{
                        //    Panel_admin_pedidos.Visible = false;
                        //}

                        // Cliente
                        var cliente = obj.ListaClienteUsuarioXUsuario(usuario.id_usuario);
                        if (cliente.Count() > 0)
                        {
                            Session["id_cliente"] = cliente.First().id_cliente;
                        }
                    }
                }
            }
        }

        protected void lbtnAdminProductos_Click(object sender, EventArgs e)
        {
            Response.Redirect("abmProducto.aspx");
        }

        protected void lbtnAdminUsuarios_Click(object sender, EventArgs e)
        {
            Response.Redirect("cliente_usuarios.aspx");
        }

        protected void lbtnReporesConsultas_Click(object sender, EventArgs e)
        {
            Response.Redirect("admEnvios.aspx");
        }

        protected void lbtnAdminPedidos_Click(object sender, EventArgs e)
        {
            Response.Redirect("pedido_seguimiento.aspx");
        }


        protected void lbtnCerrar_Click(object sender, EventArgs e)
        {
            if (Session["user_email"] == null)
            { Response.Redirect("login_usuario.aspx"); }
            else
            {
                Session.Abandon();
                Response.Redirect("home.aspx");
            }
        }

        protected void lbtnActualizarFoto_Click(object sender, EventArgs e)
        {
            Response.Redirect("actualizar_foto_cliente.aspx");
        }

        protected void lbtnReset_Click(object sender, EventArgs e)
        {

        }

        protected void lbtnAdminConsole_Click(object sender, EventArgs e)
        {
            Response.Redirect("dashboard.aspx");
        }

        protected void lbtnCambiarClave_Click(object sender, EventArgs e)
        {
            Response.Redirect("cambiar_clave.aspx");
        }
    }
}
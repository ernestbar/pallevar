using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace GoChasquiAdmin
{
    public partial class cargaImagen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["id"] == null ? "" : Convert.ToString(Request.QueryString["id"]);
            string tipo_imagen = Request.QueryString["tipo_imagen"] == null ? "" : Convert.ToString(Request.QueryString["tipo_imagen"]);
            string nombre_imagen = Request.QueryString["nombre_imagen"] == null ? "" : Convert.ToString(Request.QueryString["nombre_imagen"]);

            // Obtener  del request
            HttpPostedFile image = Request.Files[0];

            if (image != null)
            {
                string ruta = "";
                switch (tipo_imagen)
                {
                    case "cliente":
                        ruta = "~/Img_cliente/" + id.ToString();
                        break;
                    case "producto":
                        ruta = "~/Img_producto/" + id.ToString();
                        break;
                    case "usuario":
                        ruta = "~/Img_usuario/" + id.ToString();
                        break;
                    case "documento_driver":
                        ruta = "~/Driver_doc/" + id.ToString();
                        break;
                    case "motorizado":
                        ruta = "~/Img_motorizado/" + id.ToString();
                        break;
                }

                string ubicacion = Server.MapPath(ruta);

                // Crea carpeta si no existe
                if (!Directory.Exists(ubicacion))
                {
                    Directory.CreateDirectory(ubicacion);
                }

                // Borrar archivo anterior
                if (File.Exists(ubicacion + "\\" + nombre_imagen))
                {
                    File.Delete(ubicacion + "\\" + nombre_imagen);
                }

                // Grabar la imagen
                image.SaveAs(ubicacion + "\\" + nombre_imagen);
            }
        }
    }
}
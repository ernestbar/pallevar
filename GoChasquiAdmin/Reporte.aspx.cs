using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace GoChasquiAdmin
{
    public partial class Reporte : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string reporte = Session["REPORTE"] == null ? "" : Convert.ToString(Session["REPORTE"]);
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["gochasquiConn"].ConnectionString);
                DataSetReportes dsRdlc = new DataSetReportes();
                SqlCommand cmd = new SqlCommand();
                SqlDataAdapter adp = new SqlDataAdapter();

                switch (reporte)
                {
                    case "Pedido":
                        DateTime fechaIni = Session["FECHA_INI"] == null ? DateTime.Today : Convert.ToDateTime(Session["FECHA_INI"]);
                        DateTime fechaFin = Session["FECHA_FIN"] == null ? DateTime.Today : Convert.ToDateTime(Session["FECHA_FIN"]);
                        int idTipoEstado = Session["ID_TIPOESTADO"] == null ? 0 : Convert.ToInt32(Session["ID_TIPOESTADO"]);
                        int idCiudad = Session["ID_CIUDAD"] == null ? 0 : Convert.ToInt32(Session["ID_CIUDAD"]);

                        // Cabecera
                        con.Open();
                        cmd.Connection = con;
                        cmd.CommandText = "rpt_pedido";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 0;
                        cmd.Parameters.AddWithValue("tipo_operacion", "A");
                        cmd.Parameters.AddWithValue("fecha_ini", fechaIni);
                        cmd.Parameters.AddWithValue("fecha_fin", fechaFin);
                        cmd.Parameters.AddWithValue("id_tipoestado", idTipoEstado);
                        cmd.Parameters.AddWithValue("id_ciudad", idCiudad);
                        con.Close();

                        adp.SelectCommand = cmd;
                        adp.Fill(dsRdlc, "pedido_cabecera");
                        adp.Dispose();

                        // Datos
                        con.Open();
                        cmd = new SqlCommand();
                        cmd.Connection = con;
                        cmd.CommandText = "rpt_pedido";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 0;
                        cmd.Parameters.AddWithValue("tipo_operacion", "B");
                        cmd.Parameters.AddWithValue("fecha_ini", fechaIni);
                        cmd.Parameters.AddWithValue("fecha_fin", fechaFin);
                        cmd.Parameters.AddWithValue("id_tipoestado", idTipoEstado);
                        cmd.Parameters.AddWithValue("id_ciudad", idCiudad);
                        con.Close();

                        adp.SelectCommand = cmd;
                        adp.Fill(dsRdlc, "pedido");
                        adp.Dispose();


                        // Llamar al reporte
                        rptvwReportes.ProcessingMode = ProcessingMode.Local;
                        rptvwReportes.LocalReport.ReportPath = Server.MapPath("~/rptPedido.rdlc");
                        rptvwReportes.LocalReport.DataSources.Clear();
                        rptvwReportes.LocalReport.DataSources.Add(new ReportDataSource("pedido_cabecera", dsRdlc.Tables["pedido_cabecera"]));
                        rptvwReportes.LocalReport.DataSources.Add(new ReportDataSource("pedido", dsRdlc.Tables["pedido"]));

                        string Url = ConvertReportToPDF(rptvwReportes.LocalReport);
                        System.Diagnostics.Process.Start(Url);
                        break;
                    default:
                        break;
                }
            }
        }

        private string ConvertReportToPDF(LocalReport rep)
        {
            string reportType = "PDF";
            string mimeType;
            string encoding;

            string deviceInfo = "<DeviceInfo>" +
               "  <OutputFormat>PDF</OutputFormat>" +
               "  <PageWidth>8.27in</PageWidth>" +
               "  <PageHeight>6.0in</PageHeight>" +
               "  <MarginTop>0.2in</MarginTop>" +
               "  <MarginLeft>0.2in</MarginLeft>" +
               "  <MarginRight>0.2in</MarginRight>" +
               "  <MarginBottom>0.2in</MarginBottom>" +
               "  <EmbedFonts>None</EmbedFonts>" +
               "</DeviceInfo>";

            Warning[] warnings;
            string[] streamIds;
            string extension = string.Empty;

            byte[] bytes = rep.Render(reportType, deviceInfo, out mimeType, out encoding, out extension, out streamIds, out warnings);
            string localPath = Server.MapPath("~/Temporal/");
            string fileName = "Pedido.pdf";
            localPath = localPath + fileName;
            System.IO.File.WriteAllBytes(localPath, bytes);
            return localPath;
        }
    }
}
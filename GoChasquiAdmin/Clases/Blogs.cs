using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace GoChasquiAdmin.Clases
{
    public class Blogs
    {
        //Base de datos
        private static Database db1 = DatabaseFactory.CreateDatabase(ConfigurationManager.AppSettings["conn"]);

        #region Propiedades
        //Propiedades privadas
        private string _PV_TIPO_OPERACION = "";
        private int _id_blog = 0;
        private int _id_usuario = 0;
        private string _titulo = "";
        private string _url_foto = "";
        private DateTime _fecha_publicacion = DateTime.Now;
        private DateTime _fecha_termino = DateTime.Now;
        private string _descripcion = "";
        private bool _activo = true;
        private DateTime _fecha = DateTime.Now;
        private int _id_usuario_aux = 0;
        private int _id_blog_aux = 0;
        private string _descripcionpr = "";
        private string _error = "";
        //Propiedades públicas
        public string PV_TIPO_OPERACION { get { return _PV_TIPO_OPERACION; } set { _PV_TIPO_OPERACION = value; } }
        public int id_blog { get { return _id_blog; } set { _id_blog = value; } }
        public int id_usuario { get { return _id_usuario; } set { _id_usuario = value; } }
        public string titulo { get { return _titulo; } set { _titulo = value; } }
        public string url_foto { get { return _url_foto; } set { _url_foto = value; } }
        public DateTime fecha_publicacion { get { return _fecha_publicacion; } set { _fecha_publicacion = value; } }
        public DateTime fecha_termino { get { return _fecha_termino; } set { _fecha_termino = value; } }
        public string descripcion { get { return _descripcion; } set { _descripcion = value; } }
        public bool activo { get { return _activo; } set { _activo = value; } }
        public DateTime fecha { get { return _fecha; } set { _fecha = value; } }
        public int id_usuario_aux { get { return _id_usuario_aux; } set { _id_usuario_aux = value; } }
        public int id_blog_aux { get { return _id_blog_aux; } set { _id_blog_aux = value; } }
        public string descripcionpr { get { return _descripcionpr; } set { _descripcionpr = value; } }
        public string error { get { return _error; } set { _error = value; } }
        #endregion

        #region Constructores
        public Blogs(int Id_blog)
        {
            _id_blog = Id_blog;
            RecuperarDatos();
        }
        public Blogs(string pV_TIPO_OPERACION, int Id_blog,int Id_usuario,
         string Titulo, string Url_foto,DateTime Fecha_publicacion,DateTime Fecha_termino,
         string Descripcion,bool Activo,DateTime Fecha,int Id_usuario_aux)
        {
            _PV_TIPO_OPERACION = pV_TIPO_OPERACION;
            _id_blog = Id_blog;
            _id_usuario = Id_usuario;
            _titulo = Titulo;
            _url_foto = Url_foto;
            _fecha_publicacion = Fecha_publicacion;
            _fecha_termino = Fecha_termino;
            _descripcion = Descripcion;
            _activo = Activo;
            _fecha = Fecha;
            _id_usuario_aux = Id_usuario_aux;
        }
        #endregion

        #region Métodos que NO requieren constructor
        //public static DataTable Lista()
        //{
        //    try
        //    {
        //        DbCommand cmd = db1.GetStoredProcCommand("PR_SEG_GET_PUESTO");
        //        cmd.CommandTimeout = int.Parse(ConfigurationManager.AppSettings["CommandTimeout"]);
        //        return db1.ExecuteDataSet(cmd).Tables[0];
        //    }
        //    catch (Exception ex)
        //    {
        //        ex.ToString();
        //        DataTable dt = new DataTable();
        //        return dt;
        //    }
        //}
        public static DataTable lista_blog_todos(int Id_usuario)
        {
            DbCommand cmd = db1.GetStoredProcCommand("lista_blog_todos");
            db1.AddInParameter(cmd, "id_usuario", DbType.Int64, Id_usuario);
            cmd.CommandTimeout = int.Parse(ConfigurationManager.AppSettings["CommandTimeout"]);
            return db1.ExecuteDataSet(cmd).Tables[0];
        }

        #endregion

        #region Métodos que requieren constructor
        private void RecuperarDatos()
        {
            try
            {
                DbCommand cmd = db1.GetStoredProcCommand("lista_blog_individual");
                cmd.CommandTimeout = int.Parse(ConfigurationManager.AppSettings["CommandTimeout"]);
                db1.AddInParameter(cmd, "id_blog", DbType.Int32, _id_blog);
               
                db1.AddOutParameter(cmd, "id_usuario", DbType.Int32, 100);
                db1.AddOutParameter(cmd, "titulo", DbType.String, 50);
                db1.AddOutParameter(cmd, "url_foto", DbType.String, 50);
                db1.AddOutParameter(cmd, "fecha_publicacion", DbType.DateTime, 50);
                db1.AddOutParameter(cmd, "fecha_termino", DbType.DateTime, 50);
                db1.AddOutParameter(cmd, "descripcion", DbType.String, 50);
                db1.AddOutParameter(cmd, "activo", DbType.Boolean, 50);
                db1.AddOutParameter(cmd, "fecha", DbType.DateTime, 50);

                db1.ExecuteNonQuery(cmd);

                _id_usuario = (int)db1.GetParameterValue(cmd, "id_usuario");
                _titulo = (string)db1.GetParameterValue(cmd, "titulo");
                _url_foto = (string)db1.GetParameterValue(cmd, "url_foto");
                _fecha_publicacion = (DateTime)db1.GetParameterValue(cmd, "fecha_publicacion");
                _fecha_termino = (DateTime)db1.GetParameterValue(cmd, "fecha_termino");
                _descripcion = (string)db1.GetParameterValue(cmd, "descripcion");
                _activo = (bool)db1.GetParameterValue(cmd, "activo");
                _fecha = (DateTime)db1.GetParameterValue(cmd, "fecha");

            }
            catch (Exception ex) { }
        }

        public string ABM()
        {
            string resultado = "";
            try
            {
                // verificar_vacios();
                DbCommand cmd = db1.GetStoredProcCommand("abm_blog");
                db1.AddInParameter(cmd, "tipo_operacion", DbType.String, _PV_TIPO_OPERACION);
                db1.AddInParameter(cmd, "id_blog", DbType.Int32, _id_blog);
                db1.AddInParameter(cmd, "id_usuario", DbType.Int32, _id_usuario);
                db1.AddInParameter(cmd, "titulo", DbType.String, _titulo);
                db1.AddInParameter(cmd, "url_foto", DbType.String, _url_foto);
                db1.AddInParameter(cmd, "fecha_publicacion", DbType.DateTime, _fecha_publicacion);
                db1.AddInParameter(cmd, "fecha_termino", DbType.DateTime, _fecha_termino);
                db1.AddInParameter(cmd, "descripcion", DbType.String, _descripcion);
                db1.AddInParameter(cmd, "activo", DbType.Boolean, _activo);
                db1.AddInParameter(cmd, "fecha", DbType.DateTime, _fecha);
                db1.AddInParameter(cmd, "id_usuario_aux", DbType.Int32, _id_usuario_aux);
                db1.AddOutParameter(cmd, "id_blog_aux", DbType.Int32, 30);
                db1.AddOutParameter(cmd, "descripcionpr", DbType.String, 250);
                db1.AddOutParameter(cmd, "error", DbType.String, 250);
                db1.ExecuteNonQuery(cmd);
                error = (string)db1.GetParameterValue(cmd, "error");
                id_blog_aux = (int)db1.GetParameterValue(cmd, "id_blog_aux");
                descripcionpr = (string)db1.GetParameterValue(cmd, "descripcionpr");
                resultado = error + "|" + descripcionpr + "|" + id_blog_aux;
                return resultado;
            }
            catch (Exception ex)
            {
                //_error = ex.Message;
                resultado = "|Se produjo un error al registrar|0";
                return resultado;
            }
        }

        #endregion
    }
}
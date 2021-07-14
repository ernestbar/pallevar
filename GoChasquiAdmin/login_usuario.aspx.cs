using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net;
using System.Text;
using System.IO;
using System.Web.Script.Serialization;

namespace GoChasquiAdmin
{
    public partial class login_usuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["op"] == "regneg")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Debe registrarse como usuario antes de dar de alta su negocio.');", true);
                }

                if (Session["LoginWith"] != null)
                {
                    switch (Session["LoginWith"].ToString())
                    {
                        case "google":
                            FetchUserSocialDetail("google");
                            break;
                        case "facebook":
                            FetchUserSocialDetail("facebook");
                            break;
                    }
                }
                if (Session["user_email"] != null)
                {
                    GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
                    if (obj.ListaUsuarioIndividual_x_Email(Session["user_email"].ToString()).id_usuario > 0)
                    {
                        Response.Redirect("home.aspx");
                    }
                    else
                    {
                        string error = "";
                        var usuario = obj.InsertarUsuario(1, 0, Session["user_email"].ToString(), Session["user_name"].ToString(), Session["user_family_name"].ToString(), "", Session["user_name"].ToString(), true, Session["user_img_url"].ToString(), Session["user_token"].ToString(), DateTime.Now, "", int.Parse(Session["CIUDAD"].ToString()));
                        error += usuario.error;
                        int IdUsuario = usuario.id_usuario;
                        // Insertar en Usuario Rol
                        if (error == "")
                        {
                            IdUsuario = usuario.id_usuario;
                            var usuario_rol = obj.InsertarUsuarioRol(1, IdUsuario, 6, true);
                            error += usuario_rol.error;
                        }

                        if (error == "")
                        {
                            Response.Redirect("home.aspx");
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + error + "');", true);
                        }
                    }
                }
            }
        }

        protected void GoogleBtnClick(object sender, EventArgs e)
        {
            if (Session["CIUDAD"].ToString() == "0")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Debe seleccionar la ciudad.');", true);
                return;
            }

            GetSocialCredentials("google");
        }
        protected void FacebookBtnClick(object sender, EventArgs e)
        {
            if (Session["CIUDAD"].ToString() == "0")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('Debe seleccionar la ciudad.');", true);
                return;
            }

            GetSocialCredentials("facebook");
        }
        private void GetSocialCredentials(String provider)
        {
            if (provider == "google")
            {
                string Googleurl = String.Format(ConfigurationManager.AppSettings["Googleurl"], ConfigurationManager.AppSettings["google_redirect_url"], ConfigurationManager.AppSettings["google_client_id"]);
                Session["LoginWith"] = provider;
                Response.Redirect(Googleurl);
            }
            else if (provider == "facebook")
            {
                string Facebookurl = string.Format(ConfigurationManager.AppSettings["Facebook_url"], ConfigurationManager.AppSettings["Facebook_AppId"], ConfigurationManager.AppSettings["Facebook_RedirectUrl"], ConfigurationManager.AppSettings["Facebook_scope"]);
                Session["LoginWith"] = provider;
                Response.Redirect(Facebookurl);
            }
        }

        private void FetchUserSocialDetail(String provider)
        {
            try
            {
                if (provider == "google")
                {
                    var url = Request.Url.Query;
                    if (!string.IsNullOrEmpty(url))
                    {
                        string queryString = url.ToString();
                        string[] words = queryString.Split('=');
                        string code = words[1];
                        if (!string.IsNullOrEmpty(code))
                        {
                            //string Parameters =  "code=" + code + "&client_id=" + ConfigurationManager.AppSettings["google_client_id"] + "&client_secret=" + ConfigurationManager.AppSettings["google_client_secret"] + "&redirect_uri=" + ConfigurationManager.AppSettings["google_redirect_url"] + "&grant_type=authorization_code";
                            string parameters = string.Format("code={0}&client_id={1}&client_secret={2}&redirect_uri={3}&grant_type=authorization_code",
                                code,
                                ConfigurationManager.AppSettings["google_client_id"],
                                ConfigurationManager.AppSettings["google_client_secret"],
                                ConfigurationManager.AppSettings["google_redirect_url"]);
                            string response = MakeWebRequest(ConfigurationManager.AppSettings["googleoAuthUrl"], "POST", "application/x-www-form-urlencoded", parameters);
                            GoogleToken tokenInfo = new JavaScriptSerializer().Deserialize<GoogleToken>(response);

                            if (tokenInfo != null)
                            {
                                if (!string.IsNullOrEmpty(tokenInfo.access_token))
                                {
                                    var googleInfo = MakeWebRequest(ConfigurationManager.AppSettings["googleoAccessUrl"] + tokenInfo.access_token, "GET");
                                    GoogleInfo profile = new JavaScriptSerializer().Deserialize<GoogleInfo>(googleInfo);
                                    txtResponse.Text = googleInfo;
                                    Session["user_img_url"] = profile.picture;
                                    Session["user_name"] = profile.given_name;
                                    Session["user_family_name"] = profile.family_name;
                                    Session["user_email"] = profile.email;
                                    Session["user_token"] = tokenInfo.ToString();
                                }
                            }
                        }
                    }
                    Session.Remove("LoginWith");

                }
                else if (provider == "facebook")
                {
                    if (Request["code"] != null)
                    {
                        string url = string.Format(ConfigurationManager.AppSettings["FacebookOAuthurl"],
                            ConfigurationManager.AppSettings["Facebook_AppId"],
                            ConfigurationManager.AppSettings["Facebook_RedirectUrl"],
                            ConfigurationManager.AppSettings["Facebook_scope"],
                            Request["code"].ToString(),
                            ConfigurationManager.AppSettings["Facebook_AppSecret"]);

                        string tokenResponse = MakeWebRequest(url, "GET");
                        var tokenInfo = new JavaScriptSerializer().Deserialize<FacebookToken>(tokenResponse);
                        var facebookInfoJson = MakeWebRequest(ConfigurationManager.AppSettings["FacebookAccessUrl"] + tokenInfo.access_token, "GET");
                        FacebookInfo objUser = new JavaScriptSerializer().Deserialize<FacebookInfo>(facebookInfoJson);
                        txtResponse.Text = facebookInfoJson;

                        Session["user_img_url"] = objUser.picture.Data.Url;
                        Session["user_name"] = objUser.first_name;
                        Session["user_family_name"] = objUser.last_name;
                        Session["user_email"] = objUser.email;
                        Session["user_token"] = tokenInfo.ToString();
                    }
                }
                Session.Remove("LoginWith");
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Msj", "mostrarMensaje('" + ex.Message + "');", true);
            }
        }

        /// <summary>
        /// Calling 3rd party web apis. 
        /// </summary>
        /// <param name="destinationUrl"></param>
        /// <param name="methodName"></param>
        /// <param name="requestJSON"></param>
        /// <returns></returns>
        public string MakeWebRequest(string destinationUrl, string methodName, string contentType = "", string requestJSON = "")
        {
            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(destinationUrl);
                request.Method = methodName;
                if (methodName == "POST")
                {
                    byte[] bytes = System.Text.Encoding.ASCII.GetBytes(requestJSON);
                    request.ContentType = contentType;
                    request.ContentLength = bytes.Length;
                    using (Stream requestStream = request.GetRequestStream())
                    {
                        requestStream.Write(bytes, 0, bytes.Length);
                    }
                }
                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                {
                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                        {
                            return reader.ReadToEnd();
                        }
                    }
                }

                return null;
            }
            catch (WebException webEx)
            {
                return webEx.Message;
            }
        }
        public class GoogleToken
        {
            public string access_token { get; set; }
            public string token_type { get; set; }
            public int expires_in { get; set; }
            public string id_token { get; set; }
            public string refresh_token { get; set; }
        }
        public class GoogleInfo
        {
            public string id { get; set; }
            public string email { get; set; }
            public bool verified_email { get; set; }
            public string name { get; set; }
            public string given_name { get; set; }
            public string family_name { get; set; }
            public string picture { get; set; }
            public string locale { get; set; }
            public string gender { get; set; }
        }

        public class FacebookToken
        {
            public string access_token { get; set; }
            public string token_type { get; set; }
            public int expires_in { get; set; }
        }

        public class FacebookInfo
        {
            public string id { get; set; }
            public string first_name { get; set; }
            public string last_name { get; set; }
            public string gender { get; set; }
            public string locale { get; set; }
            public string link { get; set; }
            public string email { get; set; }
            public Picture picture { get; set; }
        }

        public class Picture
        {
            public Data Data { get; set; }
        }

        public class Data
        {
            public string Height { get; set; }
            public string Is_Silhouette { get; set; }
            public string Url { get; set; }
            public string Width { get; set; }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            GCws1.WSGoChasquiClient obj = new GCws1.WSGoChasquiClient();
            var resultado = obj.ValidarUsuario(txtEmail.Text, txtPassword.Text);
            int id = resultado.id_usuario;
            if (id > 0)
            {
                Session["user_img_url"] = resultado.url_foto;
                Session["user_name"] = resultado.nombre;
                Session["user_email"] = resultado.email;
                Session["user_token"] = resultado.url_foto;
                Session["id_usuario"] = resultado.id_usuario;
                Session["id_ciudad"] = resultado.id_ciudad;
                if (Request.QueryString["op"] == "regneg")
                {
                    Response.Redirect("registra_negocio.aspx");
                }
                else
                {
                    Response.Redirect("home.aspx");
                }
            }
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("registra_usuario.aspx");
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("reset_password.aspx");
        }

        protected void ddlCiudad_DataBound(object sender, EventArgs e)
        {
            ListItem todos = new ListItem();
            todos.Text = "Seleccione la Ciudad";
            todos.Value = "0";
            ddlCiudad.Items.Insert(0, todos);
            Session["CIUDAD"] = "0";
        }

        protected void ddlCiudad_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["CIUDAD"] = ddlCiudad.SelectedValue;
        }
    }
}
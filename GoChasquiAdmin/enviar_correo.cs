using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Configuration;
using System.Net.Mail;
using System.Web;

namespace GoChasquiAdmin
{
    public class enviar_correo
    {
        
        public string enviar(string Email,string subjet,string mensaje,string adjunto)
        {
            string resultado = "";
            try
            {
                var smtpSection = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
                string strHost = smtpSection.Network.Host;
                int port = smtpSection.Network.Port;
                string strUserName = smtpSection.Network.UserName;
                string strFromPass = smtpSection.Network.Password;
                SmtpClient smtp = new SmtpClient(strHost, port);
                NetworkCredential cert = new NetworkCredential(strUserName, strFromPass);
                smtp.Credentials = cert;
                smtp.EnableSsl = true;
                MailMessage msg = new MailMessage(smtpSection.From, Email);
                msg.Subject = subjet;
                msg.IsBodyHtml = true;
                msg.Body = mensaje;
                smtp.Send(msg);
                resultado = "OK";
                return resultado;
            }
            catch (Exception ex)
            {
                resultado = ex.ToString();
                return resultado; 
            }
            
        }
    }
}
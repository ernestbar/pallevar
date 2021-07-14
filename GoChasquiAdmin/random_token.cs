using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace GoChasquiAdmin
{
    public class random_token
    {
        const string alfabeto = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        private Random _rnd;
        private static random_token _instancia;

        private random_token()
        {
            _rnd = new Random(DateTime.Now.Millisecond);
        }

        public static random_token Instancia()
        {
            if (_instancia == null)
            {
                _instancia = new random_token();
            }
            return _instancia;
        }

        public string Generar(int longitud)
        {
            StringBuilder token = new StringBuilder();

            for (int i = 0; i < longitud; i++)
            {
                int indice = _rnd.Next(alfabeto.Length);
                token.Append(alfabeto[indice]);
            }

            return token.ToString();
        }
    }
}
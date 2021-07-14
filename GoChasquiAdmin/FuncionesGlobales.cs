using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace GoChasquiAdmin
{
    public static class FuncionesGlobales
    {
        public static decimal numeroDecimal(string numeroTexto)
        {
            if (String.IsNullOrWhiteSpace(numeroTexto))
            {
                return 0;
            }
            else
            {
                decimal numero;
                decimal.TryParse(numeroTexto, out numero);
                return numero;
            }
        }

        public static int numeroEntero(string numeroTexto)
        {
            if (String.IsNullOrWhiteSpace(numeroTexto))
            {
                return 0;
            }
            else
            {
                int numero;
                int.TryParse(numeroTexto, out numero);
                return numero;
            }
        }
    }
}
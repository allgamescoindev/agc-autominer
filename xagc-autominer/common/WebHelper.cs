using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace xagc_autominer.common
{
    public class WebHelper
    {
        public static String GetUrl(String url)
        {
            string ret = "";
            try
            {
                HttpWebRequest webrequest = (HttpWebRequest)HttpWebRequest.Create(url);
                webrequest.Timeout = 200000;
                HttpWebResponse webreponse = (HttpWebResponse)webrequest.GetResponse();
                StreamReader sr = new StreamReader(webreponse.GetResponseStream(), Encoding.UTF8);
                ret = sr.ReadToEnd();
                sr.Close();
                webreponse.Close();
            }
            catch
            {
                ret = "error";
            }
            return ret;
        }
    }
}

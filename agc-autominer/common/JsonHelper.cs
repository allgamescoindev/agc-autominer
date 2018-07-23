using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace agc_autominer.common
{
    public class JsonHelper
    {
        public static T JsonToModel<T>(String jsonModel)
        {
            if (!String.IsNullOrEmpty(jsonModel))
            {
                T model = default(T);
                try
                {
                    model = JsonConvert.DeserializeObject<T>(jsonModel);
                }
                catch
                {
                    model = default(T);
                }
                return model;
            }
            else
            {
                return default(T);
            }
        }

        public static String ModelToJson<T>(T model)
        {
            if (model != null)
            {
                return JsonConvert.SerializeObject(model);
            }
            else
            {
                return null;
            }
        }
    }
}

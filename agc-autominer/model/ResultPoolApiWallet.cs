using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace agc_autominer.model
{
    public class ResultPoolApiWallet
    {
        public string currency { get; set; }
        public string unsold { get; set; }
        public string balance { get; set; }
        public string unpaid { get; set; }
        public string paid24h { get; set; }
        public string total { get; set; }
    }
}

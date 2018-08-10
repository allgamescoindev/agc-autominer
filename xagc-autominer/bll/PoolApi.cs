using xagc_autominer.common;
using xagc_autominer.model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xagc_autominer.bll
{
    public class PoolApi
    {
        public ResultPoolApiWallet getWallet(string urlPre, string walletAddress, string coin)
        {
            ResultPoolApiWallet mResultPoolApiWalletRetuen = null;
            string rel = WebHelper.GetUrl(urlPre + "/api/wallet?address=" + walletAddress);
            List<ResultPoolApiWallet> mResultPoolApiWallets = JsonHelper.JsonToModel<List<ResultPoolApiWallet>>(rel);
            if (mResultPoolApiWallets != null)
            {
                foreach (ResultPoolApiWallet mResultPoolApiWallet in mResultPoolApiWallets)
                {
                    if (mResultPoolApiWallet.currency.Equals(coin))
                    {
                        mResultPoolApiWalletRetuen = mResultPoolApiWallet;
                    }
                }
            }
            else
            {
                ResultPoolApiWallet mResultPoolApiWallet = JsonHelper.JsonToModel<ResultPoolApiWallet>(rel);
                mResultPoolApiWalletRetuen = mResultPoolApiWallet;
            }
            return mResultPoolApiWalletRetuen;
        }
    }
}

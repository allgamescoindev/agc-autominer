using xagc_autominer.model;
using xagc_autominer.bll;
using xagc_autominer.common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xagc_autominer.bll
{
    public class PoolBLL
    {
        private static List<Pool> _mPools = null;
        
        public static List<Pool> mPools
        {
            get {
                if (_mPools == null)
                {
                    string strPools = IniHelper.INIGetStringValue(Config.iniFilePath, "CONFIG","POOLS",null);
                    _mPools = JsonHelper.JsonToModel<List<Pool>>(strPools);
                }
                return _mPools;
            }
            set {
                _mPools = value;
                IniHelper.INIWriteValue(Config.iniFilePath, "CONFIG", "POOLS", JsonHelper.ModelToJson<List<Pool>>(_mPools));
            }
        }
        
        public List<Pool> getAll()
        {
            return mPools;
        }

        public Pool get(string poolName)
        {
            if (mPools != null)
            {
                foreach (Pool mPool in mPools)
                {
                    if (mPool.poolName.Equals(poolName))
                    {
                        return mPool;
                    }
                }
            }
            return null;
        }
        
        public bool add(Pool mPool)
        {
            List<Pool> myPools = mPools;
            if (myPools == null)
            {
                myPools = new List<Pool>();
            }
            for (int i = 0; i < myPools.Count; i++)
            {
                if (myPools[i].poolName.Equals(mPool.poolName))
                {
                    return false;
                }
            }
            myPools.Add(mPool);
            mPools = myPools;
            return true;
        }

        public bool update(Pool mPool)
        {
            List<Pool> myPools = mPools;
            if (myPools != null)
            {
                for (int i = 0; i < myPools.Count; i++)
                {
                    if (myPools[i].poolName.Equals(mPool.poolName))
                    {
                        myPools[i] = mPool;
                        mPools = myPools;
                        return true;
                    } 
                }
            }
            return false;
        }

        public bool delete(string poolName)
        {
            List<Pool> myPools = mPools;
            if (myPools != null)
            {
                int index = -1;
                for (int i = 0; i < myPools.Count; i++)
                {
                    if (myPools[i].poolName.Equals(poolName))
                    {
                        index = i;
                    }
                }
                if (index > -1)
                {
                    myPools.RemoveAt(index);
                    mPools = myPools;
                    return true;
                }
            }
            return false;
        }
    }
}

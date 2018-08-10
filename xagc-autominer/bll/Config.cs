using xagc_autominer.common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace xagc_autominer.bll
{
    public class Config
    {
        public static string iniFilePath = System.Windows.Forms.Application.StartupPath +  "\\config.ini";

        public static string configCoin = "XAGC";

        public static bool configStartUp
        {
            get { return WinOSHelper.getStartUpState(); }
            set { WinOSHelper.setStartUp(value); }
        }
        public static string configAccount
        {
            get { return IniHelper.INIGetStringValue(iniFilePath, "CONFIG", "ACCOUNT", ""); }
            set { IniHelper.INIWriteValue(iniFilePath, "CONFIG", "ACCOUNT", value); }
        }
        public static string configPool
        {
            get { return IniHelper.INIGetStringValue(iniFilePath, "CONFIG", "POOL", ""); }
            set { IniHelper.INIWriteValue(iniFilePath, "CONFIG", "POOL", value); }
        }
        public static int configGPUType
        {
            get
            {
                int index;
                int.TryParse(IniHelper.INIGetStringValue(iniFilePath, "CONFIG", "GPUTYPE", ""), out index);
                return index;
            }
            set
            {
                IniHelper.INIWriteValue(iniFilePath, "CONFIG", "GPUTYPE", value.ToString());
            }
        }
    }
}

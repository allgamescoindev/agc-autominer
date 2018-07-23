using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace agc_autominer.common
{
    public class IniHelper
    {
        #region INI file operation

        #region API declaration

        [DllImport("kernel32.dll", CharSet = CharSet.Auto)]
        private static extern uint GetPrivateProfileSectionNames(IntPtr lpszReturnBuffer, uint nSize, string lpFileName);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto)]
        private static extern uint GetPrivateProfileSection(string lpAppName, IntPtr lpReturnedString, uint nSize, string lpFileName);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto)]
        private static extern uint GetPrivateProfileString(string lpAppName, string lpKeyName, string lpDefault, [In, Out] char[] lpReturnedString, uint nSize, string lpFileName);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto)]
        private static extern uint GetPrivateProfileString(string lpAppName, string lpKeyName, string lpDefault, StringBuilder lpReturnedString, uint nSize, string lpFileName);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto)]
        private static extern uint GetPrivateProfileString(string lpAppName, string lpKeyName, string lpDefault, string lpReturnedString, uint nSize, string lpFileName);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto)]
        [return: MarshalAs(UnmanagedType.Bool)]
        private static extern bool WritePrivateProfileSection(string lpAppName, string lpString, string lpFileName);

        [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        private static extern bool WritePrivateProfileString(string lpAppName, string lpKeyName, string lpString, string lpFileName);

        #endregion

        #region encapsulation

        public static string[] INIGetAllSectionNames(string iniFile)
        {
            uint MAX_BUFFER = 32767;
            string[] sections = new string[0];
            IntPtr pReturnedString = Marshal.AllocCoTaskMem((int)MAX_BUFFER * sizeof(char));
            uint bytesReturned = IniHelper.GetPrivateProfileSectionNames(pReturnedString, MAX_BUFFER, iniFile);
            if (bytesReturned != 0)
            {
                string local = Marshal.PtrToStringAuto(pReturnedString, (int)bytesReturned).ToString();
                sections = local.Split(new char[] { '\0' }, StringSplitOptions.RemoveEmptyEntries);
            }
            Marshal.FreeCoTaskMem(pReturnedString);
            return sections;
        }

        public static string[] INIGetAllItems(string iniFile, string section)
        {
            uint MAX_BUFFER = 32767; 
            string[] items = new string[0];  
            IntPtr pReturnedString = Marshal.AllocCoTaskMem((int)MAX_BUFFER * sizeof(char));
            uint bytesReturned = IniHelper.GetPrivateProfileSection(section, pReturnedString, MAX_BUFFER, iniFile);
            if (!(bytesReturned == MAX_BUFFER - 2) || (bytesReturned == 0))
            {
                string returnedString = Marshal.PtrToStringAuto(pReturnedString, (int)bytesReturned);
                items = returnedString.Split(new char[] { '\0' }, StringSplitOptions.RemoveEmptyEntries);
            }
            Marshal.FreeCoTaskMem(pReturnedString); 
            return items;
        }

        public static string[] INIGetAllItemKeys(string iniFile, string section)
        {
            string[] value = new string[0];
            const int SIZE = 1024 * 10;
            if (string.IsNullOrEmpty(section))
            {
                throw new ArgumentException("The name of the node must be specified", "section");
            }
            char[] chars = new char[SIZE];
            uint bytesReturned = IniHelper.GetPrivateProfileString(section, null, null, chars, SIZE, iniFile);
            if (bytesReturned != 0)
            {
                value = new string(chars).Split(new char[] { '\0' }, StringSplitOptions.RemoveEmptyEntries);
            }
            chars = null;
            return value;
        }

        public static string INIGetStringValue(string iniFile, string section, string key, string defaultValue)
        {
            string value = defaultValue;
            const int SIZE = 1024 * 10;
            if (string.IsNullOrEmpty(section))
            {
                throw new ArgumentException("The name of the node must be specified", "section");
            }
            if (string.IsNullOrEmpty(key))
            {
                throw new ArgumentException("You must specify the key", "key");
            }
            StringBuilder sb = new StringBuilder(SIZE);
            uint bytesReturned = IniHelper.GetPrivateProfileString(section, key, defaultValue, sb, SIZE, iniFile);

            if (bytesReturned != 0)
            {
                value = sb.ToString();
            }
            sb = null;

            return value;
        }

        public static bool INIWriteItems(string iniFile, string section, string items)
        {
            if (string.IsNullOrEmpty(section))
            {
                throw new ArgumentException("The name of the node must be specified", "section");
            }

            if (string.IsNullOrEmpty(items))
            {
                throw new ArgumentException("Key value pairs must be specified", "items");
            }

            return IniHelper.WritePrivateProfileSection(section, items, iniFile);
        }

        public static bool INIWriteValue(string iniFile, string section, string key, string value)
        {
            if (string.IsNullOrEmpty(section))
            {
                throw new ArgumentException("The name of the node must be specified", "section");
            }
            if (string.IsNullOrEmpty(key))
            {
                throw new ArgumentException("The key must be specified", "key");
            }
            if (value == null)
            {
                throw new ArgumentException("The value can not be null", "value");
            }
            return IniHelper.WritePrivateProfileString(section, key, value, iniFile);
        }

        public static bool INIDeleteKey(string iniFile, string section, string key)
        {
            if (string.IsNullOrEmpty(section))
            {
                throw new ArgumentException("The name of the node must be specified", "section");
            }
            if (string.IsNullOrEmpty(key))
            {
                throw new ArgumentException("The key must be specified", "key");
            }
            return IniHelper.WritePrivateProfileString(section, key, null, iniFile);
        }

        public static bool INIDeleteSection(string iniFile, string section)
        {
            if (string.IsNullOrEmpty(section))
            {
                throw new ArgumentException("The name of the node must be specified", "section");
            }
            return IniHelper.WritePrivateProfileString(section, null, null, iniFile);
        }

        public static bool INIEmptySection(string iniFile, string section)
        {
            if (string.IsNullOrEmpty(section))
            {
                throw new ArgumentException("The name of the node must be specified", "section");
            }
            return IniHelper.WritePrivateProfileSection(section, string.Empty, iniFile);
        }

        private void TestIniINIOperation()
        {
            string file = "F:\\TestIni.ini";

            INIWriteValue(file, "Desktop", "Color", "Red");
            INIWriteValue(file, "Desktop", "Width", "3270");

            INIWriteValue(file, "Toolbar", "Items", "Save,Delete,Open");
            INIWriteValue(file, "Toolbar", "Dock", "True");

            INIWriteItems(file, "Menu", "File=文件\0View=视图\0Edit=编辑");

            string[] sections = INIGetAllSectionNames(file);

            string[] items = INIGetAllItems(file, "Menu");

            string[] keys = INIGetAllItemKeys(file, "Menu");

            string value = INIGetStringValue(file, "Desktop", "color", null);

            INIDeleteKey(file, "desktop", "color");

            INIDeleteSection(file, "desktop");

            INIEmptySection(file, "toolbar");

        }
        #endregion

        #endregion
    }
}

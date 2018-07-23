using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace agc_autominer.common
{
    public class WinOSHelper
    {

        /// <summary>
        /// Modifies the key value of the program in the registry
        /// </summary>
        /// <param name="isStartUp"></param>
        /// <param name="programName"></param>
        public static void setStartUp(bool isStartUp)
        {
            string path = Application.ExecutablePath;
            string programName = System.IO.Path.GetFileName(Application.ExecutablePath);

            RegistryKey RkeyLocalMachine = Registry.CurrentUser;
            RegistryKey RkeyRun = RkeyLocalMachine.CreateSubKey(@"Software\Microsoft\Windows\CurrentVersion\Run");

            if (isStartUp)
            {
                RkeyRun.SetValue(programName, path);
                RkeyLocalMachine.Close();
                RkeyRun.Close();
            }
            else
            {
                RkeyRun.DeleteValue(programName, false);
                RkeyLocalMachine.Close();
                RkeyRun.Close();
            }
        }

        /// <summary>
        /// Get StartUp State
        /// </summary>
        /// <param name="programName"></param>
        /// <returns></returns>
        public static bool getStartUpState()
        {
            string path = Application.ExecutablePath;
            string programName = System.IO.Path.GetFileName(Application.ExecutablePath);

            RegistryKey RkeyRun = Registry.CurrentUser.CreateSubKey(@"Software\Microsoft\Windows\CurrentVersion\Run");

            if (RkeyRun.GetValue(programName) != null)
            {
                RkeyRun.Close();
                return true;
            }
            else
            {
                RkeyRun.Close();
                return false;
            }
        }

        /// <summary>
        /// Is64BitOperatingSystem
        /// </summary>
        /// <returns></returns>
        public static bool get64bit()
        {
            return Environment.Is64BitOperatingSystem;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace miner.common
{
    public class ConsoleHelper
    {
        /*  Example:
            ConsoleHelper.AllocConsole();
            IntPtr windowHandle = ConsoleHelper.FindWindow(null, Process.GetCurrentProcess().MainModule.FileName);
            IntPtr closeMenu = ConsoleHelper.GetSystemMenu(windowHandle, IntPtr.Zero);
            uint SC_CLOSE = 0xF060;
            ConsoleHelper.RemoveMenu(closeMenu, SC_CLOSE, 0x0);
            for (int i = 0; i < 100; i++)
            {
                Console.WriteLine("i=:" + i);
            }
        */

        [DllImport("Kernel32.dll")]
        public static extern bool AllocConsole(); //Start windows
        [DllImport("kernel32.dll", EntryPoint = "FreeConsole")]
        public static extern bool FreeConsole();      //Free Console
        [DllImport("user32.dll", EntryPoint = "FindWindow")]
        public extern static IntPtr FindWindow(string lpClassName, string lpWindowName);//Find Window  

        [DllImport("user32.dll", EntryPoint = "GetSystemMenu")]
        public extern static IntPtr GetSystemMenu(IntPtr hWnd, IntPtr bRevert); //Get System Menu  

        [DllImport("user32.dll", EntryPoint = "RemoveMenu")]
        public extern static IntPtr RemoveMenu(IntPtr hMenu, uint uPosition, uint uFlags); //Remove Menu  
    }
}

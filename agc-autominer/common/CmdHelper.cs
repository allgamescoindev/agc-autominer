using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace agc_autominer.common
{
    public class CmdHelper
    {
        private Process proc = null;
        /// <summary>
        /// Construction method
        /// </summary>
        public CmdHelper()
        {
            proc = new Process();
        }
        /// <summary>
        /// Execute the CMD statement
        /// </summary>
        /// <param name="cmd">The CMD command to be executed</param>
        public string RunCmd(string cmd)
        {
            proc.StartInfo.CreateNoWindow = true;
            proc.StartInfo.FileName = "cmd.exe";
            proc.StartInfo.UseShellExecute = false;
            proc.StartInfo.RedirectStandardError = true;
            proc.StartInfo.RedirectStandardInput = true;
            proc.StartInfo.RedirectStandardOutput = true;
            proc.Start();
            proc.StandardInput.WriteLine(cmd);
            proc.StandardInput.WriteLine("exit");
            string outStr = proc.StandardOutput.ReadToEnd();
            proc.Close();
            return outStr;
        }
        /// <summary>
        /// Open the software and execute the command
        /// </summary>
        /// <param name="programName">Software path plus name (.exe file)</param>
        /// <param name="cmd">An order to be executed</param>
        public void RunProgram(string programName, string cmd)
        {
            Process proc = new Process();
            proc.StartInfo.CreateNoWindow = true;
            proc.StartInfo.FileName = programName;
            proc.StartInfo.UseShellExecute = false;
            proc.StartInfo.RedirectStandardError = true;
            proc.StartInfo.RedirectStandardInput = true;
            proc.StartInfo.RedirectStandardOutput = true;
            proc.Start();
            if (cmd.Length != 0)
            {
                proc.StandardInput.WriteLine(cmd);
            }
            proc.Close();
        }
        /// <summary>
        /// Open the software
        /// </summary>
        /// <param name="programName">Software path plus name (.exe file)</param>
        public void RunProgram(string programName)
        {
            this.RunProgram(programName, "");
        }

    }
}

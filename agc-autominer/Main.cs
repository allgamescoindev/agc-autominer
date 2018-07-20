using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using miner.common;
using miner.bll;
using System.Threading;

namespace agc_autominer
{
    public partial class Main : Form
    {
        public static bool MiningState = false;

        public Main()
        {
            InitializeComponent();
            initData();
        }

        private void btnStartMining_Click(object sender, EventArgs e)
        {
            doSaveConfig();
            doStartMining();
        }

        private void btnSaveConfig_Click(object sender, EventArgs e)
        {
            doSaveConfig();
            loadConfig();
        }

        private void Main_FormClosed(object sender, FormClosedEventArgs e)
        {
            Miner.DoCloseMiner();
        }


        public void initData()
        {
            loadConfig();
            if (Config.configStartUp)
            {
                if (!MiningState)
                {
                    doStartMining();
                }
            }
        }

        public void loadConfig()
        {
            txtAccount.Text = Config.configAccount;
            txtPool.Text = Config.configPool;
            ddlGPU.SelectedIndex = Config.configGPUType;
            cbStartUp.Checked = Config.configStartUp;
        }

        private void OutputHandler(object sendingProcess, DataReceivedEventArgs outLine)
        {
            if (txtCmdOutput != null && outLine != null && !String.IsNullOrEmpty(outLine.Data))
            {
                if (txtCmdOutput.TextLength > 10000)
                {
                    BeginInvoke(new Action(() =>
                    {
                        txtCmdOutput.Text = "";
                    }));
                }
                BeginInvoke(new Action(() =>
                {
                    txtCmdOutput.AppendText(outLine.Data + "\n");
                }));
            }
        }

        private void doSaveConfig()
        {
            string configAccount = txtAccount.Text;
            if (String.IsNullOrEmpty(configAccount))
            {
                MessageBox.Show("Account is null!");
            }
            else
            {
                Config.configAccount = txtAccount.Text.Trim();
            }

            string configPool = txtPool.Text;
            if (String.IsNullOrEmpty(configPool))
            {
                MessageBox.Show("Pool url is null!");
            }
            else
            {
                Config.configPool = txtPool.Text.Trim().Replace("stratum+tcp://", "").Replace("http://", "").Replace("https://", "");
            }

            Config.configGPUType = ddlGPU.SelectedIndex;

            Config.configStartUp = cbStartUp.Checked;
        }

        private void doStartMining()
        {
            new Thread(() =>
            {
                MiningState = Miner.DoStartMining(MiningState, OutputHandler);
                BeginInvoke(new Action(() =>
                {
                    if (MiningState)
                    {
                        btnStartMining.Text = "Stop Mining";
                    }
                    else
                    {
                        btnStartMining.Text = "Start Mining";
                        txtCmdOutput.Text = "";
                    }
                }));
            }).Start();
        }
    }
}

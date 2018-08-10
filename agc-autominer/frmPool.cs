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
using xagc_autominer.common;
using xagc_autominer.bll;
using System.Threading;
using xagc_autominer.model;

namespace xagc_autominer
{
    public partial class frmPool : Form
    {
        public delegate void LoadConfigDelegate();
        public LoadConfigDelegate loadConfigDelegate;

        public frmPool()
        {
            InitializeComponent();

            initData();
            ddlPool.SelectedIndex = 0;
        }

        public void initData()
        {
            //ddlPool.Items.Clear();
            List<Pool> mPools = new PoolBLL().getAll();
            List<Pool> myPools = new List<Pool>();
            if (mPools != null)
            {
                mPools.ForEach(i => myPools.Add(i));
            }
            myPools.Insert(0, new Pool() { poolName = "Add" });
            ddlPool.DataSource = myPools;
            ddlPool.ValueMember = "poolName";
            ddlPool.DisplayMember = "poolName";

            if (loadConfigDelegate != null)
            {
                loadConfigDelegate();
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            string strPoolNameCurrent = ddlPool.SelectedItem != null ? ((Pool)ddlPool.SelectedItem).poolName : null;
            string strPoolName = txtPoolName.Text.Trim();
            string strPoolStratumUrl = txtStratumUrl.Text.Trim().Replace("stratum+tcp://", "").Replace("http://", "").Replace("https://", "");
            string strApiUrl = txtApiUrl.Text.Trim();
            if (string.IsNullOrEmpty(strPoolName))
            {
                MessageBox.Show("Name is null!");
            }
            if (string.IsNullOrEmpty(strPoolStratumUrl))
            {
                MessageBox.Show("Stratum Url is null!");
            }

            if (strPoolNameCurrent.Equals("Add"))
            {
                //add
                if (new PoolBLL().add(new Pool() { poolName = strPoolName, poolStratumUrl = strPoolStratumUrl, poolApiUrl = strApiUrl }))
                {
                    initData();
                    ddlPool.SelectedValue = strPoolName;
                }
                else
                {
                    MessageBox.Show("Add Failure");
                }
            }
            else
            {
                //update
                if (new PoolBLL().update(new Pool() { poolName = strPoolName, poolStratumUrl = strPoolStratumUrl, poolApiUrl = strApiUrl }))
                {
                    initData();
                    ddlPool.SelectedValue = strPoolName;
                }
                else
                {
                    MessageBox.Show("Update Failure");
                }
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            string strPoolNameCurrent = ddlPool.SelectedItem != null ? ((Pool)ddlPool.SelectedItem).poolName : null;
            if (new PoolBLL().delete(strPoolNameCurrent))
            {
                initData();
            }
            else
            {
                MessageBox.Show("Delete Failure");
            }
        }

        private void ddlPool_SelectedIndexChanged(object sender, EventArgs e)
        {
            string strPoolNameCurrent = ddlPool.SelectedItem != null ? ((Pool)ddlPool.SelectedItem).poolName : null;
            Pool mPool = new PoolBLL().get(strPoolNameCurrent);
            if (mPool == null)
            {
                mPool = new Pool();
            }
            if (strPoolNameCurrent.Equals("Add"))
            {
                txtPoolName.Text = "pool's name";
                txtStratumUrl.Text = "url and port";
                txtApiUrl.Text = "pool that powered by yiimp";
                txtPoolName.ReadOnly = false;
                btnDelete.Visible = false;
            }
            else
            {
                txtPoolName.Text = mPool.poolName;
                txtStratumUrl.Text = mPool.poolStratumUrl;
                txtApiUrl.Text = mPool.poolApiUrl;
                txtPoolName.ReadOnly = true;
                btnDelete.Visible = true;
            }
        }

        private void frmPool_FormClosed(object sender, FormClosedEventArgs e)
        {

        }
    }
}

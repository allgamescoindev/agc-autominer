namespace xagc_autominer
{
    partial class Main
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Main));
            this.btnStartMining = new System.Windows.Forms.Button();
            this.txtCmdOutput = new System.Windows.Forms.TextBox();
            this.txtAccount = new System.Windows.Forms.TextBox();
            this.Account = new System.Windows.Forms.Label();
            this.Pool = new System.Windows.Forms.Label();
            this.ddlGPU = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnSaveConfig = new System.Windows.Forms.Button();
            this.cbStartUp = new System.Windows.Forms.CheckBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.btnAddPool = new System.Windows.Forms.Button();
            this.ddlPool = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.lbUnpaidCount = new System.Windows.Forms.Label();
            this.lbPaidIn24hCount = new System.Windows.Forms.Label();
            this.lbEarnedCount = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btnStartMining
            // 
            this.btnStartMining.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(33)))), ((int)(((byte)(79)))));
            this.btnStartMining.FlatAppearance.BorderSize = 0;
            this.btnStartMining.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(183)))), ((int)(((byte)(0)))), ((int)(((byte)(38)))));
            this.btnStartMining.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(228)))), ((int)(((byte)(104)))), ((int)(((byte)(129)))));
            this.btnStartMining.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnStartMining.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.btnStartMining.ForeColor = System.Drawing.Color.White;
            this.btnStartMining.Location = new System.Drawing.Point(141, 149);
            this.btnStartMining.Name = "btnStartMining";
            this.btnStartMining.Size = new System.Drawing.Size(471, 32);
            this.btnStartMining.TabIndex = 6;
            this.btnStartMining.Text = "Start Mining";
            this.btnStartMining.UseVisualStyleBackColor = false;
            this.btnStartMining.Click += new System.EventHandler(this.btnStartMining_Click);
            // 
            // txtCmdOutput
            // 
            this.txtCmdOutput.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(46)))), ((int)(((byte)(52)))));
            this.txtCmdOutput.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.txtCmdOutput.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.txtCmdOutput.ForeColor = System.Drawing.Color.White;
            this.txtCmdOutput.Location = new System.Drawing.Point(12, 225);
            this.txtCmdOutput.Multiline = true;
            this.txtCmdOutput.Name = "txtCmdOutput";
            this.txtCmdOutput.ReadOnly = true;
            this.txtCmdOutput.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtCmdOutput.Size = new System.Drawing.Size(600, 185);
            this.txtCmdOutput.TabIndex = 10;
            // 
            // txtAccount
            // 
            this.txtAccount.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(46)))), ((int)(((byte)(52)))));
            this.txtAccount.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtAccount.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.txtAccount.ForeColor = System.Drawing.Color.White;
            this.txtAccount.Location = new System.Drawing.Point(133, 19);
            this.txtAccount.Name = "txtAccount";
            this.txtAccount.Size = new System.Drawing.Size(479, 21);
            this.txtAccount.TabIndex = 0;
            // 
            // Account
            // 
            this.Account.AutoSize = true;
            this.Account.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.Account.ForeColor = System.Drawing.Color.White;
            this.Account.Location = new System.Drawing.Point(12, 22);
            this.Account.Name = "Account";
            this.Account.Size = new System.Drawing.Size(47, 12);
            this.Account.TabIndex = 12;
            this.Account.Text = "Account";
            // 
            // Pool
            // 
            this.Pool.AutoSize = true;
            this.Pool.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.Pool.ForeColor = System.Drawing.Color.White;
            this.Pool.Location = new System.Drawing.Point(12, 55);
            this.Pool.Name = "Pool";
            this.Pool.Size = new System.Drawing.Size(53, 12);
            this.Pool.TabIndex = 12;
            this.Pool.Text = "Pool Url";
            // 
            // ddlGPU
            // 
            this.ddlGPU.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(46)))), ((int)(((byte)(52)))));
            this.ddlGPU.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ddlGPU.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.ddlGPU.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.ddlGPU.ForeColor = System.Drawing.Color.White;
            this.ddlGPU.FormattingEnabled = true;
            this.ddlGPU.Items.AddRange(new object[] {
            "NVIDIA",
            "AMD"});
            this.ddlGPU.Location = new System.Drawing.Point(133, 85);
            this.ddlGPU.Name = "ddlGPU";
            this.ddlGPU.Size = new System.Drawing.Size(121, 20);
            this.ddlGPU.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label1.ForeColor = System.Drawing.Color.White;
            this.label1.Location = new System.Drawing.Point(12, 88);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(53, 12);
            this.label1.TabIndex = 12;
            this.label1.Text = "GPU Type";
            // 
            // btnSaveConfig
            // 
            this.btnSaveConfig.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(33)))), ((int)(((byte)(79)))));
            this.btnSaveConfig.FlatAppearance.BorderSize = 0;
            this.btnSaveConfig.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(183)))), ((int)(((byte)(0)))), ((int)(((byte)(38)))));
            this.btnSaveConfig.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(228)))), ((int)(((byte)(104)))), ((int)(((byte)(129)))));
            this.btnSaveConfig.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSaveConfig.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.btnSaveConfig.ForeColor = System.Drawing.Color.White;
            this.btnSaveConfig.Location = new System.Drawing.Point(12, 149);
            this.btnSaveConfig.Name = "btnSaveConfig";
            this.btnSaveConfig.Size = new System.Drawing.Size(123, 32);
            this.btnSaveConfig.TabIndex = 5;
            this.btnSaveConfig.Text = "Save Config";
            this.btnSaveConfig.UseVisualStyleBackColor = false;
            this.btnSaveConfig.Click += new System.EventHandler(this.btnSaveConfig_Click);
            // 
            // cbStartUp
            // 
            this.cbStartUp.AutoSize = true;
            this.cbStartUp.ForeColor = System.Drawing.Color.White;
            this.cbStartUp.Location = new System.Drawing.Point(133, 118);
            this.cbStartUp.Name = "cbStartUp";
            this.cbStartUp.Size = new System.Drawing.Size(150, 16);
            this.cbStartUp.TabIndex = 4;
            this.cbStartUp.Text = "Start Up With Windows";
            this.cbStartUp.UseVisualStyleBackColor = true;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label2.ForeColor = System.Drawing.Color.White;
            this.label2.Location = new System.Drawing.Point(12, 119);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(53, 12);
            this.label2.TabIndex = 12;
            this.label2.Text = "Start Up";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.ForeColor = System.Drawing.Color.DarkGray;
            this.label3.Location = new System.Drawing.Point(237, 416);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(155, 12);
            this.label3.TabIndex = 15;
            this.label3.Text = "@Copyright 2018, XAGC Dev";
            this.label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // btnAddPool
            // 
            this.btnAddPool.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(33)))), ((int)(((byte)(79)))));
            this.btnAddPool.FlatAppearance.BorderSize = 0;
            this.btnAddPool.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(183)))), ((int)(((byte)(0)))), ((int)(((byte)(38)))));
            this.btnAddPool.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(228)))), ((int)(((byte)(104)))), ((int)(((byte)(129)))));
            this.btnAddPool.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnAddPool.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.btnAddPool.ForeColor = System.Drawing.Color.White;
            this.btnAddPool.Location = new System.Drawing.Point(517, 52);
            this.btnAddPool.Name = "btnAddPool";
            this.btnAddPool.Size = new System.Drawing.Size(95, 21);
            this.btnAddPool.TabIndex = 2;
            this.btnAddPool.Text = "Add Pool";
            this.btnAddPool.UseVisualStyleBackColor = false;
            this.btnAddPool.Click += new System.EventHandler(this.btnAddPool_Click);
            // 
            // ddlPool
            // 
            this.ddlPool.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(46)))), ((int)(((byte)(46)))), ((int)(((byte)(52)))));
            this.ddlPool.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ddlPool.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.ddlPool.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.ddlPool.ForeColor = System.Drawing.Color.White;
            this.ddlPool.FormattingEnabled = true;
            this.ddlPool.ItemHeight = 12;
            this.ddlPool.Location = new System.Drawing.Point(133, 52);
            this.ddlPool.Name = "ddlPool";
            this.ddlPool.Size = new System.Drawing.Size(378, 20);
            this.ddlPool.TabIndex = 16;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label4.ForeColor = System.Drawing.Color.White;
            this.label4.Location = new System.Drawing.Point(12, 198);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(41, 12);
            this.label4.TabIndex = 12;
            this.label4.Text = "Unpaid";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label5.ForeColor = System.Drawing.Color.White;
            this.label5.Location = new System.Drawing.Point(206, 198);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(71, 12);
            this.label5.TabIndex = 12;
            this.label5.Text = "Paid in 24h";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.label6.ForeColor = System.Drawing.Color.White;
            this.label6.Location = new System.Drawing.Point(420, 198);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(41, 12);
            this.label6.TabIndex = 12;
            this.label6.Text = "Earned";
            // 
            // lbUnpaidCount
            // 
            this.lbUnpaidCount.AutoSize = true;
            this.lbUnpaidCount.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.lbUnpaidCount.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(180)))), ((int)(((byte)(27)))));
            this.lbUnpaidCount.Location = new System.Drawing.Point(69, 198);
            this.lbUnpaidCount.Name = "lbUnpaidCount";
            this.lbUnpaidCount.Size = new System.Drawing.Size(41, 12);
            this.lbUnpaidCount.TabIndex = 12;
            this.lbUnpaidCount.Text = "0.0000";
            // 
            // lbPaidIn24hCount
            // 
            this.lbPaidIn24hCount.AutoSize = true;
            this.lbPaidIn24hCount.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.lbPaidIn24hCount.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(180)))), ((int)(((byte)(27)))));
            this.lbPaidIn24hCount.Location = new System.Drawing.Point(294, 198);
            this.lbPaidIn24hCount.Name = "lbPaidIn24hCount";
            this.lbPaidIn24hCount.Size = new System.Drawing.Size(41, 12);
            this.lbPaidIn24hCount.TabIndex = 12;
            this.lbPaidIn24hCount.Text = "0.0000";
            // 
            // lbEarnedCount
            // 
            this.lbEarnedCount.AutoSize = true;
            this.lbEarnedCount.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.lbEarnedCount.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(180)))), ((int)(((byte)(27)))));
            this.lbEarnedCount.Location = new System.Drawing.Point(480, 198);
            this.lbEarnedCount.Name = "lbEarnedCount";
            this.lbEarnedCount.Size = new System.Drawing.Size(41, 12);
            this.lbEarnedCount.TabIndex = 12;
            this.lbEarnedCount.Text = "0.0000";
            // 
            // Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(30)))), ((int)(((byte)(30)))), ((int)(((byte)(33)))));
            this.ClientSize = new System.Drawing.Size(624, 434);
            this.Controls.Add(this.ddlPool);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.cbStartUp);
            this.Controls.Add(this.ddlGPU);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.Pool);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.lbEarnedCount);
            this.Controls.Add(this.lbPaidIn24hCount);
            this.Controls.Add(this.lbUnpaidCount);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.Account);
            this.Controls.Add(this.txtAccount);
            this.Controls.Add(this.txtCmdOutput);
            this.Controls.Add(this.btnAddPool);
            this.Controls.Add(this.btnSaveConfig);
            this.Controls.Add(this.btnStartMining);
            this.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "Main";
            this.Text = "XAGC-AutoMiner";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.Main_FormClosed);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnStartMining;
        private System.Windows.Forms.TextBox txtCmdOutput;
        private System.Windows.Forms.TextBox txtAccount;
        private System.Windows.Forms.Label Account;
        private System.Windows.Forms.Label Pool;
        private System.Windows.Forms.ComboBox ddlGPU;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnSaveConfig;
        private System.Windows.Forms.CheckBox cbStartUp;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button btnAddPool;
        private System.Windows.Forms.ComboBox ddlPool;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label lbUnpaidCount;
        private System.Windows.Forms.Label lbPaidIn24hCount;
        private System.Windows.Forms.Label lbEarnedCount;
    }
}


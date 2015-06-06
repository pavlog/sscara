namespace WindowsFormsApplication1
{
    partial class Form1
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
            this.textBoxd = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.textBoxl = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.textBoxLL = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.panel2 = new System.Windows.Forms.Panel();
            this.label3 = new System.Windows.Forms.Label();
            this.textMaxq1 = new System.Windows.Forms.TextBox();
            this.textMaxq2 = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.textMinq2 = new System.Windows.Forms.TextBox();
            this.minq2ww = new System.Windows.Forms.Label();
            this.textMinq1 = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.textDeltaq2 = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.textDeltaq1 = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label9 = new System.Windows.Forms.Label();
            this.textBoxYOffs = new System.Windows.Forms.TextBox();
            this.label10 = new System.Windows.Forms.Label();
            this.textBoxW = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            this.textBoxH = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // textBoxd
            // 
            this.textBoxd.Location = new System.Drawing.Point(608, 311);
            this.textBoxd.Name = "textBoxd";
            this.textBoxd.Size = new System.Drawing.Size(87, 20);
            this.textBoxd.TabIndex = 0;
            this.textBoxd.Text = "0";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(589, 314);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(13, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "d";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(583, 340);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(9, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "l";
            // 
            // textBoxl
            // 
            this.textBoxl.Location = new System.Drawing.Point(608, 337);
            this.textBoxl.Name = "textBoxl";
            this.textBoxl.Size = new System.Drawing.Size(87, 20);
            this.textBoxl.TabIndex = 3;
            this.textBoxl.Text = "70";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(583, 366);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(13, 13);
            this.label5.TabIndex = 8;
            this.label5.Text = "L";
            // 
            // textBoxLL
            // 
            this.textBoxLL.Location = new System.Drawing.Point(608, 363);
            this.textBoxLL.Name = "textBoxLL";
            this.textBoxLL.Size = new System.Drawing.Size(87, 20);
            this.textBoxLL.TabIndex = 7;
            this.textBoxLL.Text = "80";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(855, 333);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 27);
            this.button1.TabIndex = 11;
            this.button1.Text = "Calculate";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.White;
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel2.Location = new System.Drawing.Point(12, 12);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(514, 468);
            this.panel2.TabIndex = 12;
            this.panel2.Paint += new System.Windows.Forms.PaintEventHandler(this.panel2_Paint);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(583, 404);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(44, 13);
            this.label3.TabIndex = 13;
            this.label3.Text = "Max Q1";
            // 
            // textMaxq1
            // 
            this.textMaxq1.Location = new System.Drawing.Point(633, 401);
            this.textMaxq1.Name = "textMaxq1";
            this.textMaxq1.ReadOnly = true;
            this.textMaxq1.Size = new System.Drawing.Size(100, 20);
            this.textMaxq1.TabIndex = 14;
            this.textMaxq1.TextChanged += new System.EventHandler(this.textBox3_TextChanged);
            // 
            // textMaxq2
            // 
            this.textMaxq2.Location = new System.Drawing.Point(800, 402);
            this.textMaxq2.Name = "textMaxq2";
            this.textMaxq2.ReadOnly = true;
            this.textMaxq2.Size = new System.Drawing.Size(100, 20);
            this.textMaxq2.TabIndex = 16;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(750, 405);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(44, 13);
            this.label4.TabIndex = 15;
            this.label4.Text = "Max Q2";
            // 
            // textMinq2
            // 
            this.textMinq2.Location = new System.Drawing.Point(800, 428);
            this.textMinq2.Name = "textMinq2";
            this.textMinq2.ReadOnly = true;
            this.textMinq2.Size = new System.Drawing.Size(100, 20);
            this.textMinq2.TabIndex = 20;
            // 
            // minq2ww
            // 
            this.minq2ww.AutoSize = true;
            this.minq2ww.Location = new System.Drawing.Point(750, 431);
            this.minq2ww.Name = "minq2ww";
            this.minq2ww.Size = new System.Drawing.Size(41, 13);
            this.minq2ww.TabIndex = 19;
            this.minq2ww.Text = "Min Q2";
            // 
            // textMinq1
            // 
            this.textMinq1.Location = new System.Drawing.Point(633, 427);
            this.textMinq1.Name = "textMinq1";
            this.textMinq1.ReadOnly = true;
            this.textMinq1.Size = new System.Drawing.Size(100, 20);
            this.textMinq1.TabIndex = 18;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(583, 430);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(41, 13);
            this.label7.TabIndex = 17;
            this.label7.Text = "Min Q1";
            // 
            // textDeltaq2
            // 
            this.textDeltaq2.Location = new System.Drawing.Point(800, 458);
            this.textDeltaq2.Name = "textDeltaq2";
            this.textDeltaq2.ReadOnly = true;
            this.textDeltaq2.Size = new System.Drawing.Size(100, 20);
            this.textDeltaq2.TabIndex = 24;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(750, 461);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(49, 13);
            this.label6.TabIndex = 23;
            this.label6.Text = "Delta Q2";
            // 
            // textDeltaq1
            // 
            this.textDeltaq1.Location = new System.Drawing.Point(633, 457);
            this.textDeltaq1.Name = "textDeltaq1";
            this.textDeltaq1.ReadOnly = true;
            this.textDeltaq1.Size = new System.Drawing.Size(100, 20);
            this.textDeltaq1.TabIndex = 22;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(583, 460);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(49, 13);
            this.label8.TabIndex = 21;
            this.label8.Text = "Delta Q1";
            // 
            // panel1
            // 
            this.panel1.BackgroundImage = global::SScaraVisualizer.Properties.Resources.Scheme1;
            this.panel1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.panel1.Location = new System.Drawing.Point(586, 12);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(351, 286);
            this.panel1.TabIndex = 1;
            this.panel1.Paint += new System.Windows.Forms.PaintEventHandler(this.panel1_Paint);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(711, 314);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(33, 13);
            this.label9.TabIndex = 26;
            this.label9.Text = "YOffs";
            // 
            // textBoxYOffs
            // 
            this.textBoxYOffs.Location = new System.Drawing.Point(753, 311);
            this.textBoxYOffs.Name = "textBoxYOffs";
            this.textBoxYOffs.Size = new System.Drawing.Size(79, 20);
            this.textBoxYOffs.TabIndex = 25;
            this.textBoxYOffs.Text = "20";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(711, 340);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(37, 13);
            this.label10.TabIndex = 28;
            this.label10.Text = "BedW";
            // 
            // textBoxW
            // 
            this.textBoxW.Location = new System.Drawing.Point(753, 337);
            this.textBoxW.Name = "textBoxW";
            this.textBoxW.Size = new System.Drawing.Size(79, 20);
            this.textBoxW.TabIndex = 27;
            this.textBoxW.Text = "100";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(711, 366);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(34, 13);
            this.label11.TabIndex = 30;
            this.label11.Text = "BedH";
            // 
            // textBoxH
            // 
            this.textBoxH.Location = new System.Drawing.Point(753, 363);
            this.textBoxH.Name = "textBoxH";
            this.textBoxH.Size = new System.Drawing.Size(79, 20);
            this.textBoxH.TabIndex = 29;
            this.textBoxH.Text = "100";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(942, 483);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.textBoxH);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.textBoxW);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.textBoxYOffs);
            this.Controls.Add(this.textDeltaq2);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.textDeltaq1);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.textMinq2);
            this.Controls.Add(this.minq2ww);
            this.Controls.Add(this.textMinq1);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.textMaxq2);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.textMaxq1);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.textBoxLL);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.textBoxl);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.textBoxd);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textBoxd;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textBoxl;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox textBoxLL;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox textMaxq1;
        private System.Windows.Forms.TextBox textMaxq2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox textMinq2;
        private System.Windows.Forms.Label minq2ww;
        private System.Windows.Forms.TextBox textMinq1;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox textDeltaq2;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox textDeltaq1;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox textBoxYOffs;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox textBoxW;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.TextBox textBoxH;
    }
}


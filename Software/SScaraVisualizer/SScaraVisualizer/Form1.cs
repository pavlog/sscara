using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        float maxAngleLeft = -10000;
        float maxAngleRight = -10000;
        float minAngleLeft = 10000;
        float minAngleRight = 10000;

        public double AnglesDist(double sourceA,double targetA)
        {
            double a = sourceA - targetA;
            return a;// (a + 180) % 360 - 180;
        }

        public double ConvertToDegree(double angle)
        {
            return (180/Math.PI) * angle;
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {
            //e.Graphics.DrawEllipse(Pens.AliceBlue, 0, 0, 100, 100);
            float minY = 0;
            float maxY = 150;
            float stepY = 1;
            float l = float.Parse(textBoxl.Text);
            float L = float.Parse(textBoxLL.Text);
            float d = float.Parse(textBoxd.Text);
            float bottomOffset = 10;
            float stepSize = (float)Math.Floor((panel2.Size.Height - bottomOffset) / (maxY - minY));
            float dhalf = d / 2;
            float l2 = l * l;
            float L2 = L * L;
            float bedW = 100;
            float bedH = 100;
            float bedYOffset = float.Parse(textBoxYOffs.Text);
            float minX = -bedW/2-5;
            float maxX = bedW / 2 + 5;
            float stepX = 1;
            maxAngleLeft = -10000;
            maxAngleRight = -10000;
            minAngleLeft = 10000;
            minAngleRight = 10000;
            minY = bedYOffset-5;
            maxY = bedYOffset+bedH+5;

            //panel1.Size.Width/2+x * 5, panel1.Size.Height/2
            ///*
            for (float x = minX; x<maxX; x += stepX)
            {
            for (float y = minY; y<maxY; y += stepY)
            {
                NewMethod(e, l, bottomOffset, stepSize, dhalf, l2, L2, x, y,false);
            }
            }
            //*/
            //NewMethod(e, l, bottomOffset, stepSize, dhalf, l2, L2, -50, 50);
            //NewMethod(e, l, bottomOffset, stepSize, dhalf, l2, L2, 50, 50);
            //NewMethod(e, l, bottomOffset, stepSize, dhalf, l2, L2, -10, 5);
            //NewMethod(e, l, bottomOffset, stepSize, dhalf, l2, L2, 10, 5);
            e.Graphics.DrawLine(Pens.Black, new PointF(panel2.Size.Width / 2.0f, 0), new PointF(panel2.Size.Width / 2.0f, panel2.Size.Height));
            NewMethod(e, l, bottomOffset, stepSize, dhalf, l2, L2, -50, bedYOffset + bedH, true);
            NewMethod(e, l, bottomOffset, stepSize, dhalf, l2, L2, -50, bedYOffset, true);
            NewMethod(e, l, bottomOffset, stepSize, dhalf, l2, L2, 50, bedYOffset + bedH, true);
            NewMethod(e, l, bottomOffset, stepSize, dhalf, l2, L2, 50, bedYOffset, true);
            e.Graphics.DrawRectangle(Pens.Orange, panel2.Size.Width / 2 + (-bedW / 2) * stepSize - stepSize / 2, panel2.Size.Height - 0 * stepSize - stepSize / 2 - bottomOffset - bedYOffset * stepSize - bedH * stepSize, bedW * stepSize, bedH * stepSize);
            textMaxq1.Text = ConvertToDegree(maxAngleRight).ToString();
            textMaxq2.Text = ConvertToDegree(maxAngleLeft).ToString();
            textMinq1.Text = ConvertToDegree(minAngleRight).ToString();
            textMinq2.Text = ConvertToDegree(minAngleLeft).ToString();
            textDeltaq1.Text = ConvertToDegree(AnglesDist(maxAngleRight,minAngleRight)).ToString();
            textDeltaq2.Text = ConvertToDegree(AnglesDist(maxAngleLeft,minAngleLeft)).ToString();
        }

        private void NewMethod(PaintEventArgs e, float l, float bottomOffset, float stepSize, float dhalf, float l2, float L2, float x, float y,bool bDrawArm)
        {
            float A = -2 * l * (x - dhalf);
            float B = -2 * y * l;
            float C = (x - dhalf) * (x - dhalf) + y * y + l2 - L2;
            float F = (x + dhalf) * (x + dhalf) + y * y + l2 - L2;
            float E = -2  * l * (x+dhalf);
            float Det1 = B * B - (C * C - A * A);
            float Det2 = B * B - (F * F - E * E);
            Pen pen = Pens.Black;
            if ( Det1 < 0 || Det2 < 0 )
            {
                pen = Pens.Red;
            }
            else if (Det1 == 0)
            {
                pen = Pens.Yellow;
            }
            else
            {
                pen = Pens.Green;
                float qq11 = (-B - (float)Math.Sqrt(Det1)) / (C - A);
                float q11 = 2 * (float)Math.Atan(qq11);
                float qq12 = (-B + (float)Math.Sqrt(Det1)) / (C - A);
                float q12 = 2 * (float)Math.Atan(qq12);

                float qq21 = (-B - (float)Math.Sqrt(Det2)) / (F - E);
                float q21 = 2 * (float)Math.Atan(qq21);
                float qq22 = (-B + (float)Math.Sqrt(Det2)) / (F - E);
                float q22 = 2 * (float)Math.Atan(qq22);

                /*
                if (q11 < 0)
                {
                    pen = Pens.Red;
                }
                if (q12 < 0)
                {
                    pen = Pens.Red;
                }
                */
                float xd = -dhalf + l * (float)Math.Cos(q22);
                float yd = l * (float)Math.Sin(q22);
                if (q22 < 0)
                {
                    q22 = (float)Math.PI * 2 + q22;
                }
                if (q22 > maxAngleLeft)
                {
                    maxAngleLeft = q22;
                }
                if (q22 < minAngleLeft)
                {
                    minAngleLeft = q22;
                }
                ///*
                float xb = dhalf + l * (float)Math.Cos(q11);
                float yb = l * (float)Math.Sin(q11);
                if ((xd-x) * (yb-y) - (yd-y) * (xb-x) < 0)
                {
                    pen = Pens.Blue;
                }
                //if (q11 < 0)
                //{
                 //   q11 = (float)Math.PI * 2 + q11;
                //}
                if (q11 > maxAngleRight)
                {
                    maxAngleRight = q11;
                }
                if (q11 < minAngleRight)
                {
                    minAngleRight = q11;
                }
                if (bDrawArm)
                {
                    e.Graphics.DrawLine(pen,
                        new PointF(panel2.Size.Width / 2 + (-dhalf) * stepSize - stepSize / 2, panel2.Size.Height - 0 * stepSize - stepSize / 2 - bottomOffset),
                        new PointF(panel2.Size.Width / 2 + (xd) * stepSize - stepSize / 2, panel2.Size.Height - yd * stepSize - stepSize / 2 - bottomOffset));
                    e.Graphics.DrawLine(pen,
                        new PointF(panel2.Size.Width / 2 + (x) * stepSize - stepSize / 2, panel2.Size.Height - y * stepSize - stepSize / 2 - bottomOffset),
                        new PointF(panel2.Size.Width / 2 + (xd) * stepSize - stepSize / 2, panel2.Size.Height - yd * stepSize - stepSize / 2 - bottomOffset));
                    e.Graphics.DrawLine(pen,
                        new PointF(panel2.Size.Width / 2 + (dhalf) * stepSize - stepSize / 2, panel2.Size.Height - 0 * stepSize - stepSize / 2 - bottomOffset),
                        new PointF(panel2.Size.Width / 2 + (xb) * stepSize - stepSize / 2, panel2.Size.Height - yb * stepSize - stepSize / 2 - bottomOffset));
                    e.Graphics.DrawLine(pen,
                        new PointF(panel2.Size.Width / 2 + (x) * stepSize - stepSize / 2, panel2.Size.Height - y * stepSize - stepSize / 2 - bottomOffset),
                        new PointF(panel2.Size.Width / 2 + (xb) * stepSize - stepSize / 2, panel2.Size.Height - yb * stepSize - stepSize / 2 - bottomOffset));
                }
            }

            
            
            e.Graphics.DrawRectangle(pen, panel2.Size.Width / 2 + x * stepSize - stepSize / 2, panel2.Size.Height - y * stepSize - stepSize / 2 - bottomOffset, stepSize, stepSize);
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            panel2.Invalidate();
        }
    }
}

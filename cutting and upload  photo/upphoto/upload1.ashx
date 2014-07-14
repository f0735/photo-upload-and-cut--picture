<%@ WebHandler Language="C#" CodeBehind="upload1.ashx.cs" Class="upload1" %>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;

    /// <summary>
    /// upload1 的摘要说明
    /// </summary>
    public class upload1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
        if (context.Request["data"] != null)
        {
            String FileName = context.Request["FileName"];
            String Directory = context.Request["Directory"];
            int width = Convert.ToInt32(context.Request["width"]);
            int height = Convert.ToInt32(context.Request["height"]);
            string[] data = context.Request["data"].Split(',');
            System.Drawing.Bitmap bt = new System.Drawing.Bitmap(width, height, System.Drawing.Imaging.PixelFormat.Format32bppRgb);
            int pos = 0;
            for (int y = 0; y < height; y++)
            {
                for (int x = 0; x < width; x++)
                {
                    bt.SetPixel(x, y, System.Drawing.Color.FromArgb(int.Parse(data[pos], System.Globalization.NumberStyles.HexNumber)));
                    pos++;
                }
            }
            bt.Save(context.Server.MapPath("../"+Directory+FileName), System.Drawing.Imaging.ImageFormat.Jpeg);
            context.Response.Write("../"+Directory+FileName+"?ss=" + DateTime.Now.Ticks.ToString());
            context.Response.End();

            return;
        }
            
        }

        

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

<%@ WebHandler Language="C#" CodeBehind="upimg.ashx.cs" Class="upimg" %>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using System.IO;


    /// <summary>
    /// upimg 的摘要说明
    /// </summary>
    public class upimg : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
             String action = context.Request.QueryString["action"];
            if (String.IsNullOrEmpty( action ))
            {
                action = context.Request.Form["action"];
            }
            switch (action)
            {
                case "Draw":
                    Draw();
                    break;
                case "upload":
                    upload();
                    break;
            }
            
        }
        

        //上传图片
        public void upload() 
        {

            HttpPostedFile Pic = HttpContext.Current.Request.Files["Pic"];
            String Directory = HttpContext.Current.Request["Directory"];
            String FileName = HttpContext.Current.Request["FileName"];
            String HW = HttpContext.Current.Request["HW"];
            String ImgW = HttpContext.Current.Request["ImgW"];
            String ImgH = HttpContext.Current.Request["ImgH"];
            string uploadPath = HttpContext.Current.Server.MapPath("~/" + Directory+ FileName);
            string uploadtemp = HttpContext.Current.Server.MapPath("~/" + Directory+"temp"+ FileName);
            if (Pic == null)
            {
                return;
            }
            Pic.SaveAs(uploadPath);
            if (HW != "" && ImgH != "" && ImgW != "")
            {
                //按图片宽和高获得图片缩略图
                MakeThumbnail(uploadPath,uploadtemp,Convert.ToInt32(ImgW),Convert.ToInt32(ImgH),HW);
                //删除原文件
                File.Delete(uploadPath);
                //将备份文件重命名为新文件
                File.Move(uploadtemp, uploadPath);
            }
            Obj obj = new Obj();
            obj.State = 1;
            obj.Str = "../" + Directory + FileName + "?ss=" + DateTime.Now.Ticks.ToString();
            HttpContext.Current.Response.Write(JsonConvert.SerializeObject(obj));  //写入服务器端并持久序列化该对象
            
        }

        //剪切图片
        public void Draw()
        {
            String txtX =HttpContext.Current.Request["txtX"];
            String txtY = HttpContext.Current.Request["txtY"];
            String txtX2 = HttpContext.Current.Request["txtX2"];
            String txtY2 = HttpContext.Current.Request["txtY2"];
            String Directory = HttpContext.Current.Request["Directory"];
            String FileName = HttpContext.Current.Request["FileName"];
            string uploadPath = HttpContext.Current.Server.MapPath("~/" + Directory + FileName);
            string uploadtemp = HttpContext.Current.Server.MapPath("~/" + Directory + "temp" + FileName);
            if (txtX.Trim() != "" && txtY.Trim() != "" && txtX2.Trim() != "" && txtY2.Trim() != "")
            {
                int x1 = int.Parse(txtX);
                int y1 = int.Parse(txtY);
                int x2 = int.Parse(txtX2);
                int y2 = int.Parse(txtY2);
                DrawImage(uploadPath, uploadtemp, x1, y1, x2 - x1, y2 - y1);
                Obj obj = new Obj();
                obj.State = 1;
                obj.Str = "../" + Directory + "temp" +FileName + "?ss=" + DateTime.Now.Ticks.ToString();
                HttpContext.Current.Response.Write(JsonConvert.SerializeObject(obj));
            }
            else
            {
                Obj obj = new Obj();
                obj.State = 0;
                obj.Str = "请先选择要剪切的部分";
                HttpContext.Current.Response.Write(JsonConvert.SerializeObject(obj));
            }
        }
        
        /// <summary>
        /// 裁剪图片
        /// </summary>
        protected void DrawImage(string srcImage, string destImage, int x, int y, int width, int height)
        {
            using (System.Drawing.Image sourceImage = System.Drawing.Image.FromFile(srcImage))
            {
                using (System.Drawing.Image templateImage = new System.Drawing.Bitmap(width, height))
                {
                    using (System.Drawing.Graphics templateGraphics = System.Drawing.Graphics.FromImage(templateImage))
                    {
                        templateGraphics.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
                        templateGraphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                        templateGraphics.DrawImage(sourceImage, new System.Drawing.Rectangle(0, 0, width, height), new System.Drawing.Rectangle(x, y, width, height), System.Drawing.GraphicsUnit.Pixel);
                        templateImage.Save(destImage, System.Drawing.Imaging.ImageFormat.Jpeg);
                    }
                }
            }

        }

        /// <summary>
        /// 生成缩略图
        /// </summary>
        /// <param name="originalImagePath">源图路径（物理路径）</param>
        /// <param name="thumbnailPath">缩略图路径（物理路径）</param>
        /// <param name="width">缩略图宽度</param>
        /// <param name="height">缩略图高度</param>
        /// <param name="mode">生成缩略图的方式</param> 
        public static void MakeThumbnail(string originalImagePath, string thumbnailPath, int width, int height, string mode)
        {
            System.Drawing.Image originalImage = System.Drawing.Image.FromFile(originalImagePath);

            int towidth = width;
            int toheight = height;

            int x = 0;
            int y = 0;
            int ow = originalImage.Width;
            int oh = originalImage.Height;

            switch (mode)
            {
                case "HW"://指定高宽缩放（可能变形） 
                    break;
                case "W"://指定宽，高按比例 
                    toheight = originalImage.Height * width / originalImage.Width;
                    break;
                case "H"://指定高，宽按比例
                    towidth = originalImage.Width * height / originalImage.Height;
                    break;
                case "Cut"://指定高宽裁减（不变形） 
                    if ((double)originalImage.Width / (double)originalImage.Height > (double)towidth / (double)toheight)
                    {
                        oh = originalImage.Height;
                        ow = originalImage.Height * towidth / toheight;
                        y = 0;
                        x = (originalImage.Width - ow) / 2;
                    }
                    else
                    {
                        ow = originalImage.Width;
                        oh = originalImage.Width * height / towidth;
                        x = 0;
                        y = (originalImage.Height - oh) / 2;
                    }
                    break;
                default:
                    break;
            }

            //新建一个bmp图片
            System.Drawing.Image bitmap = new System.Drawing.Bitmap(towidth, toheight);

            //新建一个画板
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bitmap);

            //设置高质量插值法
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;

            //设置高质量,低速度呈现平滑程度
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;

            //清空画布并以透明背景色填充
            g.Clear(System.Drawing.Color.Transparent);

            //在指定位置并且按指定大小绘制原图片的指定部分
            g.DrawImage(originalImage, new System.Drawing.Rectangle(0, 0, towidth, toheight),
            new System.Drawing.Rectangle(x, y, ow, oh),
            System.Drawing.GraphicsUnit.Pixel);

            try
            {
                //以jpg格式保存缩略图
                bitmap.Save(thumbnailPath, System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            catch (System.Exception e)
            {
                throw e;
            }
            finally
            {
                originalImage.Dispose();
                bitmap.Dispose();
                g.Dispose();
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
    public class Obj
    {
        private int state;
        private string str;


        public int State
        {
            set { state = value; }
            get { return state; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Str
        {
            set { str = value; }
            get { return str; }
        }

    }

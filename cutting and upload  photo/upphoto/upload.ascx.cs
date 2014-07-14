using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

    public partial class upload : System.Web.UI.UserControl
    {
        /// <summary>
        /// flash高度
        /// </summary>
        public String FlashH { get; set; }
        /// <summary>
        /// flash宽度
        /// </summary>
        public String FlashW { get; set; }
        /// <summary>
        /// 文件名(如:1.jpg)
        /// </summary>
        public String FileName { get; set; }
        /// <summary>
        /// 存放目录(如:file/)
        /// </summary>
        public String Directory { get; set; }
        /// <summary>
        /// flash上传图片时提交的网页地址
        /// </summary>
        public String FlashPostUrl{get;set;}
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (FlashH != null)
                hdFlashH.Value = FlashH;
            if (FlashW != null)
                hdFlashW.Value = FlashW;
            if (FileName != null)
            hdFileName.Value=FileName;
            if (Directory != null)
                hdDirectory.Value = Directory;
            if (FlashPostUrl!=null)
            hdFlashPostUrl.Value = FlashPostUrl;
        }
       
    }

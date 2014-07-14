using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

namespace UserControl
{
    public partial class imgareaupload : System.Web.UI.UserControl
    {
         
        public delegate void function1(string str); 
        public function1 cUploadPost;
        /// <summary>
        /// case "HW"://指定高宽缩放（可能变形） 
        /// case "W"://指定宽，高按比例 
        /// case "H"://指定高，宽按比例
        /// case "Cut"://指定高宽裁减（不变形） 
        /// </summary>
        public String HW { get; set; }
        /// <summary>
        /// 图片宽度
        /// </summary>
        public String ImgW { get; set; }
        /// <summary>
        /// 图片高度
        /// </summary>
        public String ImgH { get; set; }
        /// <summary>
        /// 文件名(如:1.jpg)
        /// </summary>
        public String FileName { get; set; }
        /// <summary>
        /// 存放目录(如:file/)
        /// </summary>
        public String Directory { get; set; }     
        /// <summary>
        /// 截图缩放比例(如:4:3)
        /// </summary>
        public String AspectRatio { get; set; }
        /// <summary>
        /// 截图最大宽度
        /// </summary>
        public String MaxWidth { get; set; }
        /// <summary>
        /// 截图最大高度
        /// </summary>
        public String MaxHeight { get; set; }
        /// <summary>
        /// 截图最小宽度
        /// </summary>
        public String MinWidth { get; set; }
        /// <summary>
        /// 截图最小高度
        /// </summary>
        public String MinHeight { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (ImgH != null)
                    hdImgH.Value = ImgH;
                if (ImgW != null)
                    hdImgW.Value = ImgW;
                if (HW != null)
                    hdHW.Value = HW;
                if (FileName != null)
                    hdFileName.Value = FileName;
                if (Directory != null)
                    hdDirectory.Value = Directory;

                if (AspectRatio != null)
                    hdAspectRatio.Value = AspectRatio;
                if (MaxHeight != null)
                    hdMaxHeight.Value = MaxHeight;
                if (MaxWidth != null)
                    hdMaxWidth.Value = MaxWidth;
                if (MinHeight != null)
                    hdMinHeight.Value = MinHeight;
                if (MinWidth != null)
                    hdMinWidth.Value = MinWidth;
                
            }
        }
    }
}
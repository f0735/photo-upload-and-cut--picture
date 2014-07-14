<%@ Page Language="C#" AutoEventWireup="true" CodeFile="imgareaupload.aspx.cs" Inherits="imgareaupload" %>

<%@ Register src="~/upimg/imgareaupload.ascx" tagname="imgareaupload" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>图片上传剪切演示</title>
    <script src="../js/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../js/ajaxfileupload.js" type="text/javascript"></script>
    <link href="../imgareaselect/css/imgareaselect-default.css"  rel="stylesheet" type="text/css" />
    <script src="../imgareaselect/scripts/jquery.imgareaselect.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" enctype="multipart/form-data" runat="server">
    <div>
    
    </div>
    <uc1:imgareaupload ID="imgareaupload1" AspectRatio="4:3" Directory="file/" FileName="1.jpg" ImgH="300" ImgW="400" MinHeight="200" MinWidth="200"  HW="W" runat="server" />
    <input id="Button1" type="button" value="更改文件名" onclick="setFileName('2.jpg');" /><input id="Button2" type="button"
        value="获得结果图片路径" onclick="alert(getUrl());" />
    </form>
</body>
</html>

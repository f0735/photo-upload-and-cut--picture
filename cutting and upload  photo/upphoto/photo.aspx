<%@ Page Language="C#" AutoEventWireup="true" CodeFile="photo.aspx.cs" Inherits="photo" %>

<%@ Register src="upload.ascx" tagname="upload" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>视频拍照上传</title>
    <script src="../js/jquery-1.4.2.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    <uc1:upload ID="upload1"  FileName="1.jpg"  FlashH="270" FlashW="320" FlashPostUrl="upload1.ashx" Directory="file/" runat="server" />
    <input id="Button1" type="button" value="更改文件名" onclick="setFileName('2.jpg');" /><input id="Button2" type="button"
        value="获得结果图片路径" onclick="alert(getUrl());" />
    </form>
</body>
</html>

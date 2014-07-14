<%@ Control Language="C#" AutoEventWireup="true" CodeFile="upload.ascx.cs" Inherits="upload" %>
<asp:HiddenField ID="hdFileName" runat="server" />
<asp:HiddenField ID="hdDirectory" runat="server" />
<asp:HiddenField ID="hdFlashW" runat="server" />
<asp:HiddenField ID="hdFlashH" runat="server" />
<asp:HiddenField ID="hdFlashPostUrl" runat="server" />

<script type="text/javascript">
    $("#PhotoOnline").width($("input[id*=_hdFlashW]").val());
    $("#PhotoOnline").height($("input[id*=_hdFlashH]").val());
    //flash调用
    function GetPostUrl() {
        return $("input[id*=_hdFlashPostUrl]").val();
    }
    function GetFilePath() {
        return "FileName=" + $("input[id*=_hdFileName]").val() + "&Directory=" + $("input[id*=_hdDirectory]").val();
     }
     
    function upimg(url) {
        $("#img1").attr("src", url);
    }
    //-----------------------------------------------------------
    //父页面调用
    function setFileName(filename) {
        $("input[id*=_hdFileName]").val(filename);
    }
    function getUrl() {
       return $("#img1").attr("src");
    }

</script>
<table>
    <tr>
        <td valign=top>
            <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="320" height="270" id="PhotoOnline" align="middle">
				<param name="movie" value="Photo.swf" />
				<param name="quality" value="high" />
				<param name="bgcolor" value="#ffffff" />
				<param name="play" value="true" />
				<param name="loop" value="true" />
				<param name="wmode" value="window" />
				<param name="scale" value="showall" />
				<param name="menu" value="true" />
				<param name="devicefont" value="false" />
				<param name="salign" value="" />
				<param name="allowScriptAccess" value="sameDomain" />
				<!--[if !IE]>-->
				<object type="application/x-shockwave-flash" data="Photo.swf" width="320" height="260">
					<param name="movie" value="Photo.swf" />
					<param name="quality" value="high" />
					<param name="bgcolor" value="#ffffff" />
					<param name="play" value="true" />
					<param name="loop" value="true" />
					<param name="wmode" value="window" />
					<param name="scale" value="showall" />
					<param name="menu" value="true" />
					<param name="devicefont" value="false" />
					<param name="salign" value="" />
					<param name="allowScriptAccess" value="sameDomain" />
				<!--<![endif]-->
					<a href="http://www.adobe.com/go/getflash">
						<img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="获得 Adobe Flash Player" />
					</a>
				<!--[if !IE]>-->
				</object>
				<!--<![endif]-->
			</object>
        </td>
        <td valign=top>
        <img id="img1" alt="" src="../file/white.jpg" />
        </td>
        
    </tr>
    
</table>

             
        

